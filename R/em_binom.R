#' @describeIn em EM-algorithm for binomial emissions
em.binom <- function(obs, gamma, delta, size, prob, ...){
  m <- length(delta)
  lls <- list()
  lls_mle <- list()
  for(i in 1:m){
    lls[[i]] <- function(x, param) dbinom(x, size=size, prob=param)
    lls_mle[[i]] <- function(x, u) sum(x/size * u) / sum(u)
  }
  param_lls <- as.list(prob)
  out <- em(obs, gamma, delta, lls, param_lls, lls_mle, ...)
  out$parameters <- list(size=size,
                         prob=as.numeric(out$parameters))
  return(out)
}
