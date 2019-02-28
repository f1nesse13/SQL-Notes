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
    def self.all
    end

    def initialize(options)
    end

    def create
    end

    def update
    end

end