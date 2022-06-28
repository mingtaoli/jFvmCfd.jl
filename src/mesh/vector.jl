"""
    Vec{Dim,T}
A vector in `Dim`-dimensional space with coordinates of type `T`.
空间中的一个矢量，坐标类型为T。

# Notes
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