%% question 1 
w = 3*pi/4;
a = 0.9;
fs = 16000;
%derived differential equation 
[h_lp, f] = freqz([1 -2*cos(w) 1], [1 -2*a*cos(w) a*a], 10000, fs);
figure
plot(f, 20*log10(abs(h_lp)));
ylabel('Magnitude (dB)')
xlabel('Frequency (Hz)')

%% Loop
[X,Fs] = audioread('sample_dist.wav');
figure
nf=1024; %number of point in DTFT
Y1 = fft(X,nf);
f = Fs/2*linspace(0,1,nf/2+1);
plot(f,abs(Y1(1:nf/2+1))); 
title('single-sided frequency spectrum') 
xlabel('Frequency(Hz)')
ylabel('Magnitude')
Y = zeros(1,1024);
Y(1) = X(1);
Y(2) = X(2) - 2*cos(w)*X(1);
%notch filter implementation for an interfirance signal in the audio at
%6kHZ
for n = 3:1024
Y(n) = X(n) - 2*cos(w)*X(n-1) + X(n-2) + 2*a*cos(w)*Y(n-1) - a*a*Y(n-2);
end
figure
nf=1024; %number of point in DTFT
y = fft(Y,nf);
f = Fs/2*linspace(0,1,nf/2+1); plot(f,abs(y(1:nf/2+1)));
title('frequency spectrum of filterd audio') 
xlabel('Frequency(Hz)')
ylabel('Magnitude')
