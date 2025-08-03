e0 = 8.85*10^-12;               % Dielectric Constant
u0 = 4*pi*10^-7;                % Free Space Permaebility
f = 100*10^6;                   % Frequency
E0= 10^-4;                      % Electric Amplitude
w = 2*pi*f;                     % Angular Frequency
k = w*sqrt(u0*e0);              % Wave Number => w/c , c = 1/sqrt(u0*e0) 3*10^8
lam = (2*pi)/k;                 % The wave length => c/f
t = linspace(0,50*10^-9,100);  % Time Vector
v = linspace(0,2*lam,100);     % Creating a location vector up to 2 time chosen wavelength
[x,y,z] = meshgrid(v);         % Creating 3D Meshgrid for locations
for b = 1:50
Ez = E0*exp(-1i*k*y);
Ex = E0 * exp(-1i * k * y) * exp(1i * pi / 2);
Ey = E0 * exp(-1i * k * y);


% Since we only interested in time domain. We take the real parts.
Ext = real(Ex*exp(-1i*w*t(b)));  
Eyt = real(Ey*exp(-1i*w*t(b)));
Ezt = real(Ez*exp(-1i*w*t(b)));

% As mention in the lab document. We can find magnetic field wave plane wave approximation using maxwell equations
[curlx,curly,curlz] = curl(x,y,z,Ex,Ey,Ez);
Hx = curlx/(-1i*w*u0);
Hy = curly/(-1i*w*u0);
Hz = curlz/(-1i*w*u0);
Hxt = real(Hx*exp(-1i*w*t(b)));
Hyt = real(Hy*exp(-1i*w*t(b)));
Hzt = real(Hz*exp(-1i*w*t(b)));

% Now we have time domain plane wave approximation of electric field and magnetic field. Let's plot them.
plot3(Ext(:,1,1),y(:,1,1),Ezt(:,1,1),'b')
view([135 45])
hold on
plot3(Hxt(:,1,1),y(:,1,1),Hzt(:,1,1),'r')
hold off
zlim([-E0 E0])
figure(1)
title("Left-Hand Circularly Polarized Wave")
xlabel("Magnetic Field Magnitude (x)")
ylabel("Propagation Direction (y)")
zlabel("Electric Field Direction (z)")
grid on
pause(0.0001)
end
