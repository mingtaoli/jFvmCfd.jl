# 平面，应该参考OpenFOAM和ENigMA的实现
# OpenFOAM需要一个是点，一个是方向2个成员变量
# ENigMA需要的是法向向量的方向，大小
# 在meshes.jl中，则是一个点，2个向量
# 我们需要再考虑，用什么样的数据格式描述平面plane

struct Plane{T} <: Primitive{3,T}
    p::Point{3,T}
    u::Vec{3,T}
    v::Vec{3,T}
end