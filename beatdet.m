clc; close; clear;
[data,Fs] = audioread('drum.mp3');

%initial audio has a sampling rate of 44100 Hz.
%generate time domain Onset signal strength
data = (data(:,1) + data(:,1))/2;
data = data(3*Fs:13*Fs);

player = audioplayer(data, Fs);
data = downsample(data,20);
% play(player);
% stop(player);
N = length(data);
tAxis = 0:1/Fs:(N-1)*1/Fs;
fAxis = (-N/2:N/2-1)/N*Fs;
plot(tAxis,data);
plot(fAxis,abs(fftshift(fft(data))));


plot(tAxis,data);
hold on;
ya = hilbert(data);
plot(tAxis,abs(ya));
grid on;
hold on;
stem(tAxis,pks);

%%
play(player);
npks = zeros(length(tAxis),1);
[pks,Pindices] = findpeaks(abs(ya));
for i = 1:length(pks)
    if abs(pks(i)) > 0.6
        npks(Pindices(i)-1) = pks(i);
        
    end
end

plot(tAxis,abs(ya));
grid on;
hold on;
stem(tAxis,npks);

%%
% K = looking window
K = 3;
for i = 1:length(npks)
    if pks(i) > pks(i:i+K-2)  
        temp = pks(i);        
    end
end


