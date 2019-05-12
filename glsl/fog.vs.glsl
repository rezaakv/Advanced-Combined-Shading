#version 300 es

out vec3 interpolatedNormal;
out vec3 lightDirectView;
out vec3 pos;
out vec3 posW;

uniform vec3 lightDirectionUniform;



void main() {

	// TODO: PART 1C

   interpolatedNormal = normalMatrix * normal;

   lightDirectView = (viewMatrix * vec4(lightDirectionUniform, 0.0)).xyz;

   pos = (modelViewMatrix * vec4(position, 1.0)).xyz;

      posW = (modelMatrix * vec4(position, 1.0)).xyz;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position,1.0);
}
