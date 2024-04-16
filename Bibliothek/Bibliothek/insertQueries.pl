:- use_module(library(readutil)).

consult(autorClass.pl).
consult(buchTypClass.pl).
consult(buchClass.pl).
consult(studentClass.pl).
consult(buchungClass.pl).
consult(verleihenClass.pl).
consult(verwaltung.pl).

process_insert_options(0):-
    main_menu.
process_insert_options(1):-
    writeln('Please insert the first name of the author: '),
    read(Vorname),
    writeln('Please insert the last name of the author: '),
    read(Nachname),
    catch(insert_autor(Vorname, Nachname),Error,handle_insert_autor_error(Error)),
    process_option(2).
handle_insert_autor_error(Error):-
	writeln('Error occurred while inserting the author:'),
    writeln(Error),
    writeln('\n').

process_insert_options(2):-
    writeln('Please insert the type of the book: '),
    read(Name),
    catch(insert_typ(Name),Error,handle_insert_typ_error(Error)),
    process_option(2).
handle_insert_typ_error(Error):-
	writeln('Error occurred while inserting the book type:'),
    writeln(Error),
    writeln('\n').

process_insert_options(3):-
    writeln('Please insert the name of the book: '),
    read(Name),
    writeln('Please insert the ID of the author: '),
    read(ID_Autor),
    writeln('Please insert the ID of the book type: '),
    read(ID_Typ),
    writeln('Please insert the ISBN of the book: '),
    read(ISBN),
    catch(insert_buch(Name, ID_Autor, ID_Typ, ISBN),Error,handle_insert_buch_error(Error)),
    process_option(2).
handle_insert_buch_error(Error) :-
    writeln('Error occurred while inserting the book:'),
    writeln(Error),
    writeln('\n').

process_insert_options(4):-
    writeln('Please insert the matrikel nummer of the student: '),
    read(MatrikelNr),
    writeln('Please insert the first name of the student: '),
    read(Vorname),
    writeln('Please insert the last name of the student: '),
    read(Nachname),
    catch(insert_student(MatrikelNr, Vorname, Nachname),Error,handle_insert_student_error(Error)),
    process_option(2).
handle_insert_student_error(Error) :-
    writeln('Error occurred while inserting the student:'),
    writeln(Error),
    writeln('\n').

process_insert_options(5):-
    writeln('Please insert the room number: '),
    read(Nummer),
    writeln('Please insert the floor of the room: '),
    read(Etage),
    catch(insert_zimmer(Nummer, Etage),Error, handle_insert_zimmer_error(Error)),
    process_option(2).
handle_insert_zimmer_error(Error) :-
    writeln('Error occurred while inserting the room:'),
    writeln(Error),
    writeln('\n').
    
process_insert_options(_):-
	writeln('Invalid input!\n'),
	process_option(2).