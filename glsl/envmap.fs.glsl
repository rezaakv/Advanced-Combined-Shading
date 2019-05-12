#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;


uniform samplerCube skybox;

uniform vec3 lightDirection;

void main( void ) {


 	vec3 R = reflect(normalize(vcsPosition), normalize(vcsNormal));
    R = vec3(vec4(R, 0.0) * viewMatrix);

	vec4 color = vec4(textureCube(skybox,R));
 	 out_FragColor = color;
}
