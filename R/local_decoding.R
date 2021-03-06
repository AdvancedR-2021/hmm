#' Local state decoding
#'
#' @keywords internal
#'
#' @description A function for local decoding of HMM's. Not expected to be called by user. Called by the general HMM function.
#'
#' @param obs Observations.
#' @param delta m-dimensional vector. Initial distribution of Markov chain
#' @param Gamma m x m matrix. Transition probs for Markov chain
#' @param p Function returning the evaluated density given the state.
#'
#'
#' @return List of most likely states and decoding probabilities.
#'
l_decoding <- function(obs, delta, Gamma, p){
  n <- length(obs); m <- ncol(Gamma)

  # Get forward and backward log-probabilities
  p_mat <- matrix(0, nrow=nrow(Gamma), ncol=length(obs))
  for(i in 1:nrow(Gamma)){
    for(j in 1:length(obs)){
      p_mat[i, j] <- p(i, obs[j])
    }
  }
  log_p_mat <- log(p_mat)
  log_Gamma <- log(Gamma)
  log_delta <- log(delta)

  log_beta <- backward_ll_cpp(log_Gamma, log_p_mat)
  log_alpha <- forward_ll_cpp(log_Gamma, log_p_mat, log_delta)

  # Get log-likelihood of entire data-set.
  k <- max(log_alpha[,n])
  log_ll <- k + log(sum(exp(log_alpha[,n] - k)))

  #Calculate state probabilities.
  state_probabilities <- matrix(NA, ncol=n, nrow=m)
  for (i in 1:n) state_probabilities[,i]<-exp(log_alpha[,i]+log_beta[,i]-log_ll)

  #Find and return largest state probabilties.
  decoded <- numeric(n)
  for(i in 1:n){decoded[i] <- which.max(state_probabilities[,i])}
  return(list(states = decoded, probs = state_probabilities))
}
