›{Shader "Hidden/Shadow-ScreenBlur" {
Properties {
 _MainTex ("Base", 2D) = "white" {}
}
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

varying mediump vec2 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

varying mediump vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_ShadowBlurParams;
uniform highp vec4 _BlurOffsets7;
uniform highp vec4 _BlurOffsets6;
uniform highp vec4 _BlurOffsets5;
uniform highp vec4 _BlurOffsets4;
uniform highp vec4 _BlurOffsets3;
uniform highp vec4 _BlurOffsets2;
uniform highp vec4 _BlurOffsets1;
uniform highp vec4 _BlurOffsets0;
uniform sampler2D _MainTex;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 xlat_varsample_7_2;
  highp vec4 xlat_varsample_6_3;
  highp vec4 xlat_varsample_5_4;
  highp vec4 xlat_varsample_4_5;
  highp vec4 xlat_varsample_3_6;
  highp vec4 xlat_varsample_2_7;
  highp vec4 xlat_varsample_1_8;
  highp vec4 xlat_varsample_9;
  highp vec4 mask_10;
  highp vec4 coord_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.zw = vec2(0.0, 0.0);
  tmpvar_12.xy = xlv_TEXCOORD0;
  coord_11 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex, coord_11.xy);
  mask_10 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (mask_10.z + (mask_10.w / 255.0));
  highp float tmpvar_15;
  tmpvar_15 = clamp ((unity_ShadowBlurParams.y / (1.0 - tmpvar_14)), 0.0, 1.0);
  mask_10.xy = (mask_10.xy * unity_ShadowBlurParams.x);
  lowp vec4 tmpvar_16;
  highp vec2 P_17;
  P_17 = (coord_11 + (tmpvar_15 * _BlurOffsets0)).xy;
  tmpvar_16 = texture2D (_MainTex, P_17);
  xlat_varsample_9 = tmpvar_16;
  mask_10.xy = (mask_10.xy + (clamp ((unity_ShadowBlurParams.x - abs((tmpvar_14 - (xlat_varsample_9.z + (xlat_varsample_9.w / 255.0))))), 0.0, 1.0) * xlat_varsample_9.xy));
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (coord_11 + (tmpvar_15 * _BlurOffsets1)).xy;
  tmpvar_18 = texture2D (_MainTex, P_19);
  xlat_varsample_1_8 = tmpvar_18;
  mask_10.xy = (mask_10.xy + (clamp ((unity_ShadowBlurParams.x - abs((tmpvar_14 - (xlat_varsample_1_8.z + (xlat_varsample_1_8.w / 255.0))))), 0.0, 1.0) * xlat_varsample_1_8.xy));
  lowp vec4 tmpvar_20;
  highp vec2 P_21;
  P_21 = (coord_11 + (tmpvar_15 * _BlurOffsets2)).xy;
  tmpvar_20 = texture2D (_MainTex, P_21);
  xlat_varsample_2_7 = tmpvar_20;
  mask_10.xy = (mask_10.xy + (clamp ((unity_ShadowBlurParams.x - abs((tmpvar_14 - (xlat_varsample_2_7.z + (xlat_varsample_2_7.w / 255.0))))), 0.0, 1.0) * xlat_varsample_2_7.xy));
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (coord_11 + (tmpvar_15 * _BlurOffsets3)).xy;
  tmpvar_22 = texture2D (_MainTex, P_23);
  xlat_varsample_3_6 = tmpvar_22;
  mask_10.xy = (mask_10.xy + (clamp ((unity_ShadowBlurParams.x - abs((tmpvar_14 - (xlat_varsample_3_6.z + (xlat_varsample_3_6.w / 255.0))))), 0.0, 1.0) * xlat_varsample_3_6.xy));
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (coord_11 + (tmpvar_15 * _BlurOffsets4)).xy;
  tmpvar_24 = texture2D (_MainTex, P_25);
  xlat_varsample_4_5 = tmpvar_24;
  mask_10.xy = (mask_10.xy + (clamp ((unity_ShadowBlurParams.x - abs((tmpvar_14 - (xlat_varsample_4_5.z + (xlat_varsample_4_5.w / 255.0))))), 0.0, 1.0) * xlat_varsample_4_5.xy));
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (coord_11 + (tmpvar_15 * _BlurOffsets5)).xy;
  tmpvar_26 = texture2D (_MainTex, P_27);
  xlat_varsample_5_4 = tmpvar_26;
  mask_10.xy = (mask_10.xy + (clamp ((unity_ShadowBlurParams.x - abs((tmpvar_14 - (xlat_varsample_5_4.z + (xlat_varsample_5_4.w / 255.0))))), 0.0, 1.0) * xlat_varsample_5_4.xy));
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (coord_11 + (tmpvar_15 * _BlurOffsets6)).xy;
  tmpvar_28 = texture2D (_MainTex, P_29);
  xlat_varsample_6_3 = tmpvar_28;
  mask_10.xy = (mask_10.xy + (clamp ((unity_ShadowBlurParams.x - abs((tmpvar_14 - (xlat_varsample_6_3.z + (xlat_varsample_6_3.w / 255.0))))), 0.0, 1.0) * xlat_varsample_6_3.xy));
  lowp vec4 tmpvar_30;
  highp vec2 P_31;
  P_31 = (coord_11 + (tmpvar_15 * _BlurOffsets7)).xy;
  tmpvar_30 = texture2D (_MainTex, P_31);
  xlat_varsample_7_2 = tmpvar_30;
  mask_10.xy = (mask_10.xy + (clamp ((unity_ShadowBlurParams.x - abs((tmpvar_14 - (xlat_varsample_7_2.z + (xlat_varsample_7_2.w / 255.0))))), 0.0, 1.0) * xlat_varsample_7_2.xy));
  highp vec4 tmpvar_32;
  tmpvar_32 = vec4((mask_10.x / mask_10.y));
  tmpvar_1 = tmpvar_32;
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
uniform sampler2D _MainTex;
#line 323
uniform highp vec4 _BlurOffsets0;
uniform highp vec4 _BlurOffsets1;
uniform highp vec4 _BlurOffsets2;
uniform highp vec4 _BlurOffsets3;
#line 327
uniform highp vec4 _BlurOffsets4;
uniform highp vec4 _BlurOffsets5;
uniform highp vec4 _BlurOffsets6;
uniform highp vec4 _BlurOffsets7;
#line 331
uniform highp vec4 unity_ShadowBlurParams;
#line 315
v2f_img vert( in appdata_img v ) {
    v2f_img o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 319
    o.uv = v.texcoord.xy;
    return o;
}
out mediump vec2 xlv_TEXCOORD0;
void main() {
    v2f_img xl_retval;
    appdata_img xlt_v;
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
uniform sampler2D _MainTex;
#line 323
uniform highp vec4 _BlurOffsets0;
uniform highp vec4 _BlurOffsets1;
uniform highp vec4 _BlurOffsets2;
uniform highp vec4 _BlurOffsets3;
#line 327
uniform highp vec4 _BlurOffsets4;
uniform highp vec4 _BlurOffsets5;
uniform highp vec4 _BlurOffsets6;
uniform highp vec4 _BlurOffsets7;
#line 331
uniform highp vec4 unity_ShadowBlurParams;
#line 332
lowp vec4 frag( in v2f_img i ) {
    highp vec4 coord = vec4( i.uv, 0.0, 0.0);
    #line 335
    highp vec4 mask = texture( _MainTex, coord.xy);
    highp float dist = (mask.z + (mask.w / 255.0));
    highp float radius = xll_saturate_f((unity_ShadowBlurParams.y / (1.0 - dist)));
    highp float diffTolerance = unity_ShadowBlurParams.x;
    #line 339
    mask.xy *= diffTolerance;
    highp vec4 xlat_varsample = texture( _MainTex, (coord + (radius * _BlurOffsets0)).xy);
    #line 343
    highp float sampleDist = (xlat_varsample.z + (xlat_varsample.w / 255.0));
    highp float diff = (dist - sampleDist);
    diff = xll_saturate_f((diffTolerance - abs(diff)));
    mask.xy += (diff * xlat_varsample.xy);
    #line 351
    highp vec4 xlat_varsample_1 = texture( _MainTex, (coord + (radius * _BlurOffsets1)).xy);
    highp float sampleDist_1 = (xlat_varsample_1.z + (xlat_varsample_1.w / 255.0));
    highp float diff_1 = (dist - sampleDist_1);
    diff_1 = xll_saturate_f((diffTolerance - abs(diff_1)));
    #line 355
    mask.xy += (diff_1 * xlat_varsample_1.xy);
    #line 360
    highp vec4 xlat_varsample_2 = texture( _MainTex, (coord + (radius * _BlurOffsets2)).xy);
    highp float sampleDist_2 = (xlat_varsample_2.z + (xlat_varsample_2.w / 255.0));
    highp float diff_2 = (dist - sampleDist_2);
    diff_2 = xll_saturate_f((diffTolerance - abs(diff_2)));
    #line 364
    mask.xy += (diff_2 * xlat_varsample_2.xy);
    #line 369
    highp vec4 xlat_varsample_3 = texture( _MainTex, (coord + (radius * _BlurOffsets3)).xy);
    highp float sampleDist_3 = (xlat_varsample_3.z + (xlat_varsample_3.w / 255.0));
    highp float diff_3 = (dist - sampleDist_3);
    diff_3 = xll_saturate_f((diffTolerance - abs(diff_3)));
    #line 373
    mask.xy += (diff_3 * xlat_varsample_3.xy);
    #line 378
    highp vec4 xlat_varsample_4 = texture( _MainTex, (coord + (radius * _BlurOffsets4)).xy);
    highp float sampleDist_4 = (xlat_varsample_4.z + (xlat_varsample_4.w / 255.0));
    highp float diff_4 = (dist - sampleDist_4);
    diff_4 = xll_saturate_f((diffTolerance - abs(diff_4)));
    #line 382
    mask.xy += (diff_4 * xlat_varsample_4.xy);
    #line 387
    highp vec4 xlat_varsample_5 = texture( _MainTex, (coord + (radius * _BlurOffsets5)).xy);
    highp float sampleDist_5 = (xlat_varsample_5.z + (xlat_varsample_5.w / 255.0));
    highp float diff_5 = (dist - sampleDist_5);
    diff_5 = xll_saturate_f((diffTolerance - abs(diff_5)));
    #line 391
    mask.xy += (diff_5 * xlat_varsample_5.xy);
    #line 396
    highp vec4 xlat_varsample_6 = texture( _MainTex, (coord + (radius * _BlurOffsets6)).xy);
    highp float sampleDist_6 = (xlat_varsample_6.z + (xlat_varsample_6.w / 255.0));
    highp float diff_6 = (dist - sampleDist_6);
    diff_6 = xll_saturate_f((diffTolerance - abs(diff_6)));
    #line 400
    mask.xy += (diff_6 * xlat_varsample_6.xy);
    #line 405
    highp vec4 xlat_varsample_7 = texture( _MainTex, (coord + (radius * _BlurOffsets7)).xy);
    highp float sampleDist_7 = (xlat_varsample_7.z + (xlat_varsample_7.w / 255.0));
    highp float diff_7 = (dist - sampleDist_7);
    diff_7 = xll_saturate_f((diffTolerance - abs(diff_7)));
    #line 409
    mask.xy += (diff_7 * xlat_varsample_7.xy);
    highp float shadow = (mask.x / mask.y);
    #line 413
    return vec4( shadow);
}
in mediump vec2 xlv_TEXCOORD0;
void main() {
    lowp vec4 xl_retval;
    v2f_img xlt_i;
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