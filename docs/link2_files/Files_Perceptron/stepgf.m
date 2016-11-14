function y = stepgf(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%% stepgf.m %%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose   : to implement step generating function
%
%
% Last modified 02/02/04 by Yul Young Park
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row col] = size(x);
y = x;
for r = 1:row
    for c = 1:col
        if (x(r,c) >= 0), y(r,c) = 1; end;
        if (x(r,c) < 0),  y(r,c) = -1; end;
    end
end;
