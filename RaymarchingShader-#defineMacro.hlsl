#define sdSphere(p, s) (length(p) - s)
#define sdBox(p, b) (length(max(abs(p)-b, 0.0)) + min(max((abs(p)-b).x, max((abs(p)-b).y, (abs(p)-b).z)), 0.0))
#define smin(a, b, k) (min(a,b) - pow(max(k-abs((a)-(b)), 0.5)/k, 3.0) * k * (1.0/6.0))
#define rot2D(angle) (float2x2(cos(angle), -sin(angle), sin(angle), cos(angle)))
#define Palette(t) (float3(.5, .5, .5) + float3(.8, .5, .5) * -cos(6.28318 * (float3(1.0, 1.0, 1.0) * (t) + float3(.8, .6, .5))))
#define map(Point) (smin(sdSphere((Point) - float3(0., 0., sin(Time) * 1.), .8), sdBox(frac((Point) + float3(0., 0., Time * .4)) - .5, float3(.05, .05, .05)), 5.5))


// Normalized pixel coordinates (from 0 to 1)
    float2 uv =(fragCoord * 2. - Resolution.xy) / Resolution.y;

    //Intialization
    // Ray origin
    float3 RayOrigin = float3(0, 0, -4);

    // Ray direction    //This will allow us to control the perspective
    float3 RayDirection = normalize(float3(uv * .9, 1));
    // Pixel colour
    float3 Colour = float3(0.0, 0.0, 0.0);

    // Total distance travelled
    float TotalDistance = 0.;

    int i = 0;
    for (int i = 0; i < 85; i++)
    {
        // Raymarching
        float3 Point = RayOrigin + RayDirection * TotalDistance;

        //Wiggle the ray
        Point.y += sin(TotalDistance)* .1;
        // Current distance
        float Distance = map(Point);
        TotalDistance += Distance;

        // Breaks so the GPU doesn't calculator more than it needs to
        if (Distance < .001) break;
        if (TotalDistance > 100.) break;
    }

   //Colour = palette(TotalDistance *.1);
   Colour = Palette(TotalDistance* .04 + float(i)* .005);
return float4(Colour, 1);