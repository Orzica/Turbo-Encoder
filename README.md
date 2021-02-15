
   <br /><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![LTE-turbo-encoder-which-consists-of-two-convolutional-encoders-and-one-turbo-code](https://user-images.githubusercontent.com/73991079/104200995-f118d800-5431-11eb-9381-df6914a8ae22.jpg) <br />
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In information theory, turbo codes (originally in French Turbocodes) are a class of high-performance forward error correction (FEC) codes developed around 1990–91, but first published in 1993. They were the first practical codes to closely approach the maximum channel capacity or Shannon limit, a theoretical maximum for the code rate at which reliable communication is still possible given a specific noise level. Turbo codes are used in 3G/4G mobile communications (e.g., in UMTS and LTE) and in (deep space) satellite communications as well as other applications where designers seek to achieve reliable information transfer over bandwidth- or latency-constrained communication links in the presence of data-corrupting noise.<br />
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This paper aims to study the implementation of parallelly concatenated
recusrive systematic convolutional encoders. Turbo codes is one of the most
powerful error correcting codes that are widely used in modern communication
systems. The encoded data is transmited over Additive White Gaussian
Channels(AWGN) by employing Binary Phase Shift Keying (BPSK) modulation
scheme. Hardware implementation is performed on a development board FPGA
(Field Programmable Gate Array), due to considerable advantage brought by this
platform’s flexibility. Software implementation is performed in Matlab and
Simulink. Software implementation also allow me to see how decoder works for
some very specific features as number of decoding iteration, algoritm used etc. The
performance is evaluated in term of bit error rate (BER) for a given value range of
signal to noise ratie (SNR).
My personal contribution to this project, apart from all the comparisons
and implementations of both hardware and software basic concepts of channel
coding, was implementation of two new and original interleaver methods.
