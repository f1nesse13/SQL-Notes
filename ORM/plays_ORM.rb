require 'singleton' # assures we only have one instance of our DB at any one time
require 'sqlite3'

class PlayDBConnection < SQLite3::Database
    include Singleton

    def initialize
        super('../SQL models/plays.db') # calls our Parent method and passes our DB file in
        self.type_translation = true # makes sure data types we pass in are returned the same way (ex. integers passes in are returned as integers and not string representations)
        self.results_as_hash = true # instead recieving Arrays we will receive hashs {column_name: value}
    end
end

class Play

    attr_accessor :title, :year, :playwright_id

    def self.all
        data = PlayDBConnection.instance.execute('SELECT * FROM plays')
        data.map { |datum| Play.new(datum) }
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @year = options['year']
        @playwright_id = options['playwright_id']
    end

    def create
        # heredoc - a heredoc is a way of embedding a multiline string while keeping format structure (<<- in ruby) - The SQL is convention but can be any name
        # sqlite3's execute also allows us to pass in our instance variables after we declare a heredoc
        raise "#{self} already in database" if @id
        PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id)
            INSERT INTO plays (title, year, playwright_id)
            VALUES (?, ?, ?) -- ?'s are bind arguments given by sqlite3 gem that will pull the variables from our arguments in order as well as sanitize them. The reason we do not use the actual variable names is to prevent SQL injection attacks - see below for explaination
            SQL
        # After inserting into our table we need to save the @id so we know that the value is in the database. We can assign the id using a special method
        @id = PlayDBConnection.instance.last_insert_row_id 
        # last_insert_row_id is a method given to us by the sqlite3 gem

    end

    # SQL Injection attacks - 
        # If we just pulled the values from our instance variables a malicious user could do damage to our database unless the passed arg is sanitized. 
        #     Ex. playwright_id == '3; DROP TABLE plays' - This would send the playwright_id, signal the end of a command then drop our plays table. SQL injection attacks are common and need to be defended against. A user could do a lot of damage to a app by dropping a user table etc. Essentially your giving users an oppurtunity to run any SQL commands they want without sanatizing it first

    def update
        raise "#{self} not in database" unless @id
        PlayDBConnection.instance.execute(<<-SQL, @title, @year, @playwright_id, @id)
        UPDATE plays
        SET title = ?, year = ?, playwright_id = ? WHERE id = ?
        SQL
    end

end

# We can now use our ORM to check our plays DB as well as create new entries or update existing ones
# Ex - salesman = Play.new("title" => "Death of a Salesman", "year" => 1948, "playwright_id = 1")
# salesman.create
