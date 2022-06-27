
"""
#参考 https://github.com/JuliaGeometry/Meshes.jl定义“点”
点

点的坐标类型可以是Float64，也可以是Float32。

点可能是1维线上的点，也可能是2维平面上的点，也有可能是3维空间的点，我们这里Dim是一个维度参数
"""
struct Point{Dim,T}
  coords::SVector{Dim,T}
  Point{Dim,T}(coords::SVector{Dim,T}) where {Dim,T} = new{Dim,T}(coords)
  Point{Dim,T}(coords::SVector{Dim,T}) where {Dim,T<:Integer} = new{Dim,Float64}(coords)
end


"""
从坐标构造点
"""
Point{Dim,T}(coords...) where {Dim,T} = Point{Dim,T}(SVector{Dim,T}(coords...))

"""
从SVector类型构造点
"""
Point(coords::SVector{Dim,T}) where {Dim,T} = Point{Dim,T}(coords)

Point(coords::AbstractVector{T}) where {T} = Point{length(coords),T}(coords)

Point(coords...) = Point(SVector(coords...))

"""
坐标类型转换
"""
# coordinate type conversions
Base.convert(::Type{Point{Dim,T}}, coords) where {Dim,T} = Point{Dim,T}(coords)
Base.convert(::Type{Point{Dim,T}}, p::Point) where {Dim,T} = Point{Dim,T}(p.coords)
Base.convert(::Type{Point}, coords) = Point{length(coords),eltype(coords)}(coords)

"""
命名一些别名方便使用
"""
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