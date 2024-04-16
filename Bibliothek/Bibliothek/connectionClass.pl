% Establish a database connection
connection:-
    odbc_connect('NewProduct', _, [user('root'), password('password'), alias(mydb), open(once)]),
    writeln('Connection successful!\n').

% Disconnect from the database
disconnect :-
    odbc_disconnect(mydb),
    writeln('Disconnected successfully!\n').