-- ORM stands for Object Relational Mapping 

-- Introduction
-- Object-Relational Mapping (ORM) is a technique that lets you query and manipulate data from a database using an object-oriented paradigm. When talking about ORM, most people are referring to a library that implements the Object-Relational Mapping technique, hence the phrase "an ORM".

-- An ORM library is a completely ordinary library written in your language of choice that encapsulates the code needed to manipulate the data, so you don't use SQL anymore; you interact directly with an object in the same language you're using.

-- HIGH LEVEL API EXAMPLE
class Play
    ::all -- pulls all plays (class method)
    #initialize -- creates a instance of the play (does not save to our DB)
    #create -- takes the information from our instance and pushes it into the database
    #update -- updates data from the database
end