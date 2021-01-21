#!/usr/bin/python

import sys
import numpy as np
 
a = 17.271
b = 237.7 # degC


T=float(sys.argv[1])
RH=float(sys.argv[2])
 
def dewpoint_approximation(T,RH):
    Td = (b * gamma(T,RH)) / (a - gamma(T,RH))
    return Td
 
 
def gamma(T,RH):
    g = (a * T / (b + T)) + np.log(RH/100.0)
    return g


Td = dewpoint_approximation(T,RH)
print ('T, RH',T,RH)
print ('Td=',Td)

