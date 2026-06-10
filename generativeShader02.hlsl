float3 palette (float t)
{
    //Variables that contain gradient colours (vec3)
    float3 a = float3(0.058, 0.168, 0.448);
    float3 b = float3(0.5, 0.5, 0.5);
    float3 c = float3(1.0, 1.0, 1.0);
    float3 d = float3(1.448, 0.142, 0.278);
    float3 e = float3(1.448, -3.142, 0.278);
    
    return a + b* cos(6.28318*(c*t+d));
}

void mainImage( out float4 fragColor, in float2 fragCoord )
{
    //Makes canvas 1:1 and centres coordinates
    float2 uv = (fragCoord* 2.0 - Resolution.xy)/Resolution.y;
    float2 uv0 = uv;
    float3 finalColour = float3(0.0, 0.0, 0.0);
    
    for (float i = 0.0; i < 1.5; i++)
    {
    
        //
        uv *= 1.3;
        uv = frac(uv);
        uv -=0.5;

        float d = length(uv);

        //Assigns colour and offsets the gradient
        float3 Colour = Palette(length(uv0)+ i* 2.0 - Time* 0.5);

        //Frequency of circles according to sign function
        d -= sin(d * 20.0 + Time)/2.0;
        d = abs(d);


       //Inverts the radial spheres (1-x) and affects the threshold of spheres
        //power function accentuates the the shader
        d = pow(0.1/d, 1.8);

        finalColour += Colour*= d;
    }
    
    
    //Colour of canvas
    //fragColor = float4(finalColour, 1.0);
    return float4(finalColour, 1.0);
}