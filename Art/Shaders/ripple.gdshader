shader_type canvas_item;

uniform vec3 outline_color: source_color;
uniform vec3 new_color : source_color;
uniform float num_cells: hint_range(2.0, 20.0, 1.0)=10.0;
uniform float speed: hint_range(0.1,2.0, 0.01)=1.0;
uniform float smoothness: hint_range(0.5, 0.99, 0.01)=0.99;
uniform float angle: hint_range(0.0, 360.0)=45.0;

uniform float progress : hint_range(0.0, 1.1, 0.05) = 0.0;

float rectanglef (vec2 uv, float width, float height, float feather){
	vec2 uv_cartesian = uv * 2.0 - 1.0;
	vec2 uv_reflected = abs(uv_cartesian);
	float dfx = smoothstep(width,width+feather,uv_reflected.x);
	float dfy = smoothstep(height,height+feather,uv_reflected.y);
	return max(dfx,dfy);
}

vec2 rotation ( vec2 uv, vec2 center, float ang){
	mat2 rotation = mat2(
					vec2(cos(ang), -sin(ang)),
					vec2(sin(ang), cos(ang))
					);
	uv -= center;
	uv *= rotation;
	uv += center;
	return uv;
}

void fragment(){
	COLOR = vec4(COLOR.rgb, 0.0);
	// Creating the grid which will scroll
	vec2 igrid = floor(UV * num_cells)/num_cells;
	// Setting the rotation of the grid to match the angle set
	igrid = rotation(igrid, vec2(0.5), angle * PI/180.0);
	// Moving the grid in the x (right) direction depending on the progress and speed set
	igrid.x += 1.1 - progress*speed*2.1;
	// Creating the fractional grid for the cube effect
	vec2 fgrid = fract(UV * num_cells);
	// Setting the masks
	float rect_mask = rectanglef(igrid, 0.001,2.0,smoothness);
	float grid_mask = 1.0 - rectanglef(fgrid,rect_mask,rect_mask,0.0);
	float outline_mask = 1.0 - rectanglef(fgrid,rect_mask+0.1,rect_mask+0.1,0.0) - grid_mask;
	// Generating the outline with the mask + its color
	vec3 outline = outline_mask * outline_color;
	// Setting the color mask (Left of the igrid.x is the new color, the rest is the current color)
	float color_mask = step(igrid.x, progress);
	// Mixing all the variables
	vec3 output = mix(mix(COLOR.rgb, new_color, color_mask), outline, outline_mask);
	// Setting the final color
	COLOR = vec4(output, outline_mask + grid_mask);
}