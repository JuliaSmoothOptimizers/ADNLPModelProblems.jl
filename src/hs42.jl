function hs42_autodiff(; n::Int = default_nvar, type::Val{T} = Val(Float64), kwargs...) where {T}
  return ADNLPModel(
    x -> (x[1] - 1)^2 + (x[2] - 2)^2 + (x[3] - 3)^2 + (x[4] - 4)^2,
    ones(T, 4),
    x -> [x[3]^2 + x[4]^2 - 2; x[1] - 2],
    zeros(T, 2),
    zeros(T, 2),
    name = "hs42_autodiff";
    kwargs...,
  )
end

hs42_meta = Dict(
  :nvar => 4,
  :variable_size => false,
  :ncon => 2,
  :variable_con_size => false,
  :nnzo => 4,
  :nnzh => 10,
  :nnzj => 8,
  :minimize => true,
  :name => "hs42",
  :optimal_value => NaN,
  :has_multiple_solution => missing,
  :is_infeasible => missing,
  :objtype => :quadratic,
  :contype => :quadratic,
  :origin => :unknown,
  :deriv => typemax(UInt8),
  :not_everywhere_defined => false,
  :has_cvx_obj => false,
  :has_cvx_con => false,
  :has_equalities_only => true,
  :has_inequalities_only => false,
  :has_bounds => false,
  :has_fixed_variables => false,
  :cqs => 0,
)

get_hs42_meta(; n::Integer = default_nvar) = (hs42_meta[:nvar], hs42_meta[:ncon])
