function hs47_radnlp(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return RADNLPModel(
        x -> (x[1] - x[2])^2 + (x[2] - x[3])^3 + (x[3] - x[4])^4 + (x[4] - x[5])^4,
        [35.0, -31.0, 11.0, 5.0, -5.0],
        x -> [x[1] + x[2]^2 + x[3]^3 - 3; x[2] - x[3]^2 + x[4] - 1; x[1] * x[5] - 1],
        zeros(3),
        zeros(3),
        name = "hs47_radnlp",
    )
end

function hs47_autodiff(;
    n::Int = 100,
    type::Val{T} = Val(Float64),
    kwargs...,
) where {T}
    return ADNLPModel(
        x -> (x[1] - x[2])^2 + (x[2] - x[3])^3 + (x[3] - x[4])^4 + (x[4] - x[5])^4,
        [35.0, -31.0, 11.0, 5.0, -5.0],
        x -> [x[1] + x[2]^2 + x[3]^3 - 3; x[2] - x[3]^2 + x[4] - 1; x[1] * x[5] - 1],
        zeros(3),
        zeros(3),
        name = "hs47_autodiff",
        kwargs...,
    )
end

hs47_meta = Dict(    :nvar => 5,    :variable_size => false,    :ncon => 3,    :variable_con_size => false,    :nnzo => 5,    :nnzh => 15,    :nnzj => 15,    :minimize => true,    :name => "hs47",    :optimal_value => NaN,    :has_multiple_solution => missing,    :is_infeasible => missing,    :objtype => :other,      :contype => :general,    :origin => :unknown,    :deriv => typemax(UInt8),    :not_everywhere_defined => missing,    :has_cvx_obj => false,    :has_cvx_con => false,    :has_equalities_only => true,    :has_inequalities_only => false,    :has_bounds => false,    :has_fixed_variables => false,    :cqs => 
0,  )
