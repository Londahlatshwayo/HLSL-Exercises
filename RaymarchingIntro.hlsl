float3 rayStep = viewDirection * -1.0;

//Creates a texture object and sampler to sample the texture
float4 inputTexture = Texture2DSample(texObject, texObjectSampler, uv);

//Draws the ray marching texture at different depths to create a 3D effect
for(int i = 0; i < 10; i++)
{
    if(inputTexture.r > 0.2 && inputTexture.g > 0.2 && inputTexture.b > 0.2)
    {
        return float3(i, 0.0, 0.0);
    }

    //Multiplier for the distance between each step
    uv += rayStep * 0.1;

    //Samples the texture in one direction to create the ray marching effect
    inputTexture = Texture2DSample(texObject, texObjectSampler, uv.xy);
}

return inputTexture;