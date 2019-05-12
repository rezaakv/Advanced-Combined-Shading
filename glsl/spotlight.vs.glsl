#version 300 es

uniform vec3 spotlightPosition;
uniform vec3 spotDirectPosition;


out vec3 pos;




void main() {

 	// TODO: PART 1D


   pos = (modelMatrix * vec4(position, 1.0)).xyz;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}