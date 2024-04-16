% Simple select
buchungen():-
	findall(Rows, odbc_query(mydb, 'SELECT b.id, s.vorname, s.nachname, z.nummer, b.gebuchtAm, b.stunden FROM buchung b INNER JOIN student s ON b.matrikelNr = s.matrikelNr INNER JOIN zimmer z ON b.zimmer = z.id', Rows), All),
	writeln(All).

% All the available rooms
freie_zimmer():-
	findall(Rows, odbc_query(mydb, 'SELECT id, nummer, etage FROM zimmer WHERE ist_frei = 1', Rows), All),
	writeln(All).

% Zimmer frei?
ist_zimmer_frei(ZimmerId, Frei):-
	atomic_list_concat(['SELECT ist_frei FROM zimmer WHERE id = ' , ZimmerId,''], Query),
    odbc_query(mydb, Query, Rows),
	Rows = row(Frei).

% Room booking
update_ist_frei(ZimmerId, Frei) :-
    atomic_list_concat(['UPDATE zimmer SET ist_frei = ', Frei, ' WHERE id = ', ZimmerId], Query),
    odbc_query(mydb, Query).
	
% Book room
zimmer_buchen(MatrikelNr, Zimmer, Stunden) :-
    ist_zimmer_frei(Zimmer, Frei),
    (Frei =:= 1 ->
        atomic_list_concat(['INSERT INTO buchung(matrikelNr, zimmer, stunden) VALUES (?, ?, ?)'], Query),
        odbc_prepare(mydb, Query, [integer, integer, integer], Statement),
        odbc_execute(Statement, [MatrikelNr, Zimmer, Stunden]),
        update_ist_frei(Zimmer, 0)
    ;
        writeln('The room is not available for booking.')
    ).

% Zimmer Freigabe
zimmer_freigabe :-
    atomic_list_concat(['UPDATE zimmer SET ist_frei = 1 WHERE id IN (SELECT booked_rooms.id FROM (SELECT z.id FROM zimmer z INNER JOIN buchung b ON z.id = b.zimmer WHERE b.gebuchtAm + INTERVAL b.stunden HOUR <= NOW()) AS booked_rooms)'], Query),
    odbc_query(mydb, Query),
    writeln('Room status updated.').