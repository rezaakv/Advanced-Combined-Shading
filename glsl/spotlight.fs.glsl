#version 300 es

precision highp float;
precision highp int;
out vec4 out_FragColor;



uniform vec3 spotlightPosition;
uniform vec3 spotDirectPosition;


in vec3 pos;


void main() {

	// TODO: PART 1D

   float spotExponent = 5.0;

   vec3 SpotColor = vec3(1.0, 1.0, 0.0);

   vec3 pointToSpotlight = pos - spotlightPosition;

   vec3 directToSpot = spotDirectPosition - spotlightPosition;

	float angle = dot(normalize(pointToSpotlight), normalize(directToSpot));

	angle = acos(angle);


	if(angle < radians(55.0)) {

		float c = cos(angle);
		c = cos(angle);
		c = pow(c, spotExponent);
		SpotColor = c * SpotColor;



	} else {
		SpotColor = vec3(0.0,0.0,0.0);

	}


   out_FragColor = vec4(SpotColor , 1.0);
}