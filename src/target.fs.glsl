void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;

  vec3 color = texture(iChannel0, uv).rgb;
  color = clamp(vec3(0.0), vec3(1.0), color);

  fragColor = vec4(color, 1.0);
}
