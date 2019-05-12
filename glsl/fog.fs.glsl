#version 300 es

precision highp float;
precision highp int;


out vec4 out_FragColor;

in vec3 pos;
in vec3 posW;
in vec3 interpolatedNormal;
in vec3 lightDirectView;


uniform vec3 lightColorUniform;
uniform vec3 lightFogColorUniform;

uniform float kDiffuseUniform;
uniform float fogDensity;



uniform vec3 spotlightPosition;
uniform vec3 spotDirectPosition;


void main() {



	   float spotExponent = 5.0;

   vec3 SpotColor = vec3(1.0, 0.5, 0.0);

   vec3 pointToSpotlight = posW - spotlightPosition;

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

   float distance = length(-pos);

   float fogLevel = 1.0 / pow(2.71828, distance * fogDensity);

   	float difIntensity = max(0.0, dot(normalize(interpolatedNormal), normalize(lightDirectView)));


	vec3 TOTAL = mix(lightFogColorUniform , difIntensity * kDiffuseUniform * SpotColor, fogLevel);

	out_FragColor = vec4(TOTAL, 1.0);
}
