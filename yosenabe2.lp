% Numbers move horizontally on same row.
possible(X,Y,XX,YY) :- number(X,Y,N), area(XX,YY,A), X = XX.

% Numbers moves vertically on same column.
possible(X,Y, XX, YY) :- number(X,Y,N), area(XX,YY,A), Y = YY.

% Each number finds 1 target on either the row or column.
1 { target(X,Y,XX,YY) : possible(X,Y,XX,YY) } 1 :- number(X,Y,N). 

% Every area needs at least 1 number in it.
:- area(_,_,A), not 1 { target(X,Y,XX,YY) : area(XX,YY,A) }.

#show target/4.
