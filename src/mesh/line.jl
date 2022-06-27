# 参考 https://github.com/JuliaGeometry/Meshes.jl 定义“线”
# 对比 /OpenFOAM-9/src/OpenFOAM/meshes/primitiveShapes/line/line.H

"""
线有起点和终点，分别是a和b
"""
struct Line{Dim,T} <: Primitive{Dim,T}
  a::Point{Dim,T}
  b::Point{Dim,T}
end

# 在ENigMA中 https://github.com/bjaraujo/ENigMA ， 线成员函数还有个向量
# 我们这里暂时不用，看将来是否需要

Line(a::Tuple, b::Tuple) = Line(Point(a), Point(b))



# 以下这些参见ENigMA，根据需要考虑加不加
# midPoint - 获取线的中点，返回Point类型
# startPoint - 获取线的起点，返回Point类型
# endPoint - 获取线的终点，返回Point类型
# vec - 返回线的方向向量，
# calculateLength
# calculateBoundingBox
# clip(line,plane)
# distance
# intersects
# contains

# 以下这些参见https://github.com/JuliaGeometry/Meshes.jl，考虑是否激活

# paramdim(::Type{<:Line}) = 1
# isconvex(::Type{<:Line}) = true
# boundary(::Line) = nothing

# (l::Line)(t) = l.a + t * (l.b - l.a)

# function Base.in(p::Point, l::Line)
#   w = norm(l.b - l.a)
#   d = evaluate(Euclidean(), p, l)
#   # d ≈ 0.0 will be too precise, and d < atol{T} can't scale.
#   d + w ≈ w
# end

# function ==(l1::Line, l2::Line)
#   l1.a ∈ l2 && l1.b ∈ l2 && l2.a ∈ l1 && l2.b ∈ l1
# end

