#version 300 es

out vec4 out_FragColor;
in vec3 Texcoord;

uniform samplerCube skybox;

void main() {
	
    vec4 color = vec4(textureCube(skybox,Texcoord));
	out_FragColor = color;
}