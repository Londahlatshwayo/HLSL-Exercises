vec3 palette (float t)
{
    //Variables that contain gradient colours (vec3)
    vec3 a = vec3(0.058, 0.168, 0.448);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(1.448, 0.142, 0.278);
    vec3 e = vec3(1.448, -3.142, 0.278);
    
    return a + b* cos(6.28318*(c*t+d));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    //Makes canvas 1:1 and centres coordinates
    vec2 uv = (fragCoord* 2.0 - iResolution.xy)/iResolution.y;
    vec2 uv0 = uv;
    vec3 finalColour =vec3(0.0);
    
    for (float i = 0.0; i < 1.5; i++)
    {
    
        //
        uv *= 1.3;
        uv = fract(uv);
        uv -=0.5;

        float d = length(uv);

        //Assigns colour and offsets the gradient
        vec3 Colour = palette(length(uv0)+ i* 2.0 - iTime* 0.5);

        //Frequency of circles according to sign function
        d -= sin(d * 20.0 + iTime)/2.0;
        d = abs(d);


       //Inverts the radial spheres (1-x) and affects the threshold of spheres
        //power function accentuates the the shader
        d = pow(0.1/d, 1.8);

        finalColour += Colour*= d;
    }
    
    
    //Colour of canvas
    fragColor = vec4(finalColour, 1.0);
}