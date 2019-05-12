#version 300 es

out vec3 Texcoord;

void main() {

	Texcoord = vec3(modelMatrix * vec4(position - cameraPosition, 1.0));
	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}