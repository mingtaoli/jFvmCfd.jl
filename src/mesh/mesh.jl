"""
与网格相关的定义和函数
"""
module Mesh


using StaticArrays #我们要用到其SVector，


#-------------------------------------------------------
#
# 这样的抽象类型是“骨架” 名字我们以后再考虑
#
#-------------------------------------------------------
abstract type Geometry{Dim,T} end
abstract type Primitive{Dim,T} <: Geometry{Dim,T} end
#-------------------------------------------------------

# ------------------------------------------------------------------
# Licensed under the MIT License. See LICENSE in the project root.
# ------------------------------------------------------------------

"""
    Vec{Dim,T}
A vector in `Dim`-dimensional space with coordinates of type `T`.
A vector can be obtained by subtracting two [`Point`](@ref) objects.
## Examples
```julia
A = Point(0.0, 0.0)
B = Point(1.0, 0.0)
v = B - A
```
### Notes
- A `Vec` is a `SVector` from StaticArrays.jl
- Type aliases are `Vec1`, `Vec2`, `Vec3`, `Vec1f`, `Vec2f`, `Vec3f`
"""
const Vec = SVector

# type aliases for convenience
const Vec1  = Vec{1,Float64}
const Vec2  = Vec{2,Float64}
const Vec3  = Vec{3,Float64}
const Vec1f = Vec{1,Float32}
const Vec2f = Vec{2,Float32}
const Vec3f = Vec{3,Float32}

export Point,Point1D, Point2D, Point3D


include("point.jl")


# include("line.jl")
# include("plane.jl")

# include("face.jl")


# 看ENigMA，它有个CGeoVertexList类，就是给出所有点列的类，
# 然后三角形、四边形等都是它的子类


abstract type abstractElement end

abstract type Element{Dim} <: abstractElement end

"""
三角形
"""
struct Triangle <: Element{2}
    #Vector{Point}
end

"""
四边形
"""
struct Tetragon <: Element{2}
    #Vector{Point}
end

"""
四面体
"""
struct Tetrahedron <: Element{3}
    typename
    nfaces
    edges
end

"""
六面体
"""
struct Hexahedron <: Element{3}
    typename
    nfaces
    edges
end


#在OpenFOAM中，或者SU2中，都是用cell来记录一个单元，并没有区分是四面体还是六面体

# MHT中，点Vertice的记录中，记录了点相关的cell和face

# elements同样没有区分那么细，是通过ElemShapeType来表征它是一个什么cell的，

# 因此我们采用这种方式来描述cell

# 一个单元可能是真的存在的，一种是ghost的，ElemType

# 一个单元需要记录的是节点列表、face列表。

# OpenFOAM中是在cellModel.H文件中提供了类似的定义

# 点数
# facelist
# edgelist

# 参考以上这些定义，基本明确了如何定义一个cell(element)了。



struct mesh
    """
    网格的维度，1维，2维，3维
    """
    nDimensions::Int64
    """
    网格的点数
    """
    nPoints::Int64
    """
    网格的单元数
    单元是指三角形、四边形，四面体、六面体
    """
    nElements::Int64

    """
    点数组points，记录有所有点的坐标，1维、2维和3维的，坐标是Float64的或者Float32的
    """
    points::Vector{Point}
    """
    单元数组elements，记录有所有单元，是不是就是cell？
    """
    elements::Vector{Element}


#   edges
#   faces
end


end