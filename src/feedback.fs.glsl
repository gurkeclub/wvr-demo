void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord / iResolution.xy;
  vec2 uv_c = (uv * 2.0 - 1.0) * iResolution.xy / iResolution.yy;
	

  vec3 color = texture(iChannel0, uv).rgb;
	
	vec2 sort_dir = -4.0 * sign(uv_c)/ iResolution.xy;
	
	vec3 color_fb = vec3(0.0);
  vec2 uv_fb = uv + sort_dir;
  
	
	
	color_fb =  texture(iChannel1, uv_fb).rgb;
	color_fb = mix(color_fb, 1.0 - color_fb, 1.0 - step(length(texture(iChannel0, uv).rgb),  length(texture(iChannel0, uv_fb).rgb))); 
	
	
	
  
  color = mix(color, color_fb * 0.99, step(length(color), length(color_fb)));
  
  
  //color = clamp(vec3(0.0), vec3(1.0), color);
	

  fragColor = vec4(color, 1.0);
}
