% Simple select
buecher():-
	findall(Rows, odbc_query(mydb, 'SELECT b.id, b.name, a.vorname, a.nachname, t.name, b.ISBN, b.vorhanden FROM buch b INNER JOIN autor a ON b.autor = a.id INNER JOIN typ t ON b.typ = t.id', Rows), All),
	writeln(All).
	
% Insert Book
insert_buch(Name, Autor, Typ, ISBN):-
    atomic_list_concat(['INSERT INTO buch(name, autor, typ, ISBN) VALUES (?, ?, ?, ?)'], Query),
    odbc_prepare(mydb, Query, [varchar, integer, integer, integer], Statement),
    odbc_execute(Statement, [Name, Autor, Typ, ISBN]),
    writeln('Book added successfully!').
	
% Delete Book
process_delete_buch(1):-
	writeln('Please type in the ID of the book to delete: '),
	read(Id),
	catch(delete_buch_mitId(Id),Error,handle_delete_buch_error(Error)),
	process_option(5).
process_delete_buch(2):-
	writeln('Please type in the ISBN of the book to delete: '),
	read(ISBN),
	catch(delete_buch_mitISBN(ISBN),Error,handle_delete_buch_error(Error)),
	process_option(5).
process_delete_buch(_):-
	writeln('Invalid input!\n'),
	process_option(5).
	
handle_delete_buch_error(Error):-
	writeln('Error deleting the book:'),
	writeln(Error),
	writeln('\n').
	
% Predicate to search for the book with the given ISBN and return the ID
search_buch_mitISBN(ISBN, BuchId) :-
    atomic_list_concat(['SELECT id FROM buch WHERE ISBN = \'', ISBN, '\''], Query),
    odbc_query(mydb, Query, Rows),
    Rows = row(BuchId),
    writeln('Search successful.'),
    !.

% Predicate to delete the book by ID
delete_buch_mitId(Id):-
    atomic_list_concat(['DELETE FROM buch WHERE id = ', Id], Query),
    odbc_query(mydb, Query),
    writeln('Deletion successful.').

% Predicate to delete the book by ISBN
delete_buch_mitISBN(ISBN) :-
    search_buch_mitISBN(ISBN, BuchId),
    !,
    delete_buch_mitId(BuchId).
delete_buch_mitISBN(ISBN) :-
    writeln('No matching book found for deletion.').