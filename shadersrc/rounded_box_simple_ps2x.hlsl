#include "common.hlsl"

#define SCR_W Constants0.x
#define SCR_H Constants0.y
#define RADIUS_X Constants0.z
#define RADIUS_Y Constants0.w

bool isInBounds(float2 uv) {
    return length(uv) < 1.0;
}

float getSample(float2 uv) {
    float2 newUV = max(0.0, abs(uv - float2(0.5, 0.5)) * 2.0 - float2(1.0 - RADIUS_X, 1.0 - RADIUS_Y)) / float2(RADIUS_X, RADIUS_Y);

    return isInBounds(newUV) ? 1.0 : 0.0;
}

float4 main( PS_INPUT i ) : COLOR
{
    float samples = 0.0;
    float2 offset = float2(0.5 / SCR_W, 0.5 / SCR_H);

    float2 uv = i.uv;

    samples += getSample(uv + offset);
    samples += getSample(uv - offset);

    offset.x = -offset.x;

    samples += getSample(uv + offset);
    samples += getSample(uv - offset);

    float2 offsetX = float2(offset.x, 0);

    samples += getSample(uv + offsetX);
    samples += getSample(uv - offsetX);

    float2 offsetY = float2(0, offset.y);

    samples += getSample(uv + offsetY);
    samples += getSample(uv - offsetY);

    samples /= 8.0;

    float4 color = i.color;
    color.a = samples;

    return color;
}
