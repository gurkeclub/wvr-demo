#define E 0.01


vec3 sky_color(vec3 d) {
	return abs(d);
}

vec3 paint_pattern(vec3 bg, vec3 color, vec2 p) {
	vec2 wobble = (0.5 * 0.5 * vec2(cos(iBeat * 1.0 / 4.0 * PI), sin(1.0 / 2.0 * iBeat * PI) * sin(1.0 / 16.1 * iBeat * PI))) * mix(0.5 - 0.5 * cos(1.0 / 64.1 * iBeat * PI), 0.0, smoothstep(0.0, 0.5, length(p) - 0.5));
	vec2 shift = length(p) + vec2(iBeat * 1.0 / 32.1 - 0.1 * wobble.x, iBeat * 1.0 / 16.2 - 0.1 * wobble.y);
	
	
	p = rot2(p, (wobble.x + wobble.y) * PI); 
	p += -iBeat * 1.0 / 4.0 * sign(p);
	float pattern = 1.0;
	pattern *= step(0.0, abs(fract((abs(p.x)  - shift.x)  - 0.25)* (1.0 + wobble.x) - 0.5) - 0.25 + 0.25 *  wobble.y);
	pattern *= step(0.0, abs(fract((abs(p.y)  - shift.y)  - 0.25)* (1.0 + wobble.y) - 0.5) - 0.25 + 0.25 *  wobble.x);
	
	vec3 pattern_color = 1.0 - color;
	pattern_color.rg = rot2(pattern_color.rg, -shift.x * PI);
	pattern_color.gb = rot2(pattern_color.gb, -shift.y * PI);
	
	pattern_color = normalize(fract(pattern_color) * 4.0);
	
	color = mix(bg, pattern_color, pattern);
	
	
	return color;
}
 
vec3 scene_color(vec2 uv) {
  vec2 uv_c = (uv * 2.0 - 1.0) * iResolution.xy / iResolution.yy;
 
  vec3 d = normalize(vec3(uv_c, 1.0));
 
  vec3 color = vec3(0.0);
	
	color = paint_pattern(color, sky_color(d), uv_c);
  

  return color;
}


void mainImage(out vec4 fragColor, in vec2 fragCoord) {
  vec2 uv = fragCoord.xy / iResolution.xy;

  vec3 color = vec3(0.0, 0.0, 0.0);
  color = scene_color(uv);

  color = clamp(vec3(0.0), vec3(1.0), color);

  fragColor = vec4(color, 1.0);
}


