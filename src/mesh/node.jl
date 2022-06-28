"""
    Node{Dim,T}

A `Node` is a point in space.
一个节点是空间中的一个点

# Fields
- `coords::SVector{Dim,T}`: stores the coordinates
字段coords记录其坐标；Dim是维度；T是数据类型，可以是Float64或者Float32
"""
struct Node{Dim,T}
  coords::SVector{Dim,T}
  Node{Dim,T}(coords::SVector{Dim,T}) where {Dim,T} = new{Dim,T}(coords)
  Node{Dim,T}(coords::SVector{Dim,T}) where {Dim,T<:Integer} = new{Dim,Float64}(coords)
end

# convenience constructors
Node{Dim,T}(coords...) where {Dim,T} = Node{Dim,T}(SVector{Dim,T}(coords...))
Node(coords::SVector{Dim,T}) where {Dim,T} = Node{Dim,T}(coords)
Node(coords::AbstractVector{T}) where {T} = Node{length(coords),T}(coords)
Node(coords...) = Node(SVector(coords...))

# coordinate type conversions
Base.convert(::Type{Node{Dim,T}}, coords) where {Dim,T} = Node{Dim,T}(coords)
Base.convert(::Type{Node{Dim,T}}, p::Node) where {Dim,T} = Node{Dim,T}(p.coords)
Base.convert(::Type{Node}, coords) = Node{length(coords),eltype(coords)}(coords)

# type aliases for convenience
const Node1  = Node{1,Float64}
const Node2  = Node{2,Float64}
const Node3  = Node{3,Float64}
const Node1f = Node{1,Float32}
const Node2f = Node{2,Float32}
const Node3f = Node{3,Float32}

"""
  coordinates(node::Node)
Return the coordinates of the Node with respect to the canonical Euclidean basis.
"""
coordinates(node::Node) = node.coords

"""
  coordtype(node)
Return the machine type of each coordinate used to describe the `Node`.
"""
coordtype(::Type{Node{Dim,T}}) where {Dim,T}  = T
coordtype(node::Node) = coordtype(typeof(node))

"""
  embeddim(node)
Return the number of dimensions of the space where the `Node` is embedded.
"""
embeddim(::Type{Node{Dim,T}}) where {Dim,T} = Dim
embeddim(node::Node) = embeddim(typeof(node))

function Base.show(io::IO, node::Node)
  print(io, "Node$(Tuple(node.coords))")
end