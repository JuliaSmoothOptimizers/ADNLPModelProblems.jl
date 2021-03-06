function chainwoo_autodiff(;
  n::Int = default_nvar,
  type::Val{T} = Val(Float64),
  kwargs...,
) where {T}
  n = 4 * max(1, div(n, 4))  # number of variables adjusted to be a multiple of 4
  function f(x)
    n = length(x)
    return 1 + sum(
      100 * (x[2 * i] - x[2 * i - 1]^2)^2 +
      (1 - x[2 * i - 1])^2 +
      90 * (x[2 * i + 2] - x[2 * i + 1]^2)^2 +
      (1 - x[2 * i + 1])^2 +
      10 * (x[2 * i] + x[2 * i + 2] - 2)^2 +
      T(0.1) * (x[2 * i] - x[2 * i + 2])^2 for i = 1:(div(n, 2) - 1)
    )
  end
  x0 = -2 * ones(T, n)
  return ADNLPModel(f, x0, name = "chainwoo_autodiff"; kwargs...)
end

chainwoo_meta = Dict(
  :nvar => default_nvar,
  :variable_size => true,
  :ncon => 0,
  :variable_con_size => false,
  :nnzo => 100,
  :nnzh => 5050,
  :nnzj => 0,
  :minimize => true,
  :name => "chainwoo",
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

get_chainwoo_meta(; n::Integer = default_nvar) = (n, 0)
