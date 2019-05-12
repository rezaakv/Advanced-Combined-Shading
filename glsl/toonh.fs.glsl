#version 300 es

precision highp float;
precision highp int;
out vec4 out_FragColor;



uniform vec3 spotlightPosition;
uniform vec3 spotDirectPosition;


in vec3 posW;


in vec3 interpolatedNormal;
in vec3 lightDirectView;
in vec3 pos;

uniform vec3 lightColorUniform;
uniform vec3 ambientColorUniform;

uniform vec3 lightDirectionUniform;

uniform float kAmbientUniform;
uniform float kDiffuseUniform;
uniform float kSpecularUniform;
uniform float shininessUniform;



void main() {


	//TOTAL INTENSITY
	//TODO PART 1E: calculate light intensity (ambient+diffuse+speculars' intensity term)

     float spotExponent = 5.0;

   vec3 SpotColor = vec3(1.0, 1.0, 1.0);

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

	float light_AMB = kAmbientUniform;

	//DIFFUSE

	float difIntensity = max(0.0, dot(normalize(interpolatedNormal), normalize(lightDirectView)));

	float light_DFF = difIntensity * kDiffuseUniform;

	//SPECULAR


	vec3 Blight = - normalize(lightDirectView) + 2.0 * dot(normalize(interpolatedNormal), normalize(lightDirectView)) * normalize(interpolatedNormal);

	float intensity = max(0.0, dot(normalize(Blight), normalize(-pos)));

	float light_SPC = pow(intensity, shininessUniform) * kSpecularUniform ; 




	float lightIntensity = (light_SPC + light_DFF + light_AMB) * angle;



   	vec4 resultingColor = vec4(1.0,1.0,1.0,1.0);


   	if (lightIntensity < 0.90) {
   		resultingColor = vec4(0.4,0.6,0.99,1.0);
   	} if (lightIntensity < 0.8) {
   		resultingColor = vec4(0.40,0.60,0.88,1.0);
   	} if (lightIntensity < 0.7) {
   		resultingColor = vec4(0.19,0.25,0.68,1.0);
   	} if (lightIntensity < 0.55) {
   		resultingColor = vec4(0.196,0.2,0.488,1.0);
   	}

   	if (dot(normalize(interpolatedNormal), normalize(-pos)) < 0.15){
        resultingColor = vec4(0.0,0.15,0.288,1.0);
   	}
    if (lightIntensity < 0.9){

        if (mod(gl_FragCoord.x + gl_FragCoord.y, 10.0) == 0.0)
            resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    
    if (lightIntensity < 0.8){

        if (mod(gl_FragCoord.x - gl_FragCoord.y, 10.0) == 0.0)
            resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    
    if (lightIntensity < 0.7){

        if (mod(gl_FragCoord.x + gl_FragCoord.y - 5.0, 10.0) == 0.0)
            resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    
    if (lightIntensity < 0.55){

        if (mod(gl_FragCoord.x - gl_FragCoord.y - 5.0, 10.0) == 0.0)
            resultingColor = vec4(0.0, 0.0, 0.0, 1.0);
    }


  vec3 TOTAL = mix(resultingColor.xyz , difIntensity * kDiffuseUniform * SpotColor, 0.4);

  out_FragColor = vec4(TOTAL, 1.0);
}
