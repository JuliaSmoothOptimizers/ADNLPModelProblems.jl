function controlinvestment(args...; n::Int = default_nvar, kwargs...)
  m = Model()

  N = div(n, 2)
  h = 1 / N
  x0 = 1.0
  gamma = 3

  @variable(m, x[1:N], start = x0)
  @variable(m, 0 ≤ u[1:N] ≤ 1, start = 0)

  @NLexpression(m, f[k = 1:N], (u[k] - 1) * x[k])
  @NLobjective(m, Min, 0.5 * h * sum(f[k] + f[k + 1] for k = 1:(N - 1)))

  @constraint(
    m,
    dx[k = 1:(N - 1)],
    x[k + 1] - x[k] == 0.5 * h * gamma * (u[k] * x[k] + u[k + 1] * x[k + 1])
  )
  @constraint(m, x[1] == x0)

  return m
end

function controlinvestment_autodiff(
  args...;
  n::Int = 200,
  type::Val{T} = Val(Float64),
  kwargs...,
) where {T}
  N = div(n, 2)
  h = T(1 / N)
  x0 = 1
  gamma = 3
  function f(y)
    x, u = y[1:N], y[(N + 1):end]
    return T(0.5) * h * sum((u[k] - 1) * x[k] + (u[k + 1] - 1) * x[k + 1] for k = 1:(N - 1))
  end
  function c(y)
    x, u = y[1:N], y[(N + 1):end]
    return [
      x[k + 1] - x[k] - T(0.5) * h * gamma * (u[k] * x[k] + u[k + 1] * x[k + 1]) for k = 1:(N - 1)
    ]
  end
  lvar = vcat(x0, -T(Inf) * ones(T, N - 1), zeros(T, N))
  uvar = vcat(x0, T(Inf) * ones(T, N - 1), ones(T, N))
  xi = vcat(ones(T, N), zeros(T, N))
  return ADNLPModel(
    f,
    xi,
    lvar,
    uvar,
    c,
    zeros(T, N - 1),
    zeros(T, N - 1),
    name = "controlinvestment_autodiff",
    ;
    kwargs...,
  )
end

controlinvestment_meta = Dict(
  :nvar => 2 * div(default_nvar, 2),
  :variable_size => true,
  :ncon => div(default_nvar, 2) - 1,
  :variable_con_size => true,
  :nnzo => 100,
  :nnzh => 5050,
  :nnzj => 4900,
  :minimize => true,
  :name => "controlinvestment",
  :optimal_value => NaN,
  :has_multiple_solution => missing,
  :is_infeasible => missing,
  :objtype => :quadratic,
  :contype => :general,
  :origin => :unknown,
  :deriv => typemax(UInt8),
  :not_everywhere_defined => false,
  :has_cvx_obj => false,
  :has_cvx_con => false,
  :has_equalities_only => true,
  :has_inequalities_only => false,
  :has_bounds => true,
  :has_fixed_variables => true,
  :cqs => 0,
)

get_controlinvestment_meta(; n::Integer = default_nvar) = (2 * div(n, 2), div(n, 2) - 1)
