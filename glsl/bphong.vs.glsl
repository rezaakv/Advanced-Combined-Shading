#version 300 es

out vec3 vcsNormal;
out vec3 vcsPosition;

uniform vec3 armadilloPosition;

uniform float leg_angle;

void main() {
	// viewing coordinate system
	vcsNormal = normalMatrix * normal;
	vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));

	// world coordicate system
	vec3 wcsPosition = vec3(modelMatrix * vec4(position, 1.0)).xyz;
  wcsPosition += armadilloPosition;






   mat4 rotationMat =  mat4(1.0, 0.0, 0.0, 0.0, 
                            0.0, 1.0 , 0.0, 0.0, 
                            0.0, 0.0 , 1.0, 0.0,
                            0.0, 0.0 , 0.0, 1.0);


    // Scale matrix
    mat4 S = mat4(10.0);
    S[3][3] = 1.0;

    // Translation matrix
    mat4 T = mat4(1.0);
    T[3].xyz = armadilloPosition;



    vec4 legOrigin = vec4(-0.2,0.155, 0.0 , 0.0);

    //Left Leg
    if(position.x < -0.2 && position.y < 0.155) {
                rotationMat =  mat4(1.0, 0.0, 0.0, 0.0, 
                            0.0, cos(sin(leg_angle*3.14) / 2.0), -sin(sin(leg_angle*3.14)/ 2.0), 0.0, 
                            0.0, sin(sin(leg_angle*3.14)/ 2.0) , cos(sin(leg_angle*3.14)/ 2.0), 0.0,
                            0.0, 0.0 , 0.0, 1.0);
       // segment = 0.8;


    }




    //right leg
      if(position.x > 0.2 && position.y < 0.155) {
                rotationMat =  mat4(1.0, 0.0, 0.0, 0.0, 
                            0.0, cos(-sin(leg_angle*3.14) / 2.0), -sin(-sin(leg_angle*3.14)/ 2.0), 0.0, 
                            0.0, sin(-sin(leg_angle*3.14)/ 2.0) , cos(-sin(leg_angle*3.14)/ 2.0), 0.0,
                            0.0, 0.0 , 0.0, 1.0);
        vec4 legOrigin = vec4(0.2,0.155, 0.0 , 0.0);
       // segment = 0.4;
    }





    vec4 wpos = modelMatrix * (rotationMat * (vec4(position, 1.0) - legOrigin) + legOrigin) + vec4(armadilloPosition, 0.0);


	gl_Position = projectionMatrix * viewMatrix * wpos;
}
