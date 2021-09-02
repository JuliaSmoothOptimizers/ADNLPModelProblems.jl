function hs7_autodiff(; n::Int = 100, type::Val{T} = Val(Float64), kwargs...) where {T}
    return ADNLPModel(
        x -> log(1 + x[1]^2) - x[2],
        [2.0; 2.0],
        x -> [(1 + x[1]^2)^2 + x[2]^2 - 4],
        [0.0],
        [0.0],
        name = "hs7_autodiff";
        kwargs...,
    )
end

hs7_meta = Dict(
    :nvar => 2,
    :variable_size => false,
    :ncon => 1,
    :variable_con_size => false,
    :nnzo => 2,
    :nnzh => 3,
    :nnzj => 2,
    :minimize => true,
    :name => "hs7",
    :optimal_value => NaN,
    :has_multiple_solution => missing,
    :is_infeasible => missing,
    :objtype => :other,
    :contype => :general,
    :origin => :unknown,
    :deriv => typemax(UInt8),
    :not_everywhere_defined => missing,
    :has_cvx_obj => false,
    :has_cvx_con => false,
    :has_equalities_only => true,
    :has_inequalities_only => false,
    :has_bounds => false,
    :has_fixed_variables => false,
    :cqs => 0,
)

get_hs7_meta(; n::Integer = default_nvar) = (hs7_meta[:nvar], hs7_meta[:ncon])
