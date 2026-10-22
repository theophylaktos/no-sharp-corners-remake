shader_type canvas_item;

uniform vec4 line_color: source_color = vec4(1);
uniform bool is_outlined = true;

void fragment() {
	if ((float(is_outlined) / 2.0) > 0.0)
	{
		vec4 color = texture(TEXTURE, UV);
		float outline = color.a;
		vec2 size = TEXTURE_PIXEL_SIZE * (float(is_outlined) / 2.0) * 2.0;
		
		vec2 offset = vec2(1,0) * size;
		outline += texture(TEXTURE, UV + offset).a;
		offset = vec2(0,1) * size;
		outline += texture(TEXTURE, UV + offset).a;
		offset = vec2(-1,0) * size;
		outline += texture(TEXTURE, UV + offset).a;
		offset = vec2(0,-1) * size;
		outline += texture(TEXTURE, UV + offset).a;
		
		outline = min(outline, 1.0);
		COLOR = mix(color, line_color, outline - color.a);
	}
}