function hs63_autodiff(; n::Int = default_nvar, type::Val{T} = Val(Float64), kwargs...) where {T}
  return ADNLPModel(
    x -> 1000 - x[1]^2 - 2 * x[2]^2 - x[3]^2 - x[1] * x[2] - x[1] * x[3],
    2 * ones(T, 3),
    x -> [8 * x[1] + 14 * x[2] + 7 * x[3] - 56; x[1]^2 + x[2]^2 + x[3]^2 - 25],
    zeros(T, 2),
    zeros(T, 2),
    name = "hs63_autodiff";
    kwargs...,
  )
end

hs63_meta = Dict(
  :nvar => 3,
  :variable_size => false,
  :ncon => 2,
  :variable_con_size => false,
  :nnzo => 3,
  :nnzh => 6,
  :nnzj => 6,
  :minimize => true,
  :name => "hs63",
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

get_hs63_meta(; n::Integer = default_nvar) = (hs63_meta[:nvar], hs63_meta[:ncon])
