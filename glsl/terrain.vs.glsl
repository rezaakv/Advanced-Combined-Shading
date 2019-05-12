#version 300 es

out vec4 PosFromLight;
out vec3 vcsNormal;
out vec3 vcsPosition;
out vec2 vcsTexcoord;

uniform mat4 lightViewMatrixUniform;

uniform mat4 lightProjectMatrixUniform;

void main() {
	// viewing coordinate system
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));
	vcsTexcoord = uv;


	PosFromLight = lightProjectMatrixUniform * lightViewMatrixUniform * modelMatrix * vec4(position, 1.0);

  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
