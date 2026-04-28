% numbers at (X,Y) can move to (XX,YY) if there is a number at (X,Y) and (XX,YY) is gray.
% achieved: Numbers move horizontally on same row.
possible(X,Y,XX,YY) :- number(X,Y,N), area(XX,YY,A), X = XX.
% X = XX is same column or vertical move

% achieved: Numbers moves vertically on same column.
possible(X,Y, XX, YY) :- number(X,Y,N), area(XX,YY,A), Y = YY.
% Y = YY is same row or horizontal move.

% achieved: for each number at (X,Y), they each choose 1 (XX,YY) from all possible targets.
1 { target(X,Y,XX,YY) : possible(X,Y,XX,YY) } 1 :- number(X,Y,N). 

% Achieved: every area must have at least 1 number on it.
:- area(_,_,A), not 1 { target(X,Y,XX,YY) : area(XX,YY,A) }.

% horizontal and vertical path cells.
% achieved: if a number moves vertically, the cells in the path are (X,PY) and goes down.
path(X,Y,XX,YY,X,PY) :- target(X,Y,XX,YY), X = XX, cell(X,PY),PY >= Y, PY <= YY.
% achieved: if a number moves vertically, it goes up and cells are still (X,PY).
path(X,Y,XX,YY,X,PY) :- target(X,Y,XX,YY), X = XX, cell(X,PY),PY >= YY, PY <= Y.
% achieved: if a number moves horizontally, cells become (CX,Y) and go right.
path(X,Y,XX,YY,PX,Y) :- target(X,Y,XX,YY), Y = YY, cell(PX, Y), PX >= X, PX <= XX.
% achieved: if a number moves horizontally, cells are still (CX,Y) and go left.
path(X,Y,XX,YY,PX,Y) :- target(X,Y,XX,YY), Y = YY, cell(PX,Y), PX >= XX, PX <= X.

% cells cannot share same cell path.
% achieved: no cells are able to share the same cell and will reject them if they do.
:- path(X1, Y1, XX1, YY1, PX, PY), path(X2, Y2, XX2, YY2, PX, PY), X1 != X2.
:- path(X1, Y1, XX1, YY1, PX, PY), path(X2, Y2, XX2, YY2, PX, PY), Y1 != Y2.

% achieved: the goal must equal the sum of the numbers moved into that area 
%and is rejected if not.
:- goal(A,G), #sum{ N,X,Y : target(X,Y,XX,YY), number(X,Y,N), area(XX,YY,A)} != G.

#show target/4.
