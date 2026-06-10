//Function for colour
vec3 palette (float t)
{
    //Variables that contain gradient colours (vec3)
    vec3 a = vec3(0.058, 0.168, 0.448);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(1.448, 0.142, 0.278);
    vec3 e = vec3(1.448, -3.142, 0.278);
    
    return a + b* +sin(8.28318*(c*t+d));
 }




//Function that takes raycasting, the ray direction and a point and returns the distance between these vectors
float Distance(vec3 raycast, vec3 raycastDirec, vec3 point)
{
    return length (cross(point - raycast, raycastDirec))/length (raycastDirec);
}





void mainImage (out vec4 fragColor, in vec2 fragCoord )
{


vec3 finalColour =vec3(0.0);


    //UVs are 0 to 1
    vec2 uv = fragCoord/iResolution.xy;
    
        //Centring UV origin
        uv -= 0.5;
        //uv = fract(uv);
        //uv -= 0.5;
        
        //Use the rotation matrix to rotate UVs
        //float rotation = 0.5;
        //uv *= mat2(-tan(rotation), sin(rotation), 1.0, 0.5);

        //Takes resolution change into account and retains shader ratio
        uv.x *= iResolution.x/iResolution.y;

        //Going 3D here//
        //Make raycast a vector3 (Cam 3D VECTOR) 
        //Minus is the negative depth (before the screen)
        vec3 raycast = vec3(0.0, 0.0, -1.5);
        vec3 raycastDirec = vec3(uv.x, uv.y, 0.0) - raycast;

        //Initialize t variable to animate point
        float t = iTime;

        //The ray need to hit something
        //Location if the point is behind the screen
        //Control the size of point at z(b) depth
        vec3 point = vec3(0.0, 0.0, 0.1 + sin(t));

        //Calculate the vector between the cam vector to any point in 3D
        float distance = Distance(raycast, raycastDirec, point);
        
        //Assigns colour and offsets the gradient
        vec3 Colour = palette(length(uv* distance)* 10.0 - iTime* 0.5);
        
        //Frequency of circles according to sign function
        distance -= sin(distance * 100.0 + iTime)/2.0;
        
        distance = pow(0.1/distance, 0.5);
        
        
        finalColour +=  distance* Colour;

    
    //Output to screen
    //If the distance is close to the point, the colour will be darker
    //If the distance is far from the point, the colour will be lighter
    //Using smooth step to clamp the depth
    distance = smoothstep(0.01, 0.8, distance);
    
    fragColor = vec4(distance *finalColour, 1.0);
}