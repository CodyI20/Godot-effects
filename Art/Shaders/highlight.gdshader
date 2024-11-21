shader_type canvas_item;

uniform vec4 new_color : source_color; // Custom color for the fragment
uniform float scale_factor : hint_range(0.0, 10.0); // Scale multiplier
uniform float time_speed : hint_range(0.1, 5.0); // Speed of scaling oscillation

void vertex() {
    // Create an oscillating scale factor using sine wave
    float dynamic_scale = 1.0 + sin(TIME * time_speed) * (scale_factor - 1.0);

    // Adjust the vertex position to scale it
    VERTEX *= dynamic_scale;
}

void fragment() {
    // Apply the color to the fragment
    COLOR = new_color;
}
