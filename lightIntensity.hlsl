float lightIntensity = max(dot(NormalWS, LightDirectionWS), 0.0f);

float3 colour;

if(lightIntensity > High)
    colour = in3;
else if(lightIntensity > Mid)
    colour = in2;
else
    colour = in1;


return colour;