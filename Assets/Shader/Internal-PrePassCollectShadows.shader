§ôShader "Hidden/Internal-PrePassCollectShadows" {
Properties {
 _ShadowMapTexture ("", any) = "" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp mat4 _CameraToWorld;
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp float depth_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.x * depth_3) + _ZBufferParams.y)));
  depth_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = (xlv_TEXCOORD1 * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = (_CameraToWorld * tmpvar_6);
  mediump float shadow_8;
  highp vec4 zFar_9;
  highp vec4 zNear_10;
  bvec4 tmpvar_11;
  tmpvar_11 = greaterThanEqual (tmpvar_6.zzzz, _LightSplitsNear);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(tmpvar_11);
  zNear_10 = tmpvar_12;
  bvec4 tmpvar_13;
  tmpvar_13 = lessThan (tmpvar_6.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_14;
  tmpvar_14 = vec4(tmpvar_13);
  zFar_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (zNear_10 * zFar_9);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = (((((unity_World2Shadow[0] * tmpvar_7).xyz * tmpvar_15.x) + ((unity_World2Shadow[1] * tmpvar_7).xyz * tmpvar_15.y)) + ((unity_World2Shadow[2] * tmpvar_7).xyz * tmpvar_15.z)) + ((unity_World2Shadow[3] * tmpvar_7).xyz * tmpvar_15.w));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_ShadowMapTexture, tmpvar_16.xy);
  highp float tmpvar_18;
  if ((tmpvar_17.x < tmpvar_16.z)) {
    tmpvar_18 = _LightShadowData.x;
  } else {
    tmpvar_18 = 1.0;
  };
  shadow_8 = tmpvar_18;
  res_2.x = shadow_8;
  res_2.y = 1.0;
  highp vec2 enc_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = fract((vec2(1.0, 255.0) * (1.0 - tmpvar_5)));
  enc_19.y = tmpvar_20.y;
  enc_19.x = (tmpvar_20.x - (tmpvar_20.y * 0.00392157));
  res_2.zw = enc_19;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp mat4 _CameraToWorld;
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightSplitsFar;
uniform highp vec4 _LightSplitsNear;
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp float depth_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.x * depth_3) + _ZBufferParams.y)));
  depth_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = (xlv_TEXCOORD1 * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = (_CameraToWorld * tmpvar_6);
  mediump float shadow_8;
  highp vec4 zFar_9;
  highp vec4 zNear_10;
  bvec4 tmpvar_11;
  tmpvar_11 = greaterThanEqual (tmpvar_6.zzzz, _LightSplitsNear);
  lowp vec4 tmpvar_12;
  tmpvar_12 = vec4(tmpvar_11);
  zNear_10 = tmpvar_12;
  bvec4 tmpvar_13;
  tmpvar_13 = lessThan (tmpvar_6.zzzz, _LightSplitsFar);
  lowp vec4 tmpvar_14;
  tmpvar_14 = vec4(tmpvar_13);
  zFar_9 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = (zNear_10 * zFar_9);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = (((((unity_World2Shadow[0] * tmpvar_7).xyz * tmpvar_15.x) + ((unity_World2Shadow[1] * tmpvar_7).xyz * tmpvar_15.y)) + ((unity_World2Shadow[2] * tmpvar_7).xyz * tmpvar_15.z)) + ((unity_World2Shadow[3] * tmpvar_7).xyz * tmpvar_15.w));
  lowp float tmpvar_17;
  tmpvar_17 = shadow2DEXT (_ShadowMapTexture, tmpvar_16.xyz);
  shadow_8 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = mix (_LightShadowData.x, 1.0, shadow_8);
  shadow_8 = tmpvar_18;
  res_2.x = shadow_8;
  res_2.y = 1.0;
  highp vec2 enc_19;
  highp vec2 tmpvar_20;
  tmpvar_20 = fract((vec2(1.0, 255.0) * (1.0 - tmpvar_5)));
  enc_19.y = tmpvar_20.y;
  enc_19.x = (tmpvar_20.x - (tmpvar_20.y * 0.00392157));
  res_2.zw = enc_19;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
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
#line 322
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
    highp vec2 texcoord;
    highp vec3 normal;
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
#line 329
#line 337
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 unity_LightmapFade;
uniform highp mat4 _CameraToWorld;
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 341
#line 345
#line 329
v2f vert( in appdata v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 333
    o.uv = v.texcoord;
    o.ray = v.normal;
    return o;
}
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
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
#line 322
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
    highp vec2 texcoord;
    highp vec3 normal;
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
#line 329
#line 337
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 unity_LightmapFade;
uniform highp mat4 _CameraToWorld;
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 341
#line 345
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
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 345
mediump float unitySampleShadow( in highp vec4 wpos, in highp float z ) {
    highp vec3 sc0 = (unity_World2Shadow[0] * wpos).xyz;
    highp vec3 sc1 = (unity_World2Shadow[1] * wpos).xyz;
    #line 349
    highp vec3 sc2 = (unity_World2Shadow[2] * wpos).xyz;
    highp vec3 sc3 = (unity_World2Shadow[3] * wpos).xyz;
    highp vec4 zNear = vec4(greaterThanEqual( vec4( z ), _LightSplitsNear));
    highp vec4 zFar = vec4(lessThan( vec4( z ), _LightSplitsFar));
    #line 353
    highp vec4 weights = (zNear * zFar);
    highp vec4 coord = vec4( ((((sc0 * weights.x) + (sc1 * weights.y)) + (sc2 * weights.z)) + (sc3 * weights.w)), 1.0);
    mediump float shadow = xll_shadow2D( _ShadowMapTexture, coord.xyz);
    shadow = mix( _LightShadowData.x, 1.0, shadow);
    #line 357
    return shadow;
}
#line 359
lowp vec4 frag( in v2f i ) {
    #line 361
    highp float depth = texture( _CameraDepthTexture, i.uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec4 wpos = (_CameraToWorld * vpos);
    #line 365
    mediump float shadow = unitySampleShadow( wpos, vpos.z);
    highp vec4 res;
    res.x = shadow;
    res.y = 1.0;
    #line 369
    res.zw = EncodeFloatRG( (1.0 - depth));
    return res;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec2(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp mat4 _CameraToWorld;
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp float depth_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.x * depth_3) + _ZBufferParams.y)));
  depth_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = (xlv_TEXCOORD1 * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = (_CameraToWorld * tmpvar_6);
  mediump float shadow_8;
  highp vec4 weights_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_7.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_10, tmpvar_10);
  tmpvar_14.y = dot (tmpvar_11, tmpvar_11);
  tmpvar_14.z = dot (tmpvar_12, tmpvar_12);
  tmpvar_14.w = dot (tmpvar_13, tmpvar_13);
  bvec4 tmpvar_15;
  tmpvar_15 = lessThan (tmpvar_14, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_16;
  tmpvar_16 = vec4(tmpvar_15);
  weights_9 = tmpvar_16;
  weights_9.yzw = clamp ((weights_9.yzw - weights_9.xyz), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((((unity_World2Shadow[0] * tmpvar_7).xyz * weights_9.x) + ((unity_World2Shadow[1] * tmpvar_7).xyz * weights_9.y)) + ((unity_World2Shadow[2] * tmpvar_7).xyz * weights_9.z)) + ((unity_World2Shadow[3] * tmpvar_7).xyz * weights_9.w));
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_ShadowMapTexture, tmpvar_17.xy);
  highp float tmpvar_19;
  if ((tmpvar_18.x < tmpvar_17.z)) {
    tmpvar_19 = _LightShadowData.x;
  } else {
    tmpvar_19 = 1.0;
  };
  shadow_8 = tmpvar_19;
  res_2.x = shadow_8;
  res_2.y = 1.0;
  highp vec2 enc_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = fract((vec2(1.0, 255.0) * (1.0 - tmpvar_5)));
  enc_20.y = tmpvar_21.y;
  enc_20.x = (tmpvar_21.x - (tmpvar_21.y * 0.00392157));
  res_2.zw = enc_20;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesNormal;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp mat4 _CameraToWorld;
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 _ZBufferParams;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 res_2;
  highp float depth_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depth_3 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (1.0/(((_ZBufferParams.x * depth_3) + _ZBufferParams.y)));
  depth_3 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = (xlv_TEXCOORD1 * tmpvar_5);
  highp vec4 tmpvar_7;
  tmpvar_7 = (_CameraToWorld * tmpvar_6);
  mediump float shadow_8;
  highp vec4 weights_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_7.xyz - unity_ShadowSplitSpheres[0].xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_7.xyz - unity_ShadowSplitSpheres[1].xyz);
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_7.xyz - unity_ShadowSplitSpheres[2].xyz);
  highp vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_7.xyz - unity_ShadowSplitSpheres[3].xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.x = dot (tmpvar_10, tmpvar_10);
  tmpvar_14.y = dot (tmpvar_11, tmpvar_11);
  tmpvar_14.z = dot (tmpvar_12, tmpvar_12);
  tmpvar_14.w = dot (tmpvar_13, tmpvar_13);
  bvec4 tmpvar_15;
  tmpvar_15 = lessThan (tmpvar_14, unity_ShadowSplitSqRadii);
  lowp vec4 tmpvar_16;
  tmpvar_16 = vec4(tmpvar_15);
  weights_9 = tmpvar_16;
  weights_9.yzw = clamp ((weights_9.yzw - weights_9.xyz), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (((((unity_World2Shadow[0] * tmpvar_7).xyz * weights_9.x) + ((unity_World2Shadow[1] * tmpvar_7).xyz * weights_9.y)) + ((unity_World2Shadow[2] * tmpvar_7).xyz * weights_9.z)) + ((unity_World2Shadow[3] * tmpvar_7).xyz * weights_9.w));
  lowp float tmpvar_18;
  tmpvar_18 = shadow2DEXT (_ShadowMapTexture, tmpvar_17.xyz);
  shadow_8 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = mix (_LightShadowData.x, 1.0, shadow_8);
  shadow_8 = tmpvar_19;
  res_2.x = shadow_8;
  res_2.y = 1.0;
  highp vec2 enc_20;
  highp vec2 tmpvar_21;
  tmpvar_21 = fract((vec2(1.0, 255.0) * (1.0 - tmpvar_5)));
  enc_20.y = tmpvar_21.y;
  enc_20.x = (tmpvar_21.x - (tmpvar_21.y * 0.00392157));
  res_2.zw = enc_20;
  tmpvar_1 = res_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
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
#line 322
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
    highp vec2 texcoord;
    highp vec3 normal;
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
#line 329
#line 337
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 unity_LightmapFade;
uniform highp mat4 _CameraToWorld;
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 341
#line 345
#line 329
v2f vert( in appdata v ) {
    v2f o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 333
    o.uv = v.texcoord;
    o.ray = v.normal;
    return o;
}
out highp vec2 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.texcoord = vec2(gl_MultiTexCoord0);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
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
#line 322
struct v2f {
    highp vec4 pos;
    highp vec2 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
    highp vec2 texcoord;
    highp vec3 normal;
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
#line 329
#line 337
uniform sampler2D _CameraDepthTexture;
uniform highp vec4 unity_LightmapFade;
uniform highp mat4 _CameraToWorld;
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 341
#line 345
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
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 345
mediump float unitySampleShadow( in highp vec4 wpos, in highp float z ) {
    highp vec3 sc0 = (unity_World2Shadow[0] * wpos).xyz;
    highp vec3 sc1 = (unity_World2Shadow[1] * wpos).xyz;
    #line 349
    highp vec3 sc2 = (unity_World2Shadow[2] * wpos).xyz;
    highp vec3 sc3 = (unity_World2Shadow[3] * wpos).xyz;
    highp vec3 fromCenter0 = (wpos.xyz - unity_ShadowSplitSpheres[0].xyz);
    highp vec3 fromCenter1 = (wpos.xyz - unity_ShadowSplitSpheres[1].xyz);
    #line 353
    highp vec3 fromCenter2 = (wpos.xyz - unity_ShadowSplitSpheres[2].xyz);
    highp vec3 fromCenter3 = (wpos.xyz - unity_ShadowSplitSpheres[3].xyz);
    highp vec4 distances2 = vec4( dot( fromCenter0, fromCenter0), dot( fromCenter1, fromCenter1), dot( fromCenter2, fromCenter2), dot( fromCenter3, fromCenter3));
    highp vec4 weights = vec4(lessThan( distances2, unity_ShadowSplitSqRadii));
    #line 357
    weights.yzw = xll_saturate_vf3((weights.yzw - weights.xyz));
    highp vec4 coord = vec4( ((((sc0 * weights.x) + (sc1 * weights.y)) + (sc2 * weights.z)) + (sc3 * weights.w)), 1.0);
    mediump float shadow = xll_shadow2D( _ShadowMapTexture, coord.xyz);
    shadow = mix( _LightShadowData.x, 1.0, shadow);
    #line 361
    return shadow;
}
#line 363
lowp vec4 frag( in v2f i ) {
    #line 365
    highp float depth = texture( _CameraDepthTexture, i.uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec4 wpos = (_CameraToWorld * vpos);
    #line 369
    mediump float shadow = unitySampleShadow( wpos, vpos.z);
    highp vec4 res;
    res.x = shadow;
    res.y = 1.0;
    #line 373
    res.zw = EncodeFloatRG( (1.0 - depth));
    return res;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec2(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NONATIVE" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SHADOWS_SPLIT_SPHERES" "SHADOWS_NATIVE" }
"!!GLES3"
}
}
 }
}
Fallback Off
}