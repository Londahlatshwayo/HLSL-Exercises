//Sphere funtion
float sdSphere(float3 p, float s)
{
    return length(p) - s;
}

//BoxFunction
float sdBox( float3 p, float3 b )
{
  float3 q = abs(p) - b;
  return length(max(q,0.0)) + min(max(q.x,max(q.y,q.z)),0.0);
}

//SmoothFunction
float smin (float a, float b, float k)
{
    float h = max(k-abs(a-b), .5)/k;
    return min(a, b) - h*h*h*k*(1.0/6.0);
}

//RotationFunction
mat2 rot2D(float angle)
{
    float s = sin(angle);
    float c = cos(angle);
    return mat2(c, -s, s, c);
}


//Cosine based palette function, 4 vec3 params
float3 Palette(float t)

{
    float3 a = float3(.5, .5, .5);
    float3 b = float3(.8, .5, .5);
    float3 c = float3(1., 1., 1.);
    float3 d = float3(.8, .6, .5);
    return a + b*cos( 6.28318*(c*t+d) );
}


float map(float3 Point)
{
    float3 SpherePos = float3(0., 0 , sin(Time)* 1.);
    float Sphere = sdSphere(Point - SpherePos, .8);
    
    
    float3 q = Point;
    //Whatever axis you omit, it will rotate by that axis
    q.xy *= rot2D(Time);
    
    //Foward movement
    Point.z += Time * .4;
    
    //Space repetition
    q = frac(Point) - .5;
    
    
    //Multiplying the point by a value distorts the shape. Divide the output to reduce artifacts
    //float Box = sdBox(Point* 1., float3(.75))/ 4.;
                            //Scaling cube size
    float Box = sdBox(q, float3(.05, .05, .05));
    
    //Adding the ground for blending //Positive value determine how much we push the ground down
    float Ground = Point.z + 1.;
    
    return smin(Ground, smin(Sphere, Box, 5.5), 1.);
 
}





void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    float2 uv =(fragCoord * 2. - iResolution.xy) / iResolution.y;
    float2 Mouse =(iMouse.xy * 2. - iResolution.xy) / iResolution.y;
    
    
    //Intialization
    // Ray origin
    float3 RayOrigin = float3(0, 0, -4);
    
    // Ray direction    //This will allow us to control the perspective
    float3 RayDirection = normalize(float3(uv * .9, 1));
    // Pixel colour
    float3 Colour = float3(0.0, 0.0, 0.0);
    
    // Total distance travelled
    float TotalDistance = 0.;
    
    
    //Vertical camera rotation
    //RayOrigin.yz *= rot2D(-Mouse.x);
    //RayDirection.yz *= rot2D(-Mouse.x);
                                            //Order of operations is VERY important in Raymarching
    //Horizontal camera rotation
    RayOrigin.xz *= rot2D(-Mouse.x);
    RayDirection.xz *= rot2D(-Mouse.x);
    
    
    
    
    int i;
    for (int i = 0; i < 85; i++)
    {
        // Raymarching
        vec3 Point = RayOrigin + RayDirection * TotalDistance;
        
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
    
    
        
    
    // Output to screen
    return float4(Colour, 1);
}