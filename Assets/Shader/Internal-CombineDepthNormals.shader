½PShader "Hidden/Internal-CombineDepthNormals" {
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _CameraNormalsTexture_ST;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _CameraNormalsTexture_ST.xy) + _CameraNormalsTexture_ST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 _WorldToCamera;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 n_2;
  highp float d_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x;
  d_3 = tmpvar_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_CameraNormalsTexture, xlv_TEXCOORD0) * 2.0) - 1.0).xyz;
  n_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (1.0/(((_ZBufferParams.x * d_3) + _ZBufferParams.y)));
  d_3 = tmpvar_6;
  mat3 tmpvar_7;
  tmpvar_7[0] = _WorldToCamera[0].xyz;
  tmpvar_7[1] = _WorldToCamera[1].xyz;
  tmpvar_7[2] = _WorldToCamera[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * n_2);
  n_2.xy = tmpvar_8.xy;
  n_2.z = -(tmpvar_8.z);
  highp vec4 tmpvar_9;
  if ((tmpvar_6 < 0.999985)) {
    highp vec4 enc_10;
    enc_10.xy = ((((tmpvar_8.xy / (n_2.z + 1.0)) / 1.7777) * 0.5) + 0.5);
    highp vec2 enc_11;
    highp vec2 tmpvar_12;
    tmpvar_12 = fract((vec2(1.0, 255.0) * tmpvar_6));
    enc_11.y = tmpvar_12.y;
    enc_11.x = (tmpvar_12.x - (tmpvar_12.y * 0.00392157));
    enc_10.zw = enc_11;
    tmpvar_9 = enc_10;
  } else {
    tmpvar_9 = vec4(0.5, 0.5, 1.0, 1.0);
  };
  tmpvar_1 = tmpvar_9;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 321
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 315
struct appdata {
    highp vec4 vertex;
    highp vec2 texcoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 327
uniform highp vec4 _CameraNormalsTexture_ST;
#line 335
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp mat4 _WorldToCamera;
#line 328
v2f vert( in appdata v ) {
    v2f o;
    #line 331
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ((v.texcoord.xy * _CameraNormalsTexture_ST.xy) + _CameraNormalsTexture_ST.zw);
    return o;
}
out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 151
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 187
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 181
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 321
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 315
struct appdata {
    highp vec4 vertex;
    highp vec2 texcoord;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_LightPosition[8];
uniform highp vec4 unity_LightAtten[8];
#line 19
uniform highp vec4 unity_SpotDirection[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
#line 23
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
#line 27
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
#line 31
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
#line 35
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
#line 39
uniform highp mat4 _Object2World;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
#line 43
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
#line 47
uniform highp mat4 glstate_matrix_projection;
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
#line 51
uniform lowp vec4 unity_ColorSpaceGrey;
#line 77
#line 82
#line 87
#line 91
#line 96
#line 120
#line 137
#line 158
#line 166
#line 193
#line 206
#line 215
#line 220
#line 229
#line 234
#line 243
#line 260
#line 265
#line 291
#line 299
#line 307
#line 311
#line 327
uniform highp vec4 _CameraNormalsTexture_ST;
#line 335
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp mat4 _WorldToCamera;
#line 220
highp vec2 EncodeFloatRG( in highp float v ) {
    highp vec2 kEncodeMul = vec2( 1.0, 255.0);
    highp float kEncodeBit = 0.00392157;
    #line 224
    highp vec2 enc = (kEncodeMul * v);
    enc = fract(enc);
    enc.x -= (enc.y * kEncodeBit);
    return enc;
}
#line 234
highp vec2 EncodeViewNormalStereo( in highp vec3 n ) {
    highp float kScale = 1.7777;
    highp vec2 enc;
    #line 238
    enc = (n.xy / (n.z + 1.0));
    enc /= kScale;
    enc = ((enc * 0.5) + 0.5);
    return enc;
}
#line 253
highp vec4 EncodeDepthNormal( in highp float depth, in highp vec3 normal ) {
    #line 255
    highp vec4 enc;
    enc.xy = EncodeViewNormalStereo( normal);
    enc.zw = EncodeFloatRG( depth);
    return enc;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 338
lowp vec4 frag( in v2f i ) {
    #line 340
    highp float d = texture( _CameraDepthTexture, i.uv).x;
    highp vec3 n = vec3( ((texture( _CameraNormalsTexture, i.uv) * 2.0) - 1.0));
    d = Linear01Depth( d);
    n = (mat3( _WorldToCamera) * n);
    #line 344
    n.z = (-n.z);
    return (( (d < 0.999985) ) ? ( EncodeDepthNormal( d, n.xyz) ) : ( vec4( 0.5, 0.5, 1.0, 1.0) ));
}
in highp vec2 xlv_TEXCOORD0;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec2(xlv_TEXCOORD0);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
Fallback Off
}