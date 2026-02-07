precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

// We will use a script to replace this HEX with your Matugen color
vec3 accent = vec3(R_VAL, G_VAL, B_VAL); 

void main() {
    vec4 pix = texture2D(tex, v_texcoord);
    // Tinting logic: Blends 20% of the accent color into the window
    pix.rgb = mix(pix.rgb, accent, 0.2);
    gl_FragColor = pix;
}