#version 300 es

out vec4 out_FragColor;

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
	//TODO: PART 1A

	//AMBIENT

	vec3 light_AMB = kAmbientUniform * ambientColorUniform;

	//DIFFUSE

	float difIntensity = max(0.0, dot(normalize(interpolatedNormal), normalize(lightDirectView)));

	vec3 light_DFF = difIntensity * kDiffuseUniform * lightColorUniform;

	//SPECULAR


	vec3 Blight = - normalize(lightDirectView) + 2.0 * dot(normalize(interpolatedNormal), normalize(lightDirectView)) * normalize(interpolatedNormal);

	float intensity = max(0.0, dot(normalize(Blight), normalize(-pos)));

	vec3 light_SPC = pow(intensity, shininessUniform) * kSpecularUniform * lightColorUniform; 

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF + light_SPC;
	out_FragColor = vec4(TOTAL, 1.0);
	}


	