"""
与网格相关的定义和函数

"""
module Mesh

using StaticArrays #我们要用到其SVector，

export Point,Point1D, Point2D, Point3D

"""
#参考 https://github.com/JuliaGeometry/Meshes.jl定义“点”

"""
struct Point{Dim,T}
  coords::SVector{Dim,T}
  Point{Dim,T}(coords::SVector{Dim,T}) where {Dim,T} = new{Dim,T}(coords)
  Point{Dim,T}(coords::SVector{Dim,T}) where {Dim,T<:Integer} = new{Dim,Float64}(coords)
end


# convenience constructors
Point{Dim,T}(coords...) where {Dim,T} = Point{Dim,T}(SVector{Dim,T}(coords...))
Point(coords::SVector{Dim,T}) where {Dim,T} = Point{Dim,T}(coords)
Point(coords::AbstractVector{T}) where {T} = Point{length(coords),T}(coords)
Point(coords...) = Point(SVector(coords...))

# coordinate type conversions
Base.convert(::Type{Point{Dim,T}}, coords) where {Dim,T} = Point{Dim,T}(coords)
Base.convert(::Type{Point{Dim,T}}, p::Point) where {Dim,T} = Point{Dim,T}(p.coords)
Base.convert(::Type{Point}, coords) = Point{length(coords),eltype(coords)}(coords)

# type aliases for convenience
const Point1D = Point{1,Float64}
const Point2D = Point{2,Float64}
const Point3D = Point{3,Float64}
const Point1D32 = Point{1,Float32}
const Point2D32 = Point{2,Float32}
const Point3D32 = Point{3,Float32}

measure(::Point{Dim,T}) where {Dim,T} = zero(T)
center(p::Point) = p
centroid(p::Point) = p

coordinates(A::Point) = A.coords

coordtype(::Type{Point{Dim,T}}) where {Dim,T} = T
coordtype(p::Point) = coordtype(typeof(p))

function Base.show(io::IO, point::Point)
  print(io, "Point$(Tuple(point.coords))")
end


#-------------------------------------------------------
#
# 这样的抽象类型是“骨架” 名字我们以后再考虑
#
#-------------------------------------------------------
abstract type Geometry{Dim,T} end
abstract type Primitive{Dim,T} <: Geometry{Dim,T} end
#-------------------------------------------------------



"""
# 参考 https://github.com/JuliaGeometry/Meshes.jl 定义“线”
# 对比 /OpenFOAM-9/src/OpenFOAM/meshes/primitiveShapes/line/line.H
# 线有起点和终点，分别是a和b
"""
struct Line{Dim,T} <: Primitive{Dim,T}
  a::Point{Dim,T}
  b::Point{Dim,T}
end

Line(a::Tuple, b::Tuple) = Line(Point(a), Point(b))

paramdim(::Type{<:Line}) = 1

isconvex(::Type{<:Line}) = true

boundary(::Line) = nothing

(l::Line)(t) = l.a + t * (l.b - l.a)

function Base.in(p::Point, l::Line)
  w = norm(l.b - l.a)
  d = evaluate(Euclidean(), p, l)
  # d ≈ 0.0 will be too precise, and d < atol{T} can't scale.
  d + w ≈ w
end

function ==(l1::Line, l2::Line)
  l1.a ∈ l2 && l1.b ∈ l2 && l2.a ∈ l1 && l2.b ∈ l1
end


# 根据 /OpenFOAM-9/src/OpenFOAM/meshes/primitiveShapes/line/line.H 可以再补充适当的函数
# 比如起始点start，终点end等等。

# OpenFOAM的网格定义主要在/OpenFOAM-9/src/OpenFOAM/meshes/primitiveShapes
# 和/OpenFOAM-9/src/OpenFOAM/meshes/meshShapes

# julia中 @enum 这个可以用来定义枚举类型
# MHT中定义face的时候，	是这样写的
# enum FaceType
# 	{
# 		ftMixed = 0,
# 		ftLinear = 2,
# 		ftTrangular = 3,
# 		ftQuadrilateral = 4,
# 		ftPolygon = 5,
# 		ftNoType
# 	};
# 在Julia中，可以用@enum FaceType定义

#= @enum FaceType begin
	ftMixed = 0,
	ftLinear = 2,
	ftTrangular = 3,
	ftQuadrilateral = 4,
	ftPolygon = 5,
	ftNoType
end =#

# 在OpenFoam的face.H中的
#= enum proxType
{
    NONE,
    POINT,  // Close to point
    EDGE    // Close to edge
}; =#

# julia中则如下进行
#= @enum proxType begin
    NONE,
    POINT,  // Close to point
    EDGE    // Close to edge
end =#


#-------------------------------------------------------
#点、线、面plane都参考https://github.com/JuliaGeometry/Meshes.jl
# face参考Openfoam
#-------------------------------------------------------



#-------------------------------------------------------
# edge? cell? element?这些根据需要再看是否补充
#-------------------------------------------------------

struct mesh
  """
  点数组points，记录有所有点的坐标，1维、2维和3维的，坐标是Float64的或者Float32的
  cell数组？

  """
  points::Vector{Point}

end

end