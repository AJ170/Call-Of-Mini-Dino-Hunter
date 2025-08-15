»•Shader "Hidden/Shadow-ScreenBlurRotated" {
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
uniform highp mat4 glstate_matrix_texture0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.x = tmpvar_1.x;
  tmpvar_4.y = tmpvar_1.y;
  tmpvar_3 = (glstate_matrix_texture0 * tmpvar_4).xy;
  tmpvar_2 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
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
uniform sampler2D unity_RandomRotation16;
uniform sampler2D _MainTex;
uniform highp vec4 _ScreenParams;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 xlat_varsample_7_2;
  mediump vec4 xlat_varsample_6_3;
  mediump vec4 xlat_varsample_5_4;
  mediump vec4 xlat_varsample_4_5;
  mediump vec4 xlat_varsample_3_6;
  mediump vec4 xlat_varsample_2_7;
  mediump vec4 xlat_varsample_1_8;
  mediump vec4 xlat_varsample_9;
  mediump float diffTolerance_10;
  mediump float radius_11;
  mediump vec4 mask_12;
  mediump vec4 rotation_13;
  highp vec4 coord_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 0.0);
  tmpvar_15.xy = xlv_TEXCOORD0;
  coord_14 = tmpvar_15;
  highp vec2 P_16;
  P_16 = ((coord_14.xy * _ScreenParams.xy) / 16.0);
  lowp vec4 tmpvar_17;
  tmpvar_17 = ((2.0 * texture2D (unity_RandomRotation16, P_16)) - 1.0);
  rotation_13 = tmpvar_17;
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex, coord_14.xy);
  mask_12 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = (mask_12.z + (mask_12.w / 255.0));
  highp float tmpvar_20;
  tmpvar_20 = clamp ((unity_ShadowBlurParams.y / (1.0 - tmpvar_19)), 0.0, 1.0);
  radius_11 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = unity_ShadowBlurParams.x;
  diffTolerance_10 = tmpvar_21;
  mask_12.xy = (mask_12.xy * diffTolerance_10);
  highp vec4 rotation_22;
  rotation_22 = rotation_13;
  highp vec2 offset_23;
  offset_23.x = dot (_BlurOffsets0.xy, rotation_22.xy);
  offset_23.y = dot (_BlurOffsets0.xy, rotation_22.zw);
  lowp vec4 tmpvar_24;
  highp vec2 P_25;
  P_25 = (coord_14.xy + (radius_11 * offset_23));
  tmpvar_24 = texture2D (_MainTex, P_25);
  xlat_varsample_9 = tmpvar_24;
  mask_12.xy = (mask_12.xy + (clamp ((diffTolerance_10 - abs((tmpvar_19 - (xlat_varsample_9.z + (xlat_varsample_9.w / 255.0))))), 0.0, 1.0) * xlat_varsample_9.xy));
  highp vec4 rotation_26;
  rotation_26 = rotation_13;
  highp vec2 offset_27;
  offset_27.x = dot (_BlurOffsets1.xy, rotation_26.xy);
  offset_27.y = dot (_BlurOffsets1.xy, rotation_26.zw);
  lowp vec4 tmpvar_28;
  highp vec2 P_29;
  P_29 = (coord_14.xy + (radius_11 * offset_27));
  tmpvar_28 = texture2D (_MainTex, P_29);
  xlat_varsample_1_8 = tmpvar_28;
  mask_12.xy = (mask_12.xy + (clamp ((diffTolerance_10 - abs((tmpvar_19 - (xlat_varsample_1_8.z + (xlat_varsample_1_8.w / 255.0))))), 0.0, 1.0) * xlat_varsample_1_8.xy));
  highp vec4 rotation_30;
  rotation_30 = rotation_13;
  highp vec2 offset_31;
  offset_31.x = dot (_BlurOffsets2.xy, rotation_30.xy);
  offset_31.y = dot (_BlurOffsets2.xy, rotation_30.zw);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (coord_14.xy + (radius_11 * offset_31));
  tmpvar_32 = texture2D (_MainTex, P_33);
  xlat_varsample_2_7 = tmpvar_32;
  mask_12.xy = (mask_12.xy + (clamp ((diffTolerance_10 - abs((tmpvar_19 - (xlat_varsample_2_7.z + (xlat_varsample_2_7.w / 255.0))))), 0.0, 1.0) * xlat_varsample_2_7.xy));
  highp vec4 rotation_34;
  rotation_34 = rotation_13;
  highp vec2 offset_35;
  offset_35.x = dot (_BlurOffsets3.xy, rotation_34.xy);
  offset_35.y = dot (_BlurOffsets3.xy, rotation_34.zw);
  lowp vec4 tmpvar_36;
  highp vec2 P_37;
  P_37 = (coord_14.xy + (radius_11 * offset_35));
  tmpvar_36 = texture2D (_MainTex, P_37);
  xlat_varsample_3_6 = tmpvar_36;
  mask_12.xy = (mask_12.xy + (clamp ((diffTolerance_10 - abs((tmpvar_19 - (xlat_varsample_3_6.z + (xlat_varsample_3_6.w / 255.0))))), 0.0, 1.0) * xlat_varsample_3_6.xy));
  highp vec4 rotation_38;
  rotation_38 = rotation_13;
  highp vec2 offset_39;
  offset_39.x = dot (_BlurOffsets4.xy, rotation_38.xy);
  offset_39.y = dot (_BlurOffsets4.xy, rotation_38.zw);
  lowp vec4 tmpvar_40;
  highp vec2 P_41;
  P_41 = (coord_14.xy + (radius_11 * offset_39));
  tmpvar_40 = texture2D (_MainTex, P_41);
  xlat_varsample_4_5 = tmpvar_40;
  mask_12.xy = (mask_12.xy + (clamp ((diffTolerance_10 - abs((tmpvar_19 - (xlat_varsample_4_5.z + (xlat_varsample_4_5.w / 255.0))))), 0.0, 1.0) * xlat_varsample_4_5.xy));
  highp vec4 rotation_42;
  rotation_42 = rotation_13;
  highp vec2 offset_43;
  offset_43.x = dot (_BlurOffsets5.xy, rotation_42.xy);
  offset_43.y = dot (_BlurOffsets5.xy, rotation_42.zw);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (coord_14.xy + (radius_11 * offset_43));
  tmpvar_44 = texture2D (_MainTex, P_45);
  xlat_varsample_5_4 = tmpvar_44;
  mask_12.xy = (mask_12.xy + (clamp ((diffTolerance_10 - abs((tmpvar_19 - (xlat_varsample_5_4.z + (xlat_varsample_5_4.w / 255.0))))), 0.0, 1.0) * xlat_varsample_5_4.xy));
  highp vec4 rotation_46;
  rotation_46 = rotation_13;
  highp vec2 offset_47;
  offset_47.x = dot (_BlurOffsets6.xy, rotation_46.xy);
  offset_47.y = dot (_BlurOffsets6.xy, rotation_46.zw);
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (coord_14.xy + (radius_11 * offset_47));
  tmpvar_48 = texture2D (_MainTex, P_49);
  xlat_varsample_6_3 = tmpvar_48;
  mask_12.xy = (mask_12.xy + (clamp ((diffTolerance_10 - abs((tmpvar_19 - (xlat_varsample_6_3.z + (xlat_varsample_6_3.w / 255.0))))), 0.0, 1.0) * xlat_varsample_6_3.xy));
  highp vec4 rotation_50;
  rotation_50 = rotation_13;
  highp vec2 offset_51;
  offset_51.x = dot (_BlurOffsets7.xy, rotation_50.xy);
  offset_51.y = dot (_BlurOffsets7.xy, rotation_50.zw);
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (coord_14.xy + (radius_11 * offset_51));
  tmpvar_52 = texture2D (_MainTex, P_53);
  xlat_varsample_7_2 = tmpvar_52;
  mask_12.xy = (mask_12.xy + (clamp ((diffTolerance_10 - abs((tmpvar_19 - (xlat_varsample_7_2.z + (xlat_varsample_7_2.w / 255.0))))), 0.0, 1.0) * xlat_varsample_7_2.xy));
  mediump vec4 tmpvar_54;
  tmpvar_54 = vec4((mask_12.x / mask_12.y));
  tmpvar_1 = tmpvar_54;
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
uniform sampler2D unity_RandomRotation16;
uniform highp vec4 _BlurOffsets0;
uniform highp vec4 _BlurOffsets1;
#line 319
uniform highp vec4 _BlurOffsets2;
uniform highp vec4 _BlurOffsets3;
uniform highp vec4 _BlurOffsets4;
uniform highp vec4 _BlurOffsets5;
#line 323
uniform highp vec4 _BlurOffsets6;
uniform highp vec4 _BlurOffsets7;
#line 332
uniform highp vec4 unity_ShadowBlurParams;
#line 193
highp vec2 MultiplyUV( in highp mat4 mat, in highp vec2 inUV ) {
    highp vec4 temp = vec4( inUV.x, inUV.y, 0.0, 0.0);
    temp = (mat * temp);
    #line 197
    return temp.xy;
}
#line 199
v2f_img vert_img( in appdata_img v ) {
    #line 201
    v2f_img o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = MultiplyUV( glstate_matrix_texture0, v.texcoord);
    return o;
}
out mediump vec2 xlv_TEXCOORD0;
void main() {
    v2f_img xl_retval;
    appdata_img xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xl_retval = vert_img( xlt_v);
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
uniform sampler2D unity_RandomRotation16;
uniform highp vec4 _BlurOffsets0;
uniform highp vec4 _BlurOffsets1;
#line 319
uniform highp vec4 _BlurOffsets2;
uniform highp vec4 _BlurOffsets3;
uniform highp vec4 _BlurOffsets4;
uniform highp vec4 _BlurOffsets5;
#line 323
uniform highp vec4 _BlurOffsets6;
uniform highp vec4 _BlurOffsets7;
#line 332
uniform highp vec4 unity_ShadowBlurParams;
#line 325
highp vec2 GetRotatedTexCoord( in highp vec2 offsets, in highp vec4 rotation ) {
    #line 327
    highp vec2 offset;
    offset.x = dot( offsets.xy, rotation.xy);
    offset.y = dot( offsets.xy, rotation.zw);
    return offset;
}
#line 333
lowp vec4 frag( in v2f_img i ) {
    highp vec4 coord = vec4( i.uv, 0.0, 0.0);
    #line 336
    const highp float randomRotationTextureSize = 16.0;
    mediump vec4 rotation = ((2.0 * texture( unity_RandomRotation16, ((coord.xy * _ScreenParams.xy) / 16.0))) - 1.0);
    mediump vec4 mask = texture( _MainTex, coord.xy);
    mediump float dist = (mask.z + (mask.w / 255.0));
    #line 340
    mediump float radius = xll_saturate_f((unity_ShadowBlurParams.y / (1.0 - dist)));
    mediump float diffTolerance = unity_ShadowBlurParams.x;
    mask.xy *= diffTolerance;
    #line 345
    mediump vec4 xlat_varsample = texture( _MainTex, (vec2( coord) + (radius * GetRotatedTexCoord( _BlurOffsets0.xy, rotation))));
    mediump float sampleDist = (xlat_varsample.z + (xlat_varsample.w / 255.0));
    mediump float diff = (dist - sampleDist);
    diff = xll_saturate_f((diffTolerance - abs(diff)));
    #line 349
    mask.xy += (diff * xlat_varsample.xy);
    #line 354
    mediump vec4 xlat_varsample_1 = texture( _MainTex, (vec2( coord) + (radius * GetRotatedTexCoord( _BlurOffsets1.xy, rotation))));
    mediump float sampleDist_1 = (xlat_varsample_1.z + (xlat_varsample_1.w / 255.0));
    mediump float diff_1 = (dist - sampleDist_1);
    diff_1 = xll_saturate_f((diffTolerance - abs(diff_1)));
    #line 358
    mask.xy += (diff_1 * xlat_varsample_1.xy);
    #line 363
    mediump vec4 xlat_varsample_2 = texture( _MainTex, (vec2( coord) + (radius * GetRotatedTexCoord( _BlurOffsets2.xy, rotation))));
    mediump float sampleDist_2 = (xlat_varsample_2.z + (xlat_varsample_2.w / 255.0));
    mediump float diff_2 = (dist - sampleDist_2);
    diff_2 = xll_saturate_f((diffTolerance - abs(diff_2)));
    #line 367
    mask.xy += (diff_2 * xlat_varsample_2.xy);
    #line 372
    mediump vec4 xlat_varsample_3 = texture( _MainTex, (vec2( coord) + (radius * GetRotatedTexCoord( _BlurOffsets3.xy, rotation))));
    mediump float sampleDist_3 = (xlat_varsample_3.z + (xlat_varsample_3.w / 255.0));
    mediump float diff_3 = (dist - sampleDist_3);
    diff_3 = xll_saturate_f((diffTolerance - abs(diff_3)));
    #line 376
    mask.xy += (diff_3 * xlat_varsample_3.xy);
    #line 381
    mediump vec4 xlat_varsample_4 = texture( _MainTex, (vec2( coord) + (radius * GetRotatedTexCoord( _BlurOffsets4.xy, rotation))));
    mediump float sampleDist_4 = (xlat_varsample_4.z + (xlat_varsample_4.w / 255.0));
    mediump float diff_4 = (dist - sampleDist_4);
    diff_4 = xll_saturate_f((diffTolerance - abs(diff_4)));
    #line 385
    mask.xy += (diff_4 * xlat_varsample_4.xy);
    #line 390
    mediump vec4 xlat_varsample_5 = texture( _MainTex, (vec2( coord) + (radius * GetRotatedTexCoord( _BlurOffsets5.xy, rotation))));
    mediump float sampleDist_5 = (xlat_varsample_5.z + (xlat_varsample_5.w / 255.0));
    mediump float diff_5 = (dist - sampleDist_5);
    diff_5 = xll_saturate_f((diffTolerance - abs(diff_5)));
    #line 394
    mask.xy += (diff_5 * xlat_varsample_5.xy);
    #line 399
    mediump vec4 xlat_varsample_6 = texture( _MainTex, (vec2( coord) + (radius * GetRotatedTexCoord( _BlurOffsets6.xy, rotation))));
    mediump float sampleDist_6 = (xlat_varsample_6.z + (xlat_varsample_6.w / 255.0));
    mediump float diff_6 = (dist - sampleDist_6);
    diff_6 = xll_saturate_f((diffTolerance - abs(diff_6)));
    #line 403
    mask.xy += (diff_6 * xlat_varsample_6.xy);
    #line 408
    mediump vec4 xlat_varsample_7 = texture( _MainTex, (vec2( coord) + (radius * GetRotatedTexCoord( _BlurOffsets7.xy, rotation))));
    mediump float sampleDist_7 = (xlat_varsample_7.z + (xlat_varsample_7.w / 255.0));
    mediump float diff_7 = (dist - sampleDist_7);
    diff_7 = xll_saturate_f((diffTolerance - abs(diff_7)));
    #line 412
    mask.xy += (diff_7 * xlat_varsample_7.xy);
    mediump float shadow = (mask.x / mask.y);
    #line 416
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