shader_type spatial;
// Ativa suporte a sombras nativas do sol
render_mode cull_disabled, diffuse_toon, specular_toon; 

uniform vec4 color_top : source_color = vec4(0.22, 0.55, 0.28, 1.0);
uniform vec4 color_bottom : source_color = vec4(0.11, 0.32, 0.16, 1.0);
uniform float gradient_smoothness : hint_range(0.0, 1.0) = 0.2;

void vertex() {
	// Limpo e direto: sem deformações estruturais que distorcem o chão
}

void fragment() {
	// Faz o degradê horizontal mapeado perfeitamente nas coordenadas UV do plano
	float gradient_mix = smoothstep(0.0, gradient_smoothness, UV.x);
	
	// Mescla a cor de base com a cor do topo usando o cálculo do degradê
	vec3 final_color = mix(color_bottom.rgb, color_top.rgb, gradient_mix);
	
	// Entrega o resultado final para o canal de cores tridimensional do Godot
	ALBEDO = final_color;
	
	// Configurações extras de estilização (deixa o material fosco, sem brilho de plástico)
	ROUGHNESS = 1.0;
	SPECULAR = 0.0;
}
