

abstract type abstractScheme end
struct divScheme <: abstractScheme end
struct tranScheme <: abstractScheme end
struct ADDScheme <: abstractScheme 
first
second
end

import Base: +


c=divScheme()
d=tranScheme()

function (+)(a::abstractScheme, b::abstractScheme)
    ADDScheme(a,b)
    ## 应该返回一个Term
end

e=c+d