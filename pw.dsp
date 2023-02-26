declare options "[midi:on]";
declare options "[nvoices:12]";

import("stdfaust.lib");

// TODO: get MPE working. [midi:ctrl 74] seems to bind the raw value of slide
// TODO: figure out how to get visual display of shape into UIs

gate = button("[4]gate");
gain = vslider("[5]gain", 0.5, 0, 1, 0.01);
f = vslider("[0]freq", 300, 20, 2000, 0.01);
bend = ba.semi2ratio(vslider("[1]bend[midi:pitchwheel]", 0, -2, 2, 0.01));
freq = f * bend;
N = vslider("[2]N[scale:log]", 4, 2, 1000, 0.000001);
teeth = vslider("[3]teeth", 0, 0, ma.PI, 0.01);

// r is the formula for a regular polygon with n sides and "teeth" of size T,
// it returns the radius for the polar coordinate at angle theta
r(theta, n, T) = cos(ma.PI / n) / cos(((2 * ma.PI) / n) * (((theta * n) / (2 * ma.PI)) % 1) - (ma.PI / n) + T);
// y returns the verticial component of the cartesian coordinate representation
// of the polar coordinate at theta in the polygon
y(theta) = r(theta, N, teeth) * sin(theta);

base = os.lf_saw(freq) * ma.PI + 1; // ranges from 0 to 2pi, the period of y
process = hgroup("poly", y(base) * gain * gate);
