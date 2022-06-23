module jFvmCfd

module Mesh

using StaticArrays

#参考 https://github.com/JuliaGeometry/Meshes.jl定义“点”

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

coordtype(::Type{Point{Dim,T}}) where {Dim,T}  = T
coordtype(p::Point) = coordtype(typeof(p))

function Base.show(io::IO, point::Point)
    print(io, "Point$(Tuple(point.coords))")
end


struct Line

end


end

end # module
