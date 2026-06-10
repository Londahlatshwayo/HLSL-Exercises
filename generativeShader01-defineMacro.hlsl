#define Palette(t) 
(float3(0.058, 0.168, 0.448) + float3(0.5, 0.5, 0.5) * -sin(7.28318 * (float3(1.0, 1.0, 1.0) * (t) + float3(1.448, 0.142, 0.278))))

float2 uv = (fragCoord * 2.0 - Resolution.xy) / Resolution.x;
float2 uv0 = uv;
float3 finalColour = float3(0.0, 0.0, 0.0);

for (float i = 0.0; i < 25.0; i++)
{
    uv = frac(uv) - 0.5;
    
    float d = length(uv);
    float3 Colour = Palette(length(uv0) + i * 5.0 - Time * 5.0);
    d -= sin(d * 50.0 + Time) / 1.0;
    d = abs(d);
    d = pow(0.1 / d, 1.8);
    finalColour += Colour -= d;
}

return float4(finalColour, 1.0);