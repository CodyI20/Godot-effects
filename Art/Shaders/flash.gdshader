shader_type canvas_item;

uniform vec4 flash_color : source_color = vec4(1.0);
uniform bool flash = false;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if (flash){
		COLOR = mix(color,flash_color, color.a);
	}
}
