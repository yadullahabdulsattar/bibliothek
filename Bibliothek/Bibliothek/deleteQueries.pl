consult(autorClass.pl).
consult(buchTypClass.pl).
consult(buchClass.pl).
consult(studentClass.pl).
consult(buchungClass.pl).
consult(verleihenClass.pl).
consult(verwaltung.pl).

process_delete_options(0):-
	main_menu.

process_delete_options(1):-
	writeln('Please type in the ID of the author to delete: '),
	read(Id),
	catch(delete_autor(Id),Error,handle_delete_autor_error(Error)),
	process_option(5).
handle_delete_autor_error(Error):-
	writeln('Error occured while deleting the autor:'),
	writeln(Error),
	writeln('\n').

process_delete_options(2):-
	writeln('Please type in the ID of the book type to delete: '),
	read(Id),
	catch(delete_typ(Id),Error,handle_delete_typ_error(Error)),
	process_option(5).
handle_delete_typ_error(Error):-
	writeln('Error occured while deleting the book type:'),
	writeln(Error),
	writeln('\n').

process_delete_options(3):-
	writeln('1 - To delete a book with ID.'),
    writeln('2 - To delete a book with ISBN.'),
    read(Number),
    process_delete_buch(Number).
    
process_delete_options(4):-
	writeln('Please type in the MatrikelNr. of the student to delete: '),
	read(MatrikelNr),
	catch(delete_student(MatrikelNr),Error,handle_delete_student_error(Error)),
	process_option(5).
handle_delete_student_error(Error):-
	writeln('Error occured while deleting the student:'),
	writeln(Error),
	writeln('\n').
	
process_delete_options(5):-
	writeln('Please type in the ID of the room to delete: '),
	read(Id),
	catch(delete_zimmer(Id),Error,handle_delete_zimmer_error(Error)),
	process_option(5).
handle_delete_zimmer_error(Error):-
	writeln('Error occured while deleting the room:'),
	writeln(Error),
	writeln('\n').
process_delete_options(_):-
	writeln('Invalid input!\n'),
	process_option(5).