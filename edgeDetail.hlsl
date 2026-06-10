float edgeDetail = length(ddx(NormalWS)) + length(ddy(NormalWS));

edgeDetail /= (Thickness * 0.5f);
edgeDetail = (edgeDetail - 1.0f) * Contrast + 1.0f;

return saturate(edgeDetail);