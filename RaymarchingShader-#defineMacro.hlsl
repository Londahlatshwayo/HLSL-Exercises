#define sdSphere(p, s) (length(p) - s)

#define sdBox(p, b) (length(max(p-b,0.0)) + min(max(p-b.x,max(p-b.y,p-b.z)),0.0))

#define smin(a, b, k) (min(a, b) - pow(max(k-abs((a)-(b)), .5)/k, 3.0) * (k * (1.0/6.0)))

#define rot2D(angle) (mat2(cos(angle), -sin(angle), sin(angle), cos(angle)))

#define Palette(t) (float3(.5, .5, .5) + float3(.8, .5, .5) * -cos(6.28318 * (float3(1.0, 1.0, 1.0) * (t) + float3(.8, .6, .5))))

#define map(Point) (sdSphere(Point - float3(0., 0 , sin(Time)* 1.), .8) + sdBox(frac(Point + float3(0., 0., Time * .4)) - .5, float3(.75, .75, .75)) / 4.)