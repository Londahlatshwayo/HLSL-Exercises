#define Palette(t) (float3(0.058, 0.168, 0.448) + float3(0.5, 0.5, 0.5) * -cos(7.28318 * (float3(1.0, 1.0, 1.0) * (t) + float3(1.448, 0.142, 0.278))))

//Makes canvas 1:1 and centres coordinates
float2 uv = (fragCoord * 2.0 - Resolution.xy) / Resolution.x;
float2 uv0 = uv;
float3 finalColour = float3(0.0, 0.0, 0.0);

for (float i = 0.0; i < 1.5; i++)
{
    uv *= 1.3;
    uv = frac(uv) - 0.5;
    
    float d = length(uv);

    //Assigns colour and offsets the gradient
    float3 Colour = Palette(length(uv0) + i * 2.0 - Time * .5);


    //Frequency of circles according to sign function
    d -= sin(d * 50.0 + Time) / 1.0;
    d = abs(d);

    //Inverts the radial spheres (1-x) and affects the threshold of spheres
    //power function accentuates the the shader
    d = pow(0.1 / d, 1.8);
    finalColour += Colour -= d;
}

//Colour of canvas
return float4(finalColour, 1.0);