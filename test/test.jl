

abstract type abstractScheme end
struct divScheme <: abstractScheme end
struct tranScheme <: abstractScheme end

using SymbolicUtils

@syms a::divScheme b::tranScheme

import Base: +

typeof(a)

function (+)(a::SymbolicUtils.Sym{divScheme, Nothing}, b::SymbolicUtils.Sym{tranScheme, Nothing})
    nothing
    # 应该返回一个Term
end

c=divScheme()
d=tranScheme()

function (+)(a::divScheme, b::tranScheme)
    -1
    ## 应该返回一个Term
end