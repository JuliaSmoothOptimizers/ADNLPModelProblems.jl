function fletcbv2_autodiff(;
  n::Int = default_nvar,
  type::Val{T} = Val(Float64),
  kwargs...,
) where {T}
  n ≥ 2 || error("fletcbv2 : n ≥ 2")
  function f(x)
    n = length(x)
    h = T(1 / (n + 1))
    return T(0.5) * (x[1]^2 + sum((x[i] - x[i + 1])^2 for i = 1:(n - 1)) + x[n]^2) -
           h^2 * sum(2 * x[i] + cos(x[i]) for i = 1:n) - x[n]
  end
  x0 = T.([(i / (n + 1)) for i = 1:n])
  return ADNLPModel(f, x0, name = "fletcbv2_autodiff"; kwargs...)
end

fletcbv2_meta = Dict(
  :nvar => default_nvar,
  :variable_size => true,
  :ncon => 0,
  :variable_con_size => false,
  :nnzo => 100,
  :nnzh => 5050,
  :nnzj => 0,
  :minimize => true,
  :name => "fletcbv2",
  :optimal_value => NaN,
  :has_multiple_solution => missing,
  :is_infeasible => false,
  :objtype => :other,
  :contype => :unconstrained,
  :origin => :unknown,
  :deriv => typemax(UInt8),
  :not_everywhere_defined => false,
  :has_cvx_obj => false,
  :has_cvx_con => false,
  :has_equalities_only => false,
  :has_inequalities_only => false,
  :has_bounds => false,
  :has_fixed_variables => false,
  :cqs => 0,
)

get_fletcbv2_meta(; n::Integer = default_nvar) = (n, 0)
