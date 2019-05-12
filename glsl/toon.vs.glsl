
#version 300 es

out vec3 interpolatedNormal;
out vec3 lightDirectView;
out vec3 pos;

uniform vec3 lightDirectionUniform;

out vec3 posW;


void main() {
	// TODO: PART 1E

   interpolatedNormal = normalMatrix * normal;

   lightDirectView = (viewMatrix * vec4(lightDirectionUniform, 0.0)).xyz;

   pos = (modelViewMatrix * vec4(position, 1.0)).xyz;

         posW = (modelMatrix * vec4(position, 1.0)).xyz;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}