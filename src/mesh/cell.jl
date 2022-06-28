abstract type AbstractCell end

@enum CellShapeType begin
    cstMixed = 0
    cstTriangular = 1
    cstTetrahedral = 2
    cstQuadrilateral = 3
    cstHexahedral = 4
    cstPyramid = 5
    cstWedge = 6
    cstPolyhedron = 7
    cstPolygon = 8
    cstLine = 9
    cstNoType = 10
end

@enum CellType begin
    realcell
    ghostcell
end


# """
#     Element{Dim}

# An `Element` is an element to form the mesh.
# 一个单元是网格中的基本单元

# # Fields
# - `nodes::Vector{Node}`: 存放所有的点的编号
# - 字段nodes记录单元的节点编号

# """
struct Cell{dim,NODES,FACES} <: AbstractCell

    nodelist::NTuple{NODES,Int} # list of Nodes
    facelist::NTuple{FACES,Int} # list of faces
    shapetype::CellShapeType
    celltype::CellType
end

getdim(::Cell{dim}) where dim = dim
