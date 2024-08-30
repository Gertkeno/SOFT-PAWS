shader_type spatial;

uniform float distortion_size = 0.4;
uniform sampler2D glass;
uniform sampler2D screen_tex: hint_screen_texture;

void fragment() {
	vec2 d = texture(glass, UV).xy - vec2(0.5);
	ALBEDO = texture(screen_tex, SCREEN_UV + d * distortion_size).rgb;
}