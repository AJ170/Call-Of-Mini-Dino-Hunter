ßÈShader "Hidden/Camera-DepthTexture" {
Properties {
 _MainTex ("", 2D) = "white" {}
 _Cutoff ("", Float) = 0.5
 _Color ("", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}



#endif
#ifdef FRAGMENT

void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
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
#line 315
struct v2f {
    highp vec4 pos;
};
#line 52
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
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
#line 320
#line 320
v2f vert( in appdata_base v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 325
    return o;
}
void main() {
    v2f xl_retval;
    appdata_base xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
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
#line 315
struct v2f {
    highp vec4 pos;
};
#line 52
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
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
#line 320
#line 327
lowp vec4 frag( in v2f i ) {
    #line 329
    return vec4( 0.0);
}
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
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
SubShader { 
 Tags { "RenderType"="TransparentCutout" }
 Pass {
  Tags { "RenderType"="TransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _MainTex_ST;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform lowp vec4 _Color;
uniform lowp float _Cutoff;
uniform sampler2D _MainTex;
void main ()
{
  lowp float x_1;
  x_1 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * _Color.w) - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
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
#line 315
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 52
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
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
#line 321
uniform highp vec4 _MainTex_ST;
#line 330
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
uniform lowp vec4 _Color;
#line 322
v2f vert( in appdata_base v ) {
    v2f o;
    #line 325
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ((v.texcoord.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    return o;
}
out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata_base xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
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
#line 315
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 52
struct appdata_base {
    highp vec4 vertex;
    highp vec3 normal;
    highp vec4 texcoord;
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
#line 321
uniform highp vec4 _MainTex_ST;
#line 330
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
uniform lowp vec4 _Color;
#line 333
lowp vec4 frag( in v2f i ) {
    #line 335
    lowp vec4 texcol = texture( _MainTex, i.uv);
    xll_clip_f(((texcol.w * _Color.w) - _Cutoff));
    return vec4( 0.0);
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
SubShader { 
 Tags { "RenderType"="TreeBark" }
 Pass {
  Tags { "RenderType"="TreeBark" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

uniform highp vec4 _Wind;
uniform highp float _SquashAmount;
uniform highp vec4 _SquashPlaneNormal;
uniform highp vec4 _Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesMultiTexCoord1;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = (_glesVertex.xyz * _Scale.xyz);
  highp vec4 pos_2;
  pos_2.w = tmpvar_1.w;
  highp vec3 bend_3;
  vec4 v_4;
  v_4.x = _Object2World[0].w;
  v_4.y = _Object2World[1].w;
  v_4.z = _Object2World[2].w;
  v_4.w = _Object2World[3].w;
  highp float tmpvar_5;
  tmpvar_5 = (dot (v_4.xyz, vec3(1.0, 1.0, 1.0)) + _glesColor.x);
  highp vec2 tmpvar_6;
  tmpvar_6.x = dot (tmpvar_1.xyz, vec3((_glesColor.y + tmpvar_5)));
  tmpvar_6.y = tmpvar_5;
  highp vec4 tmpvar_7;
  tmpvar_7 = abs(((fract((((fract(((_Time.yy + tmpvar_6).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0) - 1.0) + 0.5)) * 2.0) - 1.0));
  highp vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) * (3.0 - (2.0 * tmpvar_7)));
  highp vec2 tmpvar_9;
  tmpvar_9 = (tmpvar_8.xz + tmpvar_8.yw);
  bend_3.xz = ((_glesColor.y * 0.1) * _glesNormal).xz;
  bend_3.y = (_glesMultiTexCoord1.y * 0.3);
  pos_2.xyz = (tmpvar_1.xyz + (((tmpvar_9.xyx * bend_3) + ((_Wind.xyz * tmpvar_9.y) * _glesMultiTexCoord1.y)) * _Wind.w));
  pos_2.xyz = (pos_2.xyz + (_glesMultiTexCoord1.x * _Wind.xyz));
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = mix ((pos_2.xyz - ((dot (_SquashPlaneNormal.xyz, pos_2.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_2.xyz, vec3(_SquashAmount));
  tmpvar_1 = tmpvar_10;
  gl_Position = (glstate_matrix_mvp * tmpvar_10);
}



#endif
#ifdef FRAGMENT

void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT _glesTANGENT
in vec4 _glesTANGENT;
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 581
struct v2f {
    highp vec4 pos;
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
#line 393
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
#line 397
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
#line 401
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
uniform highp vec4 _TreeBillboardDistances;
#line 421
#line 469
#line 487
#line 501
#line 513
uniform highp vec4 _Wind;
#line 586
#line 594
#line 523
highp vec4 SmoothCurve( in highp vec4 x ) {
    #line 525
    return ((x * x) * (3.0 - (2.0 * x)));
}
#line 527
highp vec4 TriangleWave( in highp vec4 x ) {
    #line 529
    return abs(((fract((x + 0.5)) * 2.0) - 1.0));
}
#line 531
highp vec4 SmoothTriangleWave( in highp vec4 x ) {
    #line 533
    return SmoothCurve( TriangleWave( x));
}
#line 535
highp vec4 AnimateVertex( in highp vec4 pos, in highp vec3 normal, in highp vec4 animParams ) {
    #line 537
    highp float fDetailAmp = 0.1;
    highp float fBranchAmp = 0.3;
    highp float fObjPhase = dot( xll_matrixindex_mf4x4_i (_Object2World, 3).xyz, vec3( 1.0));
    highp float fBranchPhase = (fObjPhase + animParams.x);
    #line 541
    highp float fVtxPhase = dot( pos.xyz, vec3( (animParams.y + fBranchPhase)));
    highp vec2 vWavesIn = (_Time.yy + vec2( fVtxPhase, fBranchPhase));
    highp vec4 vWaves = ((fract((vWavesIn.xxyy * vec4( 1.975, 0.793, 0.375, 0.193))) * 2.0) - 1.0);
    vWaves = SmoothTriangleWave( vWaves);
    #line 545
    highp vec2 vWavesSum = (vWaves.xz + vWaves.yw);
    highp vec3 bend = ((animParams.y * fDetailAmp) * normal.xyz);
    bend.y = (animParams.w * fBranchAmp);
    pos.xyz += (((vWavesSum.xyx * bend) + ((_Wind.xyz * vWavesSum.y) * animParams.w)) * _Wind.w);
    #line 549
    pos.xyz += (animParams.z * _Wind.xyz);
    return pos;
}
#line 487
highp vec4 Squash( in highp vec4 pos ) {
    highp vec3 planeNormal = _SquashPlaneNormal.xyz;
    highp vec3 projectedVertex = (pos.xyz - ((dot( planeNormal, vec3( pos)) + _SquashPlaneNormal.w) * planeNormal));
    #line 491
    pos = vec4( mix( projectedVertex, pos.xyz, vec3( _SquashAmount)), 1.0);
    return pos;
}
#line 552
void TreeVertBark( inout appdata_full v ) {
    #line 554
    v.vertex.xyz *= _Scale.xyz;
    v.vertex = AnimateVertex( v.vertex, v.normal, vec4( v.color.xy, v.texcoord1.xy));
    v.vertex = Squash( v.vertex);
    v.color = vec4( 1.0, 1.0, 1.0, v.color.w);
    #line 558
    v.normal = normalize(v.normal);
    v.tangent.xyz = normalize(v.tangent.xyz);
}
#line 586
v2f vert( in appdata_full v ) {
    v2f o;
    TreeVertBark( v);
    #line 590
    o.pos = (glstate_matrix_mvp * v.vertex);
    return o;
}

void main() {
    v2f xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 581
struct v2f {
    highp vec4 pos;
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
#line 393
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
#line 397
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
#line 401
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
uniform highp vec4 _TreeBillboardDistances;
#line 421
#line 469
#line 487
#line 501
#line 513
uniform highp vec4 _Wind;
#line 586
#line 594
#line 594
lowp vec4 frag( in v2f i ) {
    return vec4( 0.0);
}
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
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
SubShader { 
 Tags { "RenderType"="TreeLeaf" }
 Pass {
  Tags { "RenderType"="TreeLeaf" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _Wind;
uniform highp float _SquashAmount;
uniform highp vec4 _SquashPlaneNormal;
uniform highp vec4 _Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Time;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp float tmpvar_2;
  tmpvar_2 = (1.0 - abs(_glesTANGENT.w));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = _glesNormal.xy;
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex + ((tmpvar_4 * glstate_matrix_invtrans_modelview0) * tmpvar_2));
  tmpvar_1.w = tmpvar_5.w;
  tmpvar_1.xyz = (tmpvar_5.xyz * _Scale.xyz);
  highp vec4 pos_6;
  pos_6.w = tmpvar_1.w;
  highp vec3 bend_7;
  vec4 v_8;
  v_8.x = _Object2World[0].w;
  v_8.y = _Object2World[1].w;
  v_8.z = _Object2World[2].w;
  v_8.w = _Object2World[3].w;
  highp float tmpvar_9;
  tmpvar_9 = (dot (v_8.xyz, vec3(1.0, 1.0, 1.0)) + _glesColor.x);
  highp vec2 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_1.xyz, vec3((_glesColor.y + tmpvar_9)));
  tmpvar_10.y = tmpvar_9;
  highp vec4 tmpvar_11;
  tmpvar_11 = abs(((fract((((fract(((_Time.yy + tmpvar_10).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0) - 1.0) + 0.5)) * 2.0) - 1.0));
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_11 * tmpvar_11) * (3.0 - (2.0 * tmpvar_11)));
  highp vec2 tmpvar_13;
  tmpvar_13 = (tmpvar_12.xz + tmpvar_12.yw);
  bend_7.xz = ((_glesColor.y * 0.1) * mix (_glesNormal, normalize((tmpvar_3 * glstate_matrix_invtrans_modelview0)).xyz, vec3(tmpvar_2))).xz;
  bend_7.y = (_glesMultiTexCoord1.y * 0.3);
  pos_6.xyz = (tmpvar_1.xyz + (((tmpvar_13.xyx * bend_7) + ((_Wind.xyz * tmpvar_13.y) * _glesMultiTexCoord1.y)) * _Wind.w));
  pos_6.xyz = (pos_6.xyz + (_glesMultiTexCoord1.x * _Wind.xyz));
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = mix ((pos_6.xyz - ((dot (_SquashPlaneNormal.xyz, pos_6.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_6.xyz, vec3(_SquashAmount));
  tmpvar_1 = tmpvar_14;
  gl_Position = (glstate_matrix_mvp * tmpvar_14);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform lowp float _Cutoff;
uniform sampler2D _MainTex;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT _glesTANGENT
in vec4 _glesTANGENT;
vec2 xll_matrixindex_mf2x2_i (mat2 m, int i) { vec2 v; v.x=m[0][i]; v.y=m[1][i]; return v; }
vec3 xll_matrixindex_mf3x3_i (mat3 m, int i) { vec3 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; return v; }
vec4 xll_matrixindex_mf4x4_i (mat4 m, int i) { vec4 v; v.x=m[0][i]; v.y=m[1][i]; v.z=m[2][i]; v.w=m[3][i]; return v; }
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 581
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
#line 393
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
#line 397
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
#line 401
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
uniform highp vec4 _TreeBillboardDistances;
#line 421
#line 469
#line 487
#line 501
#line 513
uniform highp vec4 _Wind;
#line 587
#line 596
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
#line 523
highp vec4 SmoothCurve( in highp vec4 x ) {
    #line 525
    return ((x * x) * (3.0 - (2.0 * x)));
}
#line 527
highp vec4 TriangleWave( in highp vec4 x ) {
    #line 529
    return abs(((fract((x + 0.5)) * 2.0) - 1.0));
}
#line 531
highp vec4 SmoothTriangleWave( in highp vec4 x ) {
    #line 533
    return SmoothCurve( TriangleWave( x));
}
#line 535
highp vec4 AnimateVertex( in highp vec4 pos, in highp vec3 normal, in highp vec4 animParams ) {
    #line 537
    highp float fDetailAmp = 0.1;
    highp float fBranchAmp = 0.3;
    highp float fObjPhase = dot( xll_matrixindex_mf4x4_i (_Object2World, 3).xyz, vec3( 1.0));
    highp float fBranchPhase = (fObjPhase + animParams.x);
    #line 541
    highp float fVtxPhase = dot( pos.xyz, vec3( (animParams.y + fBranchPhase)));
    highp vec2 vWavesIn = (_Time.yy + vec2( fVtxPhase, fBranchPhase));
    highp vec4 vWaves = ((fract((vWavesIn.xxyy * vec4( 1.975, 0.793, 0.375, 0.193))) * 2.0) - 1.0);
    vWaves = SmoothTriangleWave( vWaves);
    #line 545
    highp vec2 vWavesSum = (vWaves.xz + vWaves.yw);
    highp vec3 bend = ((animParams.y * fDetailAmp) * normal.xyz);
    bend.y = (animParams.w * fBranchAmp);
    pos.xyz += (((vWavesSum.xyx * bend) + ((_Wind.xyz * vWavesSum.y) * animParams.w)) * _Wind.w);
    #line 549
    pos.xyz += (animParams.z * _Wind.xyz);
    return pos;
}
#line 514
void ExpandBillboard( in highp mat4 mat, inout highp vec4 pos, inout highp vec3 normal, inout highp vec4 tangent ) {
    highp float isBillboard = (1.0 - abs(tangent.w));
    #line 517
    highp vec3 norb = vec3( normalize((vec4( normal, 0.0) * mat)));
    highp vec3 tanb = vec3( normalize((vec4( tangent.xyz, 0.0) * mat)));
    pos += ((vec4( normal.xy, 0.0, 0.0) * mat) * isBillboard);
    normal = mix( normal, norb, vec3( isBillboard));
    #line 521
    tangent = mix( tangent, vec4( tanb, -1.0), vec4( isBillboard));
}
#line 487
highp vec4 Squash( in highp vec4 pos ) {
    highp vec3 planeNormal = _SquashPlaneNormal.xyz;
    highp vec3 projectedVertex = (pos.xyz - ((dot( planeNormal, vec3( pos)) + _SquashPlaneNormal.w) * planeNormal));
    #line 491
    pos = vec4( mix( projectedVertex, pos.xyz, vec3( _SquashAmount)), 1.0);
    return pos;
}
#line 561
void TreeVertLeaf( inout appdata_full v ) {
    #line 563
    ExpandBillboard( glstate_matrix_invtrans_modelview0, v.vertex, v.normal, v.tangent);
    v.vertex.xyz *= _Scale.xyz;
    v.vertex = AnimateVertex( v.vertex, v.normal, vec4( v.color.xy, v.texcoord1.xy));
    v.vertex = Squash( v.vertex);
    #line 567
    v.color = vec4( 1.0, 1.0, 1.0, v.color.w);
    v.normal = normalize(v.normal);
    v.tangent.xyz = normalize(v.tangent.xyz);
}
#line 587
v2f vert( in appdata_full v ) {
    v2f o;
    TreeVertLeaf( v);
    #line 591
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = v.texcoord.xy;
    return o;
}

out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
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
#line 315
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 581
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
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
#line 325
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 338
#line 346
#line 360
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
#line 393
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
#line 397
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
#line 401
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
uniform highp vec4 _TreeBillboardDistances;
#line 421
#line 469
#line 487
#line 501
#line 513
uniform highp vec4 _Wind;
#line 587
#line 596
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
#line 598
lowp vec4 frag( in v2f i ) {
    #line 600
    mediump float alpha = texture( _MainTex, i.uv).w;
    xll_clip_f((alpha - _Cutoff));
    return vec4( 0.0);
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
SubShader { 
 Tags { "RenderType"="TreeOpaque" }
 Pass {
  Tags { "RenderType"="TreeOpaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

uniform highp float _SquashAmount;
uniform highp vec4 _SquashPlaneNormal;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _Scale;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 pos_1;
  pos_1.w = _glesVertex.w;
  pos_1.xyz = (_glesVertex.xyz * _Scale.xyz);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = pos_1.xyz;
  pos_1.xyz = mix (pos_1.xyz, (_TerrainEngineBendTree * tmpvar_2).xyz, _glesColor.www);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = mix ((pos_1.xyz - ((dot (_SquashPlaneNormal.xyz, pos_1.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_1.xyz, vec3(_SquashAmount));
  pos_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
}



#endif
#ifdef FRAGMENT

void main ()
{
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;

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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
};
#line 510
struct appdata {
    highp vec4 vertex;
    lowp vec4 color;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 516
#line 524
#line 411
highp vec4 Squash( in highp vec4 pos ) {
    highp vec3 planeNormal = _SquashPlaneNormal.xyz;
    highp vec3 projectedVertex = (pos.xyz - ((dot( planeNormal, vec3( pos)) + _SquashPlaneNormal.w) * planeNormal));
    #line 415
    pos = vec4( mix( projectedVertex, pos.xyz, vec3( _SquashAmount)), 1.0);
    return pos;
}
#line 418
void TerrainAnimateTree( inout highp vec4 pos, in highp float alpha ) {
    #line 420
    pos.xyz *= _Scale.xyz;
    highp vec3 bent = (_TerrainEngineBendTree * vec4( pos.xyz, 0.0)).xyz;
    pos.xyz = mix( pos.xyz, bent, vec3( alpha));
    pos = Squash( pos);
}
#line 516
v2f vert( in appdata v ) {
    v2f o;
    TerrainAnimateTree( v.vertex, v.color.w);
    #line 520
    o.pos = (glstate_matrix_mvp * v.vertex);
    return o;
}
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
};
#line 510
struct appdata {
    highp vec4 vertex;
    lowp vec4 color;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 516
#line 524
#line 524
lowp vec4 frag( in v2f i ) {
    return vec4( 0.0);
}
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
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
SubShader { 
 Tags { "RenderType"="TreeTransparentCutout" }
 Pass {
  Tags { "RenderType"="TreeTransparentCutout" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp float _SquashAmount;
uniform highp vec4 _SquashPlaneNormal;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _Scale;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 pos_1;
  pos_1.w = _glesVertex.w;
  pos_1.xyz = (_glesVertex.xyz * _Scale.xyz);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = pos_1.xyz;
  pos_1.xyz = mix (pos_1.xyz, (_TerrainEngineBendTree * tmpvar_2).xyz, _glesColor.www);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = mix ((pos_1.xyz - ((dot (_SquashPlaneNormal.xyz, pos_1.xyz) + _SquashPlaneNormal.w) * _SquashPlaneNormal.xyz)), pos_1.xyz, vec3(_SquashAmount));
  pos_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * tmpvar_3);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform lowp float _Cutoff;
uniform sampler2D _MainTex;
void main ()
{
  mediump float alpha_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (alpha_1 - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 511
struct appdata {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec4 texcoord;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 518
#line 527
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
#line 411
highp vec4 Squash( in highp vec4 pos ) {
    highp vec3 planeNormal = _SquashPlaneNormal.xyz;
    highp vec3 projectedVertex = (pos.xyz - ((dot( planeNormal, vec3( pos)) + _SquashPlaneNormal.w) * planeNormal));
    #line 415
    pos = vec4( mix( projectedVertex, pos.xyz, vec3( _SquashAmount)), 1.0);
    return pos;
}
#line 418
void TerrainAnimateTree( inout highp vec4 pos, in highp float alpha ) {
    #line 420
    pos.xyz *= _Scale.xyz;
    highp vec3 bent = (_TerrainEngineBendTree * vec4( pos.xyz, 0.0)).xyz;
    pos.xyz = mix( pos.xyz, bent, vec3( alpha));
    pos = Squash( pos);
}
#line 518
v2f vert( in appdata v ) {
    v2f o;
    TerrainAnimateTree( v.vertex, v.color.w);
    #line 522
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = v.texcoord.xy;
    return o;
}
out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 511
struct appdata {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec4 texcoord;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 518
#line 527
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
#line 529
lowp vec4 frag( in v2f i ) {
    #line 531
    mediump float alpha = texture( _MainTex, i.uv).w;
    xll_clip_f((alpha - _Cutoff));
    return vec4( 0.0);
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
SubShader { 
 Tags { "RenderType"="TreeBillboard" }
 Pass {
  Tags { "RenderType"="TreeBillboard" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 _TreeBillboardDistances;
uniform highp vec4 _TreeBillboardCameraPos;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 pos_2;
  pos_2 = _glesVertex;
  highp vec2 offset_3;
  offset_3 = _glesMultiTexCoord1.xy;
  highp float offsetz_4;
  offsetz_4 = _glesMultiTexCoord0.y;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_glesVertex.xyz - _TreeBillboardCameraPos.xyz);
  highp float tmpvar_6;
  tmpvar_6 = dot (tmpvar_5, tmpvar_5);
  if ((tmpvar_6 > _TreeBillboardDistances.x)) {
    offsetz_4 = 0.0;
    offset_3 = vec2(0.0, 0.0);
  };
  pos_2.xyz = (_glesVertex.xyz + (_TreeBillboardCameraRight * offset_3.x));
  pos_2.xyz = (pos_2.xyz + (_TreeBillboardCameraUp.xyz * mix (offset_3.y, offsetz_4, _TreeBillboardCameraPos.w)));
  pos_2.xyz = (pos_2.xyz + ((_TreeBillboardCameraFront.xyz * abs(offset_3.x)) * _TreeBillboardCameraUp.w));
  tmpvar_1.x = _glesMultiTexCoord0.x;
  tmpvar_1.y = float((_glesMultiTexCoord0.y > 0.0));
  gl_Position = (glstate_matrix_mvp * pos_2);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _MainTex;
void main ()
{
  lowp float x_1;
  x_1 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.001);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;

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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 337
struct appdata_tree_billboard {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec4 texcoord;
    highp vec2 texcoord1;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 511
uniform sampler2D _MainTex;
#line 425
void TerrainBillboardTree( inout highp vec4 pos, in highp vec2 offset, in highp float offsetz ) {
    highp vec3 treePos = (pos.xyz - _TreeBillboardCameraPos.xyz);
    highp float treeDistanceSqr = dot( treePos, treePos);
    #line 429
    if ((treeDistanceSqr > _TreeBillboardDistances.x)){
        offset.xy = vec2( offsetz = 0.0);
    }
    pos.xyz += (_TreeBillboardCameraRight.xyz * offset.x);
    highp float billboardAngleFactor = _TreeBillboardCameraPos.w;
    highp float radius = mix( offset.y, offsetz, billboardAngleFactor);
    #line 433
    pos.xyz += (_TreeBillboardCameraUp.xyz * radius);
    highp float billboardOffsetFactor = _TreeBillboardCameraUp.w;
    pos.xyz += ((_TreeBillboardCameraFront.xyz * abs(offset.x)) * billboardOffsetFactor);
}
#line 511
v2f vert( in appdata_tree_billboard v ) {
    v2f o;
    TerrainBillboardTree( v.vertex, v.texcoord1.xy, v.texcoord.y);
    #line 515
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv.x = v.texcoord.x;
    o.uv.y = float((v.texcoord.y > 0.0));
    #line 519
    return o;
}
out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata_tree_billboard xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.color = vec4(gl_Color);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec2(gl_MultiTexCoord1);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
};
#line 337
struct appdata_tree_billboard {
    highp vec4 vertex;
    lowp vec4 color;
    highp vec4 texcoord;
    highp vec2 texcoord1;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 511
uniform sampler2D _MainTex;
#line 522
lowp vec4 frag( in v2f i ) {
    #line 524
    lowp vec4 texcol = texture( _MainTex, i.uv);
    xll_clip_f((texcol.w - 0.001));
    return vec4( 0.0);
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
SubShader { 
 Tags { "RenderType"="GrassBillboard" }
 Pass {
  Tags { "RenderType"="GrassBillboard" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec3 _CameraUp;
uniform highp vec3 _CameraRight;
uniform highp vec4 _CameraPosition;
uniform highp vec4 _WaveAndDistance;
uniform lowp vec4 _WavingTint;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesTANGENT;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 pos_1;
  pos_1 = _glesVertex;
  highp vec2 offset_2;
  offset_2 = _glesTANGENT.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = (_glesVertex.xyz - _CameraPosition.xyz);
  highp float tmpvar_4;
  tmpvar_4 = dot (tmpvar_3, tmpvar_3);
  if ((tmpvar_4 > _WaveAndDistance.w)) {
    offset_2 = vec2(0.0, 0.0);
  };
  pos_1.xyz = (_glesVertex.xyz + (offset_2.x * _CameraRight));
  pos_1.xyz = (pos_1.xyz + (offset_2.y * _CameraUp));
  highp vec4 vertex_5;
  vertex_5.yw = pos_1.yw;
  lowp vec4 color_6;
  color_6.xyz = _glesColor.xyz;
  lowp vec3 waveColor_7;
  highp vec3 waveMove_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = ((fract((((pos_1.x * (vec4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y)) + (pos_1.z * (vec4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y))) + (_WaveAndDistance.x * vec4(1.2, 2.0, 1.6, 4.8)))) * 6.40885) - 3.14159);
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * tmpvar_9);
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * tmpvar_10);
  highp vec4 tmpvar_13;
  tmpvar_13 = (((tmpvar_9 + (tmpvar_11 * -0.161616)) + (tmpvar_12 * 0.0083333)) + ((tmpvar_12 * tmpvar_10) * -0.00019841));
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * tmpvar_13);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * tmpvar_14);
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_15 * _glesTANGENT.y);
  waveMove_8.y = 0.0;
  waveMove_8.x = dot (tmpvar_16, vec4(0.024, 0.04, -0.12, 0.096));
  waveMove_8.z = dot (tmpvar_16, vec4(0.006, 0.02, -0.02, 0.1));
  vertex_5.xz = (pos_1.xz - (waveMove_8.xz * _WaveAndDistance.z));
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (vec3(0.5, 0.5, 0.5), _WavingTint.xyz, vec3((dot (tmpvar_15, normalize(vec4(1.0, 1.0, 0.4, 0.2))) * 0.7)));
  waveColor_7 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (vertex_5.xyz - _CameraPosition.xyz);
  highp float tmpvar_19;
  tmpvar_19 = clamp (((2.0 * (_WaveAndDistance.w - dot (tmpvar_18, tmpvar_18))) * _CameraPosition.w), 0.0, 1.0);
  color_6.w = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20.xyz = ((2.0 * waveColor_7) * _glesColor.xyz);
  tmpvar_20.w = color_6.w;
  gl_Position = (glstate_matrix_mvp * vertex_5);
  xlv_COLOR = tmpvar_20;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform lowp float _Cutoff;
uniform sampler2D _MainTex;
void main ()
{
  lowp float x_1;
  x_1 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * xlv_COLOR.w) - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal _glesNormal
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT _glesTANGENT
in vec4 _glesTANGENT;
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec2 uv;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 512
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
#line 524
#line 393
void TerrainBillboardGrass( inout highp vec4 pos, in highp vec2 offset ) {
    highp vec3 grasspos = (pos.xyz - _CameraPosition.xyz);
    if ((dot( grasspos, grasspos) > _WaveAndDistance.w)){
        offset = vec2( 0.0);
    }
    #line 397
    pos.xyz += (offset.x * _CameraRight.xyz);
    pos.xyz += (offset.y * _CameraUp.xyz);
}
#line 345
void FastSinCos( in highp vec4 val, out highp vec4 s, out highp vec4 c ) {
    val = ((val * 6.40885) - 3.14159);
    highp vec4 r5 = (val * val);
    #line 349
    highp vec4 r6 = (r5 * r5);
    highp vec4 r7 = (r6 * r5);
    highp vec4 r8 = (r6 * r5);
    highp vec4 r1 = (r5 * val);
    #line 353
    highp vec4 r2 = (r1 * r5);
    highp vec4 r3 = (r2 * r5);
    highp vec4 sin7 = vec4( 1.0, -0.161616, 0.0083333, -0.00019841);
    #line 359
    highp vec4 cos8 = vec4( -0.5, 0.0416667, -0.00138889, 2.48016e-05);
    #line 363
    s = (((val + (r1 * sin7.y)) + (r2 * sin7.z)) + (r3 * sin7.w));
    c = ((((1.0 + (r5 * cos8.x)) + (r6 * cos8.y)) + (r7 * cos8.z)) + (r8 * cos8.w));
}
#line 366
lowp vec4 TerrainWaveGrass( inout highp vec4 vertex, in highp float waveAmount, in lowp vec4 color ) {
    #line 368
    highp vec4 _waveXSize = (vec4( 0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y);
    highp vec4 _waveZSize = (vec4( 0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y);
    highp vec4 waveSpeed = (vec4( 0.3, 0.5, 0.4, 1.2) * 4.0);
    highp vec4 _waveXmove = (vec4( 0.012, 0.02, -0.06, 0.048) * 2.0);
    #line 372
    highp vec4 _waveZmove = vec4( 0.006, 0.02, -0.02, 0.1);
    highp vec4 waves;
    waves = (vertex.x * _waveXSize);
    waves += (vertex.z * _waveZSize);
    #line 376
    waves += (_WaveAndDistance.x * waveSpeed);
    highp vec4 s;
    highp vec4 c;
    waves = fract(waves);
    FastSinCos( waves, s, c);
    #line 380
    s = (s * s);
    s = (s * s);
    highp float lighting = (dot( s, normalize(vec4( 1.0, 1.0, 0.4, 0.2))) * 0.7);
    s = (s * waveAmount);
    #line 384
    highp vec3 waveMove = vec3( 0.0, 0.0, 0.0);
    waveMove.x = dot( s, _waveXmove);
    waveMove.z = dot( s, _waveZmove);
    vertex.xz -= (waveMove.xz * _WaveAndDistance.z);
    #line 388
    lowp vec3 waveColor = mix( vec3( 0.5, 0.5, 0.5), _WavingTint.xyz, vec3( lighting));
    highp vec3 offset = (vertex.xyz - _CameraPosition.xyz);
    color.w = xll_saturate_f(((2.0 * (_WaveAndDistance.w - dot( offset, offset))) * _CameraPosition.w));
    return vec4( ((2.0 * waveColor) * color.xyz), color.w);
}
#line 405
void WavingGrassBillboardVert( inout appdata_full v ) {
    #line 407
    TerrainBillboardGrass( v.vertex, v.tangent.xy);
    highp float waveAmount = v.tangent.y;
    v.color = TerrainWaveGrass( v.vertex, waveAmount, v.color);
}
#line 512
v2f vert( in appdata_full v ) {
    v2f o;
    WavingGrassBillboardVert( v);
    #line 516
    o.color = v.color;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = v.texcoord.xy;
    #line 520
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec2 uv;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 512
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
#line 524
#line 524
lowp vec4 frag( in v2f i ) {
    lowp vec4 texcol = texture( _MainTex, i.uv);
    lowp float alpha = (texcol.w * i.color.w);
    #line 528
    xll_clip_f((alpha - _Cutoff));
    return vec4( 0.0);
}
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
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
SubShader { 
 Tags { "RenderType"="Grass" }
 Pass {
  Tags { "RenderType"="Grass" }
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform highp vec4 _CameraPosition;
uniform highp vec4 _WaveAndDistance;
uniform lowp vec4 _WavingTint;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesColor;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 vertex_1;
  vertex_1.yw = _glesVertex.yw;
  lowp vec4 color_2;
  color_2.xyz = _glesColor.xyz;
  lowp vec3 waveColor_3;
  highp vec3 waveMove_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = ((fract((((_glesVertex.x * (vec4(0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y)) + (_glesVertex.z * (vec4(0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y))) + (_WaveAndDistance.x * vec4(1.2, 2.0, 1.6, 4.8)))) * 6.40885) - 3.14159);
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * tmpvar_5);
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * tmpvar_6);
  highp vec4 tmpvar_9;
  tmpvar_9 = (((tmpvar_5 + (tmpvar_7 * -0.161616)) + (tmpvar_8 * 0.0083333)) + ((tmpvar_8 * tmpvar_6) * -0.00019841));
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * tmpvar_9);
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_10 * tmpvar_10);
  highp vec4 tmpvar_12;
  tmpvar_12 = (tmpvar_11 * (_glesColor.w * _WaveAndDistance.z));
  waveMove_4.y = 0.0;
  waveMove_4.x = dot (tmpvar_12, vec4(0.024, 0.04, -0.12, 0.096));
  waveMove_4.z = dot (tmpvar_12, vec4(0.006, 0.02, -0.02, 0.1));
  vertex_1.xz = (_glesVertex.xz - (waveMove_4.xz * _WaveAndDistance.z));
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (vec3(0.5, 0.5, 0.5), _WavingTint.xyz, vec3((dot (tmpvar_11, normalize(vec4(1.0, 1.0, 0.4, 0.2))) * 0.7)));
  waveColor_3 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = (vertex_1.xyz - _CameraPosition.xyz);
  highp float tmpvar_15;
  tmpvar_15 = clamp (((2.0 * (_WaveAndDistance.w - dot (tmpvar_14, tmpvar_14))) * _CameraPosition.w), 0.0, 1.0);
  color_2.w = tmpvar_15;
  lowp vec4 tmpvar_16;
  tmpvar_16.xyz = ((2.0 * waveColor_3) * _glesColor.xyz);
  tmpvar_16.w = color_2.w;
  gl_Position = (glstate_matrix_mvp * vertex_1);
  xlv_COLOR = tmpvar_16;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
uniform lowp float _Cutoff;
uniform sampler2D _MainTex;
void main ()
{
  lowp float x_1;
  x_1 = ((texture2D (_MainTex, xlv_TEXCOORD0).w * xlv_COLOR.w) - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = vec4(0.0, 0.0, 0.0, 0.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec2 uv;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 512
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
#line 524
#line 345
void FastSinCos( in highp vec4 val, out highp vec4 s, out highp vec4 c ) {
    val = ((val * 6.40885) - 3.14159);
    highp vec4 r5 = (val * val);
    #line 349
    highp vec4 r6 = (r5 * r5);
    highp vec4 r7 = (r6 * r5);
    highp vec4 r8 = (r6 * r5);
    highp vec4 r1 = (r5 * val);
    #line 353
    highp vec4 r2 = (r1 * r5);
    highp vec4 r3 = (r2 * r5);
    highp vec4 sin7 = vec4( 1.0, -0.161616, 0.0083333, -0.00019841);
    #line 359
    highp vec4 cos8 = vec4( -0.5, 0.0416667, -0.00138889, 2.48016e-05);
    #line 363
    s = (((val + (r1 * sin7.y)) + (r2 * sin7.z)) + (r3 * sin7.w));
    c = ((((1.0 + (r5 * cos8.x)) + (r6 * cos8.y)) + (r7 * cos8.z)) + (r8 * cos8.w));
}
#line 366
lowp vec4 TerrainWaveGrass( inout highp vec4 vertex, in highp float waveAmount, in lowp vec4 color ) {
    #line 368
    highp vec4 _waveXSize = (vec4( 0.012, 0.02, 0.06, 0.024) * _WaveAndDistance.y);
    highp vec4 _waveZSize = (vec4( 0.006, 0.02, 0.02, 0.05) * _WaveAndDistance.y);
    highp vec4 waveSpeed = (vec4( 0.3, 0.5, 0.4, 1.2) * 4.0);
    highp vec4 _waveXmove = (vec4( 0.012, 0.02, -0.06, 0.048) * 2.0);
    #line 372
    highp vec4 _waveZmove = vec4( 0.006, 0.02, -0.02, 0.1);
    highp vec4 waves;
    waves = (vertex.x * _waveXSize);
    waves += (vertex.z * _waveZSize);
    #line 376
    waves += (_WaveAndDistance.x * waveSpeed);
    highp vec4 s;
    highp vec4 c;
    waves = fract(waves);
    FastSinCos( waves, s, c);
    #line 380
    s = (s * s);
    s = (s * s);
    highp float lighting = (dot( s, normalize(vec4( 1.0, 1.0, 0.4, 0.2))) * 0.7);
    s = (s * waveAmount);
    #line 384
    highp vec3 waveMove = vec3( 0.0, 0.0, 0.0);
    waveMove.x = dot( s, _waveXmove);
    waveMove.z = dot( s, _waveZmove);
    vertex.xz -= (waveMove.xz * _WaveAndDistance.z);
    #line 388
    lowp vec3 waveColor = mix( vec3( 0.5, 0.5, 0.5), _WavingTint.xyz, vec3( lighting));
    highp vec3 offset = (vertex.xyz - _CameraPosition.xyz);
    color.w = xll_saturate_f(((2.0 * (_WaveAndDistance.w - dot( offset, offset))) * _CameraPosition.w));
    return vec4( ((2.0 * waveColor) * color.xyz), color.w);
}
#line 400
void WavingGrassVert( inout appdata_full v ) {
    #line 402
    highp float waveAmount = (v.color.w * _WaveAndDistance.z);
    v.color = TerrainWaveGrass( v.vertex, waveAmount, v.color);
}
#line 512
v2f vert( in appdata_full v ) {
    v2f o;
    WavingGrassVert( v);
    #line 516
    o.color = v.color;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = vec2( v.texcoord);
    #line 520
    return o;
}

out lowp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_COLOR = vec4(xl_retval.color);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
void xll_clip_f(float x) {
  if ( x<0.0 ) discard;
}
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
#line 67
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
#line 505
struct v2f {
    highp vec4 pos;
    lowp vec4 color;
    highp vec2 uv;
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
#line 315
uniform lowp vec4 _WavingTint;
uniform highp vec4 _WaveAndDistance;
uniform highp vec4 _CameraPosition;
uniform highp vec3 _CameraRight;
uniform highp vec3 _CameraUp;
#line 319
uniform highp vec4 _Scale;
uniform highp mat4 _TerrainEngineBendTree;
uniform highp vec4 _SquashPlaneNormal;
uniform highp float _SquashAmount;
#line 323
uniform highp vec3 _TreeBillboardCameraRight;
uniform highp vec4 _TreeBillboardCameraUp;
uniform highp vec4 _TreeBillboardCameraFront;
uniform highp vec4 _TreeBillboardCameraPos;
#line 327
uniform highp vec4 _TreeBillboardDistances;
#line 345
#line 393
#line 411
#line 425
#line 437
uniform highp vec4 _Wind;
#line 512
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
#line 524
#line 524
lowp vec4 frag( in v2f i ) {
    lowp vec4 texcol = texture( _MainTex, i.uv);
    lowp float alpha = (texcol.w * i.color.w);
    #line 528
    xll_clip_f((alpha - _Cutoff));
    return vec4( 0.0);
}
in lowp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.color = vec4(xlv_COLOR);
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