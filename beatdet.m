clc; close; clear;
[data,Fs] = audioread('Weightless.wav');

%initial audio has a sampling rate of 44100 Hz.
%generate time domain Onset signal strength
data = (data(:,1) + data(:,1))/2;
data = data(3*Fs:13*Fs);

player = audioplayer(data, Fs);

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
K = 5;
Peaks = movmax(abs(ya),K);


plot(tAxis,abs(ya));
grid on;
hold on;
plot(tAxis,Peaks);

meanPeaks = movmean(Peaks,K);

plot(tAxis,meanPeaks);
grid on;
hold on;
plot(tAxis,Peaks);

%%

threshold = 0.7; 
elementsToSetToZero = Peaks < threshold;
Peaks(elementsToSetToZero ) = 0;
player2 = audioplayer(Peaks, Fs);

play(player2);
counter = 0;

for i = 1:length(Peaks)
    if Peaks(i) ~= 0
        fprintf('beat \n');
        counter = counter + 1;
    end        
end

