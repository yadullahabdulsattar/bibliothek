include('connectionClass.pl').

% Check connection
test_connection:-
	connection,
	disconnect.
	
% Test if the data is coming from database
test_data:-
	connection,
	studenten,
	disconnect.
	
% Test if the insert predicate is working
test_insert:-
	connection,
	insert_buch('test book', 1, 1, 123456),
	disconnect.
	
% Test if the delete predicate is working
test_delete:-
	connection,
	delete_buch_mitISBN(123456),
	disconnect.
	
% Check if the room booking system is working
test_zimmer_buchen:-
	connection,
	zimmer_buchen(919533, 10, 1),
	disconnect.

% Check if the book lending is working
test_buch_ausleihen:-
	connection,
	buch_ausleihen(919533, 5),
	disconnect.