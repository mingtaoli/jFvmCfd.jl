module jFvmCfd

abstract type abstractMesh end

abstract type UnstructedMesh <: abstractMesh end

abstract type StructedMesh <: abstractMesh end

abstract type controlDict end

abstract type absctractTerm end

# scalar vector tensor

# variable

# Scheme 格式

struct Problem
    mesh
    variables
    equations
    boundary
    initialcondition
end


end # module
