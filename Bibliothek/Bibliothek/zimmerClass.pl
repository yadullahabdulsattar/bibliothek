% Simple select
zimmer():-
	findall(Rows, odbc_query(mydb, 'SELECT * FROM zimmer', Rows), All),
	writeln(All).

% Insert Room
insert_zimmer(Nummer, Etage) :-
    atomic_list_concat(['INSERT INTO zimmer(nummer, etage) VALUES (?, ?)'], Query),
    odbc_prepare(mydb, Query, [integer, integer], Statement),
    odbc_execute(Statement, [Nummer, Etage]),
    writeln('Room added successfully!'),
    !.
	
% Delete Room
% Predicate to delete the room by ID
delete_zimmer(Id) :-
    atomic_list_concat(['DELETE FROM zimmer WHERE id = ', Id], Query),
    odbc_query(mydb, Query),
    writeln('Deletion successful.'),
    process_option(5).