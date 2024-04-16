% Simple select
buchTypen():-
	findall(Rows, odbc_query(mydb, 'SELECT * FROM typ', Rows), All),
	writeln(All).
	
% Insert Book Type
insert_typ(Typname) :-
    atomic_list_concat(['INSERT INTO typ(name) VALUES (?)'], Query),
    odbc_prepare(mydb, Query, [varchar], Statement),
    odbc_execute(Statement, [Typname]),
    writeln('Book type added successfully!').
	
% Delete Book Type
% Predicate to delete the book type by ID
delete_typ(Id) :-
    atomic_list_concat(['DELETE FROM typ WHERE id = ', Id], Query),
    odbc_query(mydb, Query),
    writeln('Deletion successful.'),
    process_option(5).