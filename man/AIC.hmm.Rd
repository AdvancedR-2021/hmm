% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc_methods.R
\name{AIC.hmm}
\alias{AIC.hmm}
\alias{BIC.hmm}
\alias{logLik.hmm}
\title{Evaulating Hidden Markov Models}
\usage{
\method{AIC}{hmm}(object, ..., k = 2)

\method{BIC}{hmm}(object, ...)

\method{logLik}{hmm}(object, ...)
}
\arguments{
\item{object}{Object of class \code{hmm}.}

\item{...}{Optinally more fitted model objects.}

\item{k}{numeric, the penalty per parameter to be used; the default k = 2 is the classical AIC}
}
\description{
Functions for evaluating model fitness of a hidden Markov model using AIC, BIC and log-likelihood.
}
\details{
The log-likelihood is calculated using a combination of the forward algorithm for finding the (regular) likelihood and the log-sum-exp-trick to properly convert this to a log-likelihood in order to avoid underflow.
The AIC and BIC are calculated as usual, where the number of parameters is (m^2-1) + k where m is the number of states and k is the number of parameters in the emission distributions.
This is because we estimate m*(m-1) probabilities in the transition matrix and m-1 probabilities in the initial distribution vector, i.e. (m+1)(m-1) = m^2-1 in all.
All of this, however, is done during the creation of the \code{hmm} instance, so this function simply returns the values stored in the object.
}
\section{Functions}{
\itemize{
\item \code{AIC.hmm}: Returns the AIC of the HMM.

\item \code{BIC.hmm}: Returns the BIC of the HMM.

\item \code{logLik.hmm}: Returns the log-likelihood of the HMM
}}

\examples{
# Continuation of Earthquake example
\dontshow{example(hmm)}

# Fitted model
AIC(hmm.EQ)
BIC(hmm.EQ)
logLik(hmm.EQ)

# Starting parameters
AIC(hmm.EQ_no_opt)
BIC(hmm.EQ_no_opt)
logLik(hmm.EQ_no_opt)

}
