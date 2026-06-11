//Function for colour
vec3 palette (float t)
{
    //Variables that contain gradient colours (vec3)
    float3 a = float3(0.058, 0.168, 0.448);
    float3 b = float3(0.5, 0.5, 0.5);
    float3 c = float3(1.0, 1.0, 1.0);
    float3 d = float3(1.448, 0.142, 0.278);
    float3 e = float3(1.448, -3.142, 0.278);
    
    return a + b* +sin(8.28318*(c*t+d));
 }




//Function that takes raycasting, the ray direction and a point and returns the distance between these vectors
float Distance(float3 raycast, float3 raycastDirec, float3 point)
{
    return length (cross(point - raycast, raycastDirec))/length (raycastDirec);
}





void mainImage (out vec4 fragColor, in vec2 fragCoord )
{


float3 finalColour =float3(0.0, 0.0, 0.0);


    //UVs are 0 to 1
    float2 uv = fragCoord/Resolution.xy;
    
        //Centring UV origin
        uv -= 0.5;
        //uv = fract(uv);
        //uv -= 0.5;
        
        //Use the rotation matrix to rotate UVs
        //float rotation = 0.5;
        //uv *= mat2(-tan(rotation), sin(rotation), 1.0, 0.5);

        //Takes resolution change into account and retains shader ratio
        uv.x *= Resolution.x/Resolution.y;

        //Going 3D here//
        //Make raycast a vector3 (Cam 3D VECTOR) 
        //Minus is the negative depth (before the screen)
        float3 raycast = float3(0.0, 0.0, -1.5);
        float3 raycastDirec = float3(uv.x, uv.y, 0.0) - raycast;

        //Initialize t variable to animate point
        float t = Time;

        //The ray need to hit something
        //Location if the point is behind the screen
        //Control the size of point at z(b) depth
        float3 point = float3(0.0, 0.0, 0.1 + sin(t));

        //Calculate the vector between the cam vector to any point in 3D
        float distance = Distance(raycast, raycastDirec, point);
        
        //Assigns colour and offsets the gradient
        float3 Colour = Palette(length(uv* distance)* 10.0 - Time* 0.5);
        
        //Frequency of circles according to sign function
        distance -= sin(distance * 100.0 + Time)/2.0;
        
        distance = pow(0.1/distance, 0.5);
        
        
        finalColour +=  distance* Colour;

    
    //Output to screen
    //If the distance is close to the point, the colour will be darker
    //If the distance is far from the point, the colour will be lighter
    //Using smooth step to clamp the depth
    distance = smoothstep(0.01, 0.8, distance);
    
    
    return float4(distance *finalColour, 1.0);
}