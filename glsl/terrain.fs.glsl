#version 300 es

out vec4 out_FragColor;

in vec3 vcsNormal;
in vec3 vcsPosition;
in vec2 vcsTexcoord;

in vec4 PosFromLight;

uniform vec3 lightColor;
uniform vec3 ambientColor;
uniform vec3 lightDirection;

uniform float kAmbient;
uniform float kDiffuse;
uniform float kSpecular;
uniform float shininess;

uniform sampler2D colorMap;
uniform sampler2D normalMap;
uniform sampler2D aoMap;
uniform sampler2D shadowMap;

void main() {
	// TANGENT SPACE NORMAL
	vec3 Nt = normalize(texture(normalMap, vcsTexcoord).xyz * 2.0 - 1.0);

	vec3 Ni = normalize(vcsNormal);

	//tangent to plane
    vec3 T = normalize(cross(Ni, vec3(0.0, 1.0, 0.0)));
    vec3 B = normalize(cross(Ni, T));
    mat3 TBN = mat3(T, B, Ni);






	// PRE-CALCS
	vec3 L = normalize(vec3(viewMatrix * vec4(lightDirection, 0.0))) * TBN;
	vec3 V = normalize(-vcsPosition) * TBN;
	vec3 H = normalize((V + L) * 0.5);

	//AMBIENT
	vec3 light_AMB = texture(aoMap, vcsTexcoord).xyz * kAmbient;

	//DIFFUSE
	vec3 diffuse = kDiffuse * texture(colorMap, vcsTexcoord).xyz;
	vec3 light_DFF = diffuse * max(0.0, dot(Nt, L));

	//SPECULAR
	vec3 specular = kSpecular * lightColor;
	vec3 light_SPC = specular * pow(max(0.0, dot(H, Nt)), shininess);

	//TOTAL
	vec3 TOTAL = light_AMB + light_DFF  + light_SPC;

	float lengthLight = ((PosFromLight.z/PosFromLight.w)+1.0)/2.0;

    float texture_x = ((PosFromLight.x/PosFromLight.w)+1.0)/2.0;
    float texture_y = ((PosFromLight.y/PosFromLight.w)+1.0)/2.0;

    float shadow_map_dist = texture(shadowMap, vec2(texture_x, texture_y)).x;

	float bias = 0.001;

    if(shadow_map_dist < lengthLight-bias) {
        TOTAL = TOTAL * 0.2;
    }




	out_FragColor = vec4(TOTAL, 1.0);
}
