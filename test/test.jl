

abstract type abstractTerm end
struct divTerm <: abstractTerm end
struct tranTerm <: abstractTerm end
struct ADDTerm <: abstractTerm 
first
second
end

struct MinusTerm <: abstractTerm 
    first
    second
end

import Base: +,-,tan



function (+)(a::abstractTerm, b::abstractTerm)
    ADDTerm(a,b)
    ## 应该返回一个Term
end
function tan(a::abstractTerm, b::abstractTerm)
    234
    ## 应该返回一个Term
end

function (-)(a::abstractTerm, b::abstractTerm)
    MinusTerm(a,b)
    ## 应该返回一个Term
end



function getMatrix(divterm::divTerm)
    [1 2 3; 4 1 6; 7 8 1]
end
function getMatrix(tranterm::tranTerm)
    [5 2 5; 4 1 6; 7 8 1]
end

function getMatrix(addterm::ADDTerm)
 getMatrix(addterm.first)+getMatrix(addterm.second)
end
function getMatrix(minusterm::MinusTerm)
    getMatrix(minusterm.first)-getMatrix(minusterm.second)
end

c=divTerm()
d=tranTerm()

e=c+d
f=c+e
g=c+d+c

g=c-d
h=getMatrix(g)

#= 
julia> @show h
h = [7 6 11; 12 3 18; 21 24 3]
3×3 Matrix{Int64}:
  7   6  11
 12   3  18
 21  24   3 =#

 getMatrix(c+d)
 getMatrix(c-d)