нн-Shader "Hidden/Internal-PrePassLighting" {
Properties {
 _LightTexture0 ("", any) = "" {}
 _LightTextureB0 ("", 2D) = "" {}
 _ShadowMapTexture ("", any) = "" {}
}
SubShader { 
 Pass {
  ZWrite Off
  Fog { Mode Off }
  Blend DstColor Zero
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_18;
  tmpvar_18 = -(normalize(tmpvar_17));
  lightDir_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19)).w;
  atten_5 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (spec_3 * clamp (atten_5, 0.0, 1.0));
  spec_3 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (_LightColor.xyz * (tmpvar_21 * atten_5));
  res_2.xyz = tmpvar_25;
  lowp vec3 c_26;
  c_26 = _LightColor.xyz;
  lowp float tmpvar_27;
  tmpvar_27 = dot (c_26, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_24 * tmpvar_27);
  res_2.w = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_2 * tmpvar_29);
  res_2 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = exp2(-(tmpvar_30));
  tmpvar_1 = tmpvar_31;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 385
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 385
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 373
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    #line 377
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    #line 381
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 385
lowp vec4 frag( in v2f i ) {
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec4 nspec_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_8);
  nspec_7 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(((nspec_7.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_8).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (lightDir_5, tmpvar_10));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (0.0, dot (h_4, tmpvar_10)), (nspec_7.w * 128.0));
  spec_3 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (spec_3 * clamp (1.0, 0.0, 1.0));
  spec_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_LightColor.xyz * tmpvar_17);
  res_2.xyz = tmpvar_21;
  lowp vec3 c_22;
  c_22 = _LightColor.xyz;
  lowp float tmpvar_23;
  tmpvar_23 = dot (c_22, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_20 * tmpvar_23);
  res_2.w = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 - ((mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_26;
  tmpvar_26 = (res_2 * tmpvar_25);
  res_2 = tmpvar_26;
  mediump vec4 tmpvar_27;
  tmpvar_27 = exp2(-(tmpvar_26));
  tmpvar_1 = tmpvar_27;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 373
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 377
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 381
    return res;
}
#line 383
lowp vec4 frag( in v2f i ) {
    #line 385
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_17);
  lightDir_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_15;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_LightMatrix0 * tmpvar_19);
  lowp float tmpvar_21;
  tmpvar_21 = texture2DProj (_LightTexture0, tmpvar_20).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_LightTextureB0, vec2(tmpvar_22));
  highp float tmpvar_24;
  tmpvar_24 = ((atten_5 * float((tmpvar_20.w < 0.0))) * tmpvar_23.w);
  atten_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35 = exp2(-(tmpvar_34));
  tmpvar_1 = tmpvar_35;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    #line 373
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    #line 377
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 381
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 385
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 388
lowp vec4 frag( in v2f i ) {
    #line 390
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_18;
  tmpvar_18 = -(normalize(tmpvar_17));
  lightDir_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19)).w;
  atten_5 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_15;
  lowp vec4 tmpvar_22;
  highp vec3 P_23;
  P_23 = (_LightMatrix0 * tmpvar_21).xyz;
  tmpvar_22 = textureCube (_LightTexture0, P_23);
  highp float tmpvar_24;
  tmpvar_24 = (atten_5 * tmpvar_22.w);
  atten_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35 = exp2(-(tmpvar_34));
  tmpvar_1 = tmpvar_35;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
#line 353
#line 357
#line 386
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
#line 353
#line 357
#line 386
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 373
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 377
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 381
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 386
lowp vec4 frag( in v2f i ) {
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec4 nspec_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_8);
  nspec_7 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(((nspec_7.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_8).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_14;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (_LightMatrix0 * tmpvar_17).xy;
  tmpvar_18 = texture2D (_LightTexture0, P_19);
  highp float tmpvar_20;
  tmpvar_20 = tmpvar_18.w;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (lightDir_5, tmpvar_10));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (0.0, dot (h_4, tmpvar_10)), (nspec_7.w * 128.0));
  spec_3 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (spec_3 * clamp (tmpvar_20, 0.0, 1.0));
  spec_3 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (_LightColor.xyz * (tmpvar_21 * tmpvar_20));
  res_2.xyz = tmpvar_25;
  lowp vec3 c_26;
  c_26 = _LightColor.xyz;
  lowp float tmpvar_27;
  tmpvar_27 = dot (c_26, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_24 * tmpvar_27);
  res_2.w = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - ((mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_2 * tmpvar_29);
  res_2 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31 = exp2(-(tmpvar_30));
  tmpvar_1 = tmpvar_31;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xy).w;
    #line 373
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 377
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 381
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 384
lowp vec4 frag( in v2f i ) {
    #line 386
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_15;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_World2Shadow[0] * tmpvar_27);
  mediump float shadow_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_ShadowMapTexture, tmpvar_28);
  highp float tmpvar_31;
  if ((tmpvar_30.x < (tmpvar_28.z / tmpvar_28.w))) {
    tmpvar_31 = _LightShadowData.x;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_29 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((shadow_29 + tmpvar_26), 0.0, 1.0);
  tmpvar_25 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (spec_3 * clamp (tmpvar_33, 0.0, 1.0));
  spec_3 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (_LightColor.xyz * (tmpvar_34 * tmpvar_33));
  res_2.xyz = tmpvar_38;
  lowp vec3 c_39;
  c_39 = _LightColor.xyz;
  lowp float tmpvar_40;
  tmpvar_40 = dot (c_39, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_37 * tmpvar_40);
  res_2.w = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (res_2 * tmpvar_42);
  res_2 = tmpvar_43;
  mediump vec4 tmpvar_44;
  tmpvar_44 = exp2(-(tmpvar_43));
  tmpvar_1 = tmpvar_44;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 398
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 398
#line 354
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 356
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 349
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = (( (textureProj( _ShadowMapTexture, shadowCoord).x < (shadowCoord.z / shadowCoord.w)) ) ? ( _LightShadowData.x ) : ( 1.0 ));
    #line 352
    return shadow;
}
#line 359
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 361
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 365
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 367
mediump vec4 CalculateLight( in v2f i ) {
    #line 369
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 373
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 377
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 381
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 385
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 389
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 393
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 398
lowp vec4 frag( in v2f i ) {
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_15;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_World2Shadow[0] * tmpvar_26);
  mediump float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DProjEXT (_ShadowMapTexture, tmpvar_27);
  shadow_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (shadow_28 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp ((shadow_28 + clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_25 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (spec_3 * clamp (tmpvar_32, 0.0, 1.0));
  spec_3 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = (_LightColor.xyz * (tmpvar_33 * tmpvar_32));
  res_2.xyz = tmpvar_37;
  lowp vec3 c_38;
  c_38 = _LightColor.xyz;
  lowp float tmpvar_39;
  tmpvar_39 = dot (c_38, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_36 * tmpvar_39);
  res_2.w = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (res_2 * tmpvar_41);
  res_2 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43 = exp2(-(tmpvar_42));
  tmpvar_1 = tmpvar_43;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 399
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2Dproj(mediump sampler2DShadow s, vec4 coord) { return textureProj (s, coord); }
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 399
#line 355
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 357
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 349
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = xll_shadow2Dproj( _ShadowMapTexture, shadowCoord);
    #line 352
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 360
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 362
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 366
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 368
mediump vec4 CalculateLight( in v2f i ) {
    #line 370
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 374
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 378
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 382
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 386
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 390
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 394
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 399
lowp vec4 frag( in v2f i ) {
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec3 normal_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  normal_7 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_16;
  tmpvar_16 = mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_17;
  mediump float tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowMapTexture, tmpvar_9);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19.x + clamp (((tmpvar_16 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_18 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = tmpvar_18;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (lightDir_5, normal_7));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (0.0, dot (h_4, normal_7)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = (spec_3 * clamp (tmpvar_21, 0.0, 1.0));
  spec_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (_LightColor.xyz * (tmpvar_22 * tmpvar_21));
  res_2.xyz = tmpvar_26;
  lowp vec3 c_27;
  c_27 = _LightColor.xyz;
  lowp float tmpvar_28;
  tmpvar_28 = dot (c_27, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_29;
  tmpvar_29 = (tmpvar_25 * tmpvar_28);
  res_2.w = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp ((1.0 - ((tmpvar_16 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_31;
  tmpvar_31 = (res_2 * tmpvar_30);
  res_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32 = exp2(-(tmpvar_31));
  tmpvar_1 = tmpvar_32;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 349
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    #line 352
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 354
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 356
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    return xll_saturate_f((texture( _ShadowMapTexture, uv).x + fade));
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 361
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 365
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 369
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 373
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 377
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 381
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 385
    return res;
}
#line 387
lowp vec4 frag( in v2f i ) {
    #line 389
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec3 normal_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  normal_7 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_16;
  tmpvar_16 = mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_17;
  mediump float tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowMapTexture, tmpvar_9);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19.x + clamp (((tmpvar_16 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_18 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_14;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (_LightMatrix0 * tmpvar_21).xy;
  tmpvar_22 = texture2D (_LightTexture0, P_23);
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_18 * tmpvar_22.w);
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_5, normal_7));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, normal_7)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((tmpvar_16 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35 = exp2(-(tmpvar_34));
  tmpvar_1 = tmpvar_35;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 349
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    #line 352
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 354
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 356
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    return xll_saturate_f((texture( _ShadowMapTexture, uv).x + fade));
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 361
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 365
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 369
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 373
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xy).w;
    #line 377
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 381
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 385
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 388
lowp vec4 frag( in v2f i ) {
    #line 390
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump float tmpvar_23;
  highp vec4 packDist_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureCube (_ShadowMapTexture, tmpvar_18);
  packDist_24 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (packDist_24, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_27;
  if ((tmpvar_26 < tmpvar_22)) {
    tmpvar_27 = _LightShadowData.x;
  } else {
    tmpvar_27 = 1.0;
  };
  tmpvar_23 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (atten_5 * tmpvar_23);
  atten_5 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (spec_3 * clamp (tmpvar_28, 0.0, 1.0));
  spec_3 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (_LightColor.xyz * (tmpvar_29 * tmpvar_28));
  res_2.xyz = tmpvar_33;
  lowp vec3 c_34;
  c_34 = _LightColor.xyz;
  lowp float tmpvar_35;
  tmpvar_35 = dot (c_34, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_36;
  tmpvar_36 = (tmpvar_32 * tmpvar_35);
  res_2.w = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_38;
  tmpvar_38 = (res_2 * tmpvar_37);
  res_2 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39 = exp2(-(tmpvar_38));
  tmpvar_1 = tmpvar_39;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 359
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 361
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 364
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 366
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    #line 370
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 373
mediump vec4 CalculateLight( in v2f i ) {
    #line 375
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 379
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 383
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    #line 387
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 391
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 395
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 399
    return res;
}
#line 401
lowp vec4 frag( in v2f i ) {
    #line 403
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump float tmpvar_23;
  highp vec4 packDist_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureCube (_ShadowMapTexture, tmpvar_18);
  packDist_24 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (packDist_24, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_27;
  if ((tmpvar_26 < tmpvar_22)) {
    tmpvar_27 = _LightShadowData.x;
  } else {
    tmpvar_27 = 1.0;
  };
  tmpvar_23 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_15;
  lowp vec4 tmpvar_29;
  highp vec3 P_30;
  P_30 = (_LightMatrix0 * tmpvar_28).xyz;
  tmpvar_29 = textureCube (_LightTexture0, P_30);
  highp float tmpvar_31;
  tmpvar_31 = ((atten_5 * tmpvar_23) * tmpvar_29.w);
  atten_5 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (spec_3 * clamp (tmpvar_31, 0.0, 1.0));
  spec_3 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = (_LightColor.xyz * (tmpvar_32 * tmpvar_31));
  res_2.xyz = tmpvar_36;
  lowp vec3 c_37;
  c_37 = _LightColor.xyz;
  lowp float tmpvar_38;
  tmpvar_38 = dot (c_37, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_35 * tmpvar_38);
  res_2.w = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (res_2 * tmpvar_40);
  res_2 = tmpvar_41;
  mediump vec4 tmpvar_42;
  tmpvar_42 = exp2(-(tmpvar_41));
  tmpvar_1 = tmpvar_42;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 359
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 361
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 364
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 366
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    #line 370
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 373
mediump vec4 CalculateLight( in v2f i ) {
    #line 375
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 379
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 383
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    #line 387
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    #line 391
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 395
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 399
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 402
lowp vec4 frag( in v2f i ) {
    #line 404
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_15;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_World2Shadow[0] * tmpvar_27);
  mediump vec4 shadows_29;
  highp vec4 shadowVals_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_28.xyz / tmpvar_28.w);
  highp vec2 P_32;
  P_32 = (tmpvar_31.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_33;
  tmpvar_33 = texture2D (_ShadowMapTexture, P_32).x;
  shadowVals_30.x = tmpvar_33;
  highp vec2 P_34;
  P_34 = (tmpvar_31.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, P_34).x;
  shadowVals_30.y = tmpvar_35;
  highp vec2 P_36;
  P_36 = (tmpvar_31.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_37;
  tmpvar_37 = texture2D (_ShadowMapTexture, P_36).x;
  shadowVals_30.z = tmpvar_37;
  highp vec2 P_38;
  P_38 = (tmpvar_31.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, P_38).x;
  shadowVals_30.w = tmpvar_39;
  bvec4 tmpvar_40;
  tmpvar_40 = lessThan (shadowVals_30, tmpvar_31.zzzz);
  highp vec4 tmpvar_41;
  tmpvar_41 = _LightShadowData.xxxx;
  highp float tmpvar_42;
  if (tmpvar_40.x) {
    tmpvar_42 = tmpvar_41.x;
  } else {
    tmpvar_42 = 1.0;
  };
  highp float tmpvar_43;
  if (tmpvar_40.y) {
    tmpvar_43 = tmpvar_41.y;
  } else {
    tmpvar_43 = 1.0;
  };
  highp float tmpvar_44;
  if (tmpvar_40.z) {
    tmpvar_44 = tmpvar_41.z;
  } else {
    tmpvar_44 = 1.0;
  };
  highp float tmpvar_45;
  if (tmpvar_40.w) {
    tmpvar_45 = tmpvar_41.w;
  } else {
    tmpvar_45 = 1.0;
  };
  highp vec4 tmpvar_46;
  tmpvar_46.x = tmpvar_42;
  tmpvar_46.y = tmpvar_43;
  tmpvar_46.z = tmpvar_44;
  tmpvar_46.w = tmpvar_45;
  shadows_29 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = dot (shadows_29, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_48;
  tmpvar_48 = clamp ((tmpvar_47 + tmpvar_26), 0.0, 1.0);
  tmpvar_25 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_51;
  mediump float tmpvar_52;
  tmpvar_52 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = (spec_3 * clamp (tmpvar_49, 0.0, 1.0));
  spec_3 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (_LightColor.xyz * (tmpvar_50 * tmpvar_49));
  res_2.xyz = tmpvar_54;
  lowp vec3 c_55;
  c_55 = _LightColor.xyz;
  lowp float tmpvar_56;
  tmpvar_56 = dot (c_55, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_57;
  tmpvar_57 = (tmpvar_53 * tmpvar_56);
  res_2.w = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_59;
  tmpvar_59 = (res_2 * tmpvar_58);
  res_2 = tmpvar_59;
  mediump vec4 tmpvar_60;
  tmpvar_60 = exp2(-(tmpvar_59));
  tmpvar_1 = tmpvar_60;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 362
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 364
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 350
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 352
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    highp vec4 shadowVals;
    shadowVals.x = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[0].xy)).x;
    shadowVals.y = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[1].xy)).x;
    #line 356
    shadowVals.z = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[2].xy)).x;
    shadowVals.w = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[3].xy)).x;
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, coord.zzzz), vec4( _LightShadowData.xxxx), vec4( 1.0));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 360
    return shadow;
}
#line 367
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 369
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 373
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 375
mediump vec4 CalculateLight( in v2f i ) {
    #line 377
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 381
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 385
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 389
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 393
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 397
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 401
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 406
lowp vec4 frag( in v2f i ) {
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_15;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_World2Shadow[0] * tmpvar_26);
  mediump vec4 shadows_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_27.xyz / tmpvar_27.w);
  highp vec3 coord_30;
  coord_30 = (tmpvar_29 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_31;
  tmpvar_31 = shadow2DEXT (_ShadowMapTexture, coord_30);
  shadows_28.x = tmpvar_31;
  highp vec3 coord_32;
  coord_32 = (tmpvar_29 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_33;
  tmpvar_33 = shadow2DEXT (_ShadowMapTexture, coord_32);
  shadows_28.y = tmpvar_33;
  highp vec3 coord_34;
  coord_34 = (tmpvar_29 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_35;
  tmpvar_35 = shadow2DEXT (_ShadowMapTexture, coord_34);
  shadows_28.z = tmpvar_35;
  highp vec3 coord_36;
  coord_36 = (tmpvar_29 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, coord_36);
  shadows_28.w = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (_LightShadowData.xxxx + (shadows_28 * (1.0 - _LightShadowData.xxxx)));
  shadows_28 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = dot (shadows_28, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_40;
  tmpvar_40 = clamp ((tmpvar_39 + clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_25 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (spec_3 * clamp (tmpvar_41, 0.0, 1.0));
  spec_3 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (_LightColor.xyz * (tmpvar_42 * tmpvar_41));
  res_2.xyz = tmpvar_46;
  lowp vec3 c_47;
  c_47 = _LightColor.xyz;
  lowp float tmpvar_48;
  tmpvar_48 = dot (c_47, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_45 * tmpvar_48);
  res_2.w = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_51;
  tmpvar_51 = (res_2 * tmpvar_50);
  res_2 = tmpvar_51;
  mediump vec4 tmpvar_52;
  tmpvar_52 = exp2(-(tmpvar_51));
  tmpvar_1 = tmpvar_52;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 362
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 364
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 350
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 352
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    mediump vec4 shadows;
    shadows.x = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[0])).xyz);
    shadows.y = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[1])).xyz);
    #line 356
    shadows.z = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[2])).xyz);
    shadows.w = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[3])).xyz);
    shadows = (_LightShadowData.xxxx + (shadows * (1.0 - _LightShadowData.xxxx)));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 360
    return shadow;
}
#line 367
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 369
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 373
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 375
mediump vec4 CalculateLight( in v2f i ) {
    #line 377
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 381
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 385
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 389
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 393
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 397
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 401
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 406
lowp vec4 frag( in v2f i ) {
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump vec4 shadows_23;
  highp vec4 shadowVals_24;
  highp vec3 vec_25;
  vec_25 = (tmpvar_18 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureCube (_ShadowMapTexture, vec_25);
  packDist_26 = tmpvar_27;
  shadowVals_24.x = dot (packDist_26, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_28;
  vec_28 = (tmpvar_18 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureCube (_ShadowMapTexture, vec_28);
  packDist_29 = tmpvar_30;
  shadowVals_24.y = dot (packDist_29, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_31;
  vec_31 = (tmpvar_18 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureCube (_ShadowMapTexture, vec_31);
  packDist_32 = tmpvar_33;
  shadowVals_24.z = dot (packDist_32, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_34;
  vec_34 = (tmpvar_18 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = textureCube (_ShadowMapTexture, vec_34);
  packDist_35 = tmpvar_36;
  shadowVals_24.w = dot (packDist_35, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_37;
  tmpvar_37 = lessThan (shadowVals_24, vec4(tmpvar_22));
  highp vec4 tmpvar_38;
  tmpvar_38 = _LightShadowData.xxxx;
  highp float tmpvar_39;
  if (tmpvar_37.x) {
    tmpvar_39 = tmpvar_38.x;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_37.y) {
    tmpvar_40 = tmpvar_38.y;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_37.z) {
    tmpvar_41 = tmpvar_38.z;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_37.w) {
    tmpvar_42 = tmpvar_38.w;
  } else {
    tmpvar_42 = 1.0;
  };
  highp vec4 tmpvar_43;
  tmpvar_43.x = tmpvar_39;
  tmpvar_43.y = tmpvar_40;
  tmpvar_43.z = tmpvar_41;
  tmpvar_43.w = tmpvar_42;
  shadows_23 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_45;
  tmpvar_45 = (atten_5 * tmpvar_44);
  atten_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (spec_3 * clamp (tmpvar_45, 0.0, 1.0));
  spec_3 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = (_LightColor.xyz * (tmpvar_46 * tmpvar_45));
  res_2.xyz = tmpvar_50;
  lowp vec3 c_51;
  c_51 = _LightColor.xyz;
  lowp float tmpvar_52;
  tmpvar_52 = dot (c_51, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_53;
  tmpvar_53 = (tmpvar_49 * tmpvar_52);
  res_2.w = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_55;
  tmpvar_55 = (res_2 * tmpvar_54);
  res_2 = tmpvar_55;
  mediump vec4 tmpvar_56;
  tmpvar_56 = exp2(-(tmpvar_55));
  tmpvar_1 = tmpvar_56;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 407
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 407
#line 365
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    #line 360
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 370
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    #line 374
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 379
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 383
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 387
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 391
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 395
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    #line 399
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    #line 403
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 407
lowp vec4 frag( in v2f i ) {
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump vec4 shadows_23;
  highp vec4 shadowVals_24;
  highp vec3 vec_25;
  vec_25 = (tmpvar_18 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureCube (_ShadowMapTexture, vec_25);
  packDist_26 = tmpvar_27;
  shadowVals_24.x = dot (packDist_26, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_28;
  vec_28 = (tmpvar_18 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureCube (_ShadowMapTexture, vec_28);
  packDist_29 = tmpvar_30;
  shadowVals_24.y = dot (packDist_29, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_31;
  vec_31 = (tmpvar_18 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureCube (_ShadowMapTexture, vec_31);
  packDist_32 = tmpvar_33;
  shadowVals_24.z = dot (packDist_32, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_34;
  vec_34 = (tmpvar_18 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = textureCube (_ShadowMapTexture, vec_34);
  packDist_35 = tmpvar_36;
  shadowVals_24.w = dot (packDist_35, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_37;
  tmpvar_37 = lessThan (shadowVals_24, vec4(tmpvar_22));
  highp vec4 tmpvar_38;
  tmpvar_38 = _LightShadowData.xxxx;
  highp float tmpvar_39;
  if (tmpvar_37.x) {
    tmpvar_39 = tmpvar_38.x;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_37.y) {
    tmpvar_40 = tmpvar_38.y;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_37.z) {
    tmpvar_41 = tmpvar_38.z;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_37.w) {
    tmpvar_42 = tmpvar_38.w;
  } else {
    tmpvar_42 = 1.0;
  };
  highp vec4 tmpvar_43;
  tmpvar_43.x = tmpvar_39;
  tmpvar_43.y = tmpvar_40;
  tmpvar_43.z = tmpvar_41;
  tmpvar_43.w = tmpvar_42;
  shadows_23 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_15;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = (_LightMatrix0 * tmpvar_45).xyz;
  tmpvar_46 = textureCube (_LightTexture0, P_47);
  highp float tmpvar_48;
  tmpvar_48 = ((atten_5 * tmpvar_44) * tmpvar_46.w);
  atten_5 = tmpvar_48;
  mediump float tmpvar_49;
  tmpvar_49 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = (spec_3 * clamp (tmpvar_48, 0.0, 1.0));
  spec_3 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (_LightColor.xyz * (tmpvar_49 * tmpvar_48));
  res_2.xyz = tmpvar_53;
  lowp vec3 c_54;
  c_54 = _LightColor.xyz;
  lowp float tmpvar_55;
  tmpvar_55 = dot (c_54, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_56;
  tmpvar_56 = (tmpvar_52 * tmpvar_55);
  res_2.w = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_58;
  tmpvar_58 = (res_2 * tmpvar_57);
  res_2 = tmpvar_58;
  mediump vec4 tmpvar_59;
  tmpvar_59 = exp2(-(tmpvar_58));
  tmpvar_1 = tmpvar_59;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 408
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 408
#line 365
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    #line 360
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 370
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    #line 374
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 379
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 383
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 387
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 391
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 395
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 399
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 403
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 408
lowp vec4 frag( in v2f i ) {
    return exp2((-CalculateLight( i)));
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}
}
 }
 Pass {
  ZWrite Off
  Fog { Mode Off }
  Blend One One
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_18;
  tmpvar_18 = -(normalize(tmpvar_17));
  lightDir_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19)).w;
  atten_5 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (spec_3 * clamp (atten_5, 0.0, 1.0));
  spec_3 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (_LightColor.xyz * (tmpvar_21 * atten_5));
  res_2.xyz = tmpvar_25;
  lowp vec3 c_26;
  c_26 = _LightColor.xyz;
  lowp float tmpvar_27;
  tmpvar_27 = dot (c_26, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_24 * tmpvar_27);
  res_2.w = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_2 * tmpvar_29);
  res_2 = tmpvar_30;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 385
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 385
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 373
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    #line 377
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    #line 381
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 385
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec4 nspec_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_8);
  nspec_7 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(((nspec_7.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_8).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (lightDir_5, tmpvar_10));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (0.0, dot (h_4, tmpvar_10)), (nspec_7.w * 128.0));
  spec_3 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (spec_3 * clamp (1.0, 0.0, 1.0));
  spec_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_LightColor.xyz * tmpvar_17);
  res_2.xyz = tmpvar_21;
  lowp vec3 c_22;
  c_22 = _LightColor.xyz;
  lowp float tmpvar_23;
  tmpvar_23 = dot (c_22, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_20 * tmpvar_23);
  res_2.w = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 - ((mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_26;
  tmpvar_26 = (res_2 * tmpvar_25);
  res_2 = tmpvar_26;
  tmpvar_1 = tmpvar_26;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 373
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 377
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 381
    return res;
}
#line 383
lowp vec4 frag( in v2f i ) {
    #line 385
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_17);
  lightDir_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_15;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_LightMatrix0 * tmpvar_19);
  lowp float tmpvar_21;
  tmpvar_21 = texture2DProj (_LightTexture0, tmpvar_20).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_LightTextureB0, vec2(tmpvar_22));
  highp float tmpvar_24;
  tmpvar_24 = ((atten_5 * float((tmpvar_20.w < 0.0))) * tmpvar_23.w);
  atten_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    #line 373
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    #line 377
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 381
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 385
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 388
lowp vec4 frag( in v2f i ) {
    #line 390
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_18;
  tmpvar_18 = -(normalize(tmpvar_17));
  lightDir_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19)).w;
  atten_5 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_15;
  lowp vec4 tmpvar_22;
  highp vec3 P_23;
  P_23 = (_LightMatrix0 * tmpvar_21).xyz;
  tmpvar_22 = textureCube (_LightTexture0, P_23);
  highp float tmpvar_24;
  tmpvar_24 = (atten_5 * tmpvar_22.w);
  atten_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
#line 353
#line 357
#line 386
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
#line 353
#line 357
#line 386
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 373
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 377
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 381
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 386
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec4 nspec_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_8);
  nspec_7 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(((nspec_7.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_8).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_14;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (_LightMatrix0 * tmpvar_17).xy;
  tmpvar_18 = texture2D (_LightTexture0, P_19);
  highp float tmpvar_20;
  tmpvar_20 = tmpvar_18.w;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (lightDir_5, tmpvar_10));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (0.0, dot (h_4, tmpvar_10)), (nspec_7.w * 128.0));
  spec_3 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (spec_3 * clamp (tmpvar_20, 0.0, 1.0));
  spec_3 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (_LightColor.xyz * (tmpvar_21 * tmpvar_20));
  res_2.xyz = tmpvar_25;
  lowp vec3 c_26;
  c_26 = _LightColor.xyz;
  lowp float tmpvar_27;
  tmpvar_27 = dot (c_26, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_24 * tmpvar_27);
  res_2.w = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - ((mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_2 * tmpvar_29);
  res_2 = tmpvar_30;
  tmpvar_1 = tmpvar_30;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xy).w;
    #line 373
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 377
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 381
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 384
lowp vec4 frag( in v2f i ) {
    #line 386
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_15;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_World2Shadow[0] * tmpvar_27);
  mediump float shadow_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_ShadowMapTexture, tmpvar_28);
  highp float tmpvar_31;
  if ((tmpvar_30.x < (tmpvar_28.z / tmpvar_28.w))) {
    tmpvar_31 = _LightShadowData.x;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_29 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((shadow_29 + tmpvar_26), 0.0, 1.0);
  tmpvar_25 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (spec_3 * clamp (tmpvar_33, 0.0, 1.0));
  spec_3 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (_LightColor.xyz * (tmpvar_34 * tmpvar_33));
  res_2.xyz = tmpvar_38;
  lowp vec3 c_39;
  c_39 = _LightColor.xyz;
  lowp float tmpvar_40;
  tmpvar_40 = dot (c_39, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_37 * tmpvar_40);
  res_2.w = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (res_2 * tmpvar_42);
  res_2 = tmpvar_43;
  tmpvar_1 = tmpvar_43;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 398
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 398
#line 354
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 356
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 349
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = (( (textureProj( _ShadowMapTexture, shadowCoord).x < (shadowCoord.z / shadowCoord.w)) ) ? ( _LightShadowData.x ) : ( 1.0 ));
    #line 352
    return shadow;
}
#line 359
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 361
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 365
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 367
mediump vec4 CalculateLight( in v2f i ) {
    #line 369
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 373
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 377
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 381
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 385
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 389
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 393
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 398
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_15;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_World2Shadow[0] * tmpvar_26);
  mediump float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DProjEXT (_ShadowMapTexture, tmpvar_27);
  shadow_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (shadow_28 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp ((shadow_28 + clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_25 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (spec_3 * clamp (tmpvar_32, 0.0, 1.0));
  spec_3 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = (_LightColor.xyz * (tmpvar_33 * tmpvar_32));
  res_2.xyz = tmpvar_37;
  lowp vec3 c_38;
  c_38 = _LightColor.xyz;
  lowp float tmpvar_39;
  tmpvar_39 = dot (c_38, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_36 * tmpvar_39);
  res_2.w = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (res_2 * tmpvar_41);
  res_2 = tmpvar_42;
  tmpvar_1 = tmpvar_42;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 399
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2Dproj(mediump sampler2DShadow s, vec4 coord) { return textureProj (s, coord); }
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 399
#line 355
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 357
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 349
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = xll_shadow2Dproj( _ShadowMapTexture, shadowCoord);
    #line 352
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 360
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 362
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 366
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 368
mediump vec4 CalculateLight( in v2f i ) {
    #line 370
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 374
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 378
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 382
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 386
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 390
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 394
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 399
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec3 normal_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  normal_7 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_16;
  tmpvar_16 = mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_17;
  mediump float tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowMapTexture, tmpvar_9);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19.x + clamp (((tmpvar_16 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_18 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = tmpvar_18;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (lightDir_5, normal_7));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (0.0, dot (h_4, normal_7)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = (spec_3 * clamp (tmpvar_21, 0.0, 1.0));
  spec_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (_LightColor.xyz * (tmpvar_22 * tmpvar_21));
  res_2.xyz = tmpvar_26;
  lowp vec3 c_27;
  c_27 = _LightColor.xyz;
  lowp float tmpvar_28;
  tmpvar_28 = dot (c_27, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_29;
  tmpvar_29 = (tmpvar_25 * tmpvar_28);
  res_2.w = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp ((1.0 - ((tmpvar_16 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_31;
  tmpvar_31 = (res_2 * tmpvar_30);
  res_2 = tmpvar_31;
  tmpvar_1 = tmpvar_31;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 349
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    #line 352
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 354
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 356
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    return xll_saturate_f((texture( _ShadowMapTexture, uv).x + fade));
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 361
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 365
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 369
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 373
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 377
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 381
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 385
    return res;
}
#line 387
lowp vec4 frag( in v2f i ) {
    #line 389
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec3 normal_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  normal_7 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_16;
  tmpvar_16 = mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_17;
  mediump float tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowMapTexture, tmpvar_9);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19.x + clamp (((tmpvar_16 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_18 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_14;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (_LightMatrix0 * tmpvar_21).xy;
  tmpvar_22 = texture2D (_LightTexture0, P_23);
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_18 * tmpvar_22.w);
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_5, normal_7));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, normal_7)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((tmpvar_16 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  tmpvar_1 = tmpvar_34;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 349
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    #line 352
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 354
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 356
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    return xll_saturate_f((texture( _ShadowMapTexture, uv).x + fade));
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 361
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 365
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 369
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 373
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xy).w;
    #line 377
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 381
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 385
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 388
lowp vec4 frag( in v2f i ) {
    #line 390
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump float tmpvar_23;
  highp vec4 packDist_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureCube (_ShadowMapTexture, tmpvar_18);
  packDist_24 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (packDist_24, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_27;
  if ((tmpvar_26 < tmpvar_22)) {
    tmpvar_27 = _LightShadowData.x;
  } else {
    tmpvar_27 = 1.0;
  };
  tmpvar_23 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (atten_5 * tmpvar_23);
  atten_5 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (spec_3 * clamp (tmpvar_28, 0.0, 1.0));
  spec_3 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (_LightColor.xyz * (tmpvar_29 * tmpvar_28));
  res_2.xyz = tmpvar_33;
  lowp vec3 c_34;
  c_34 = _LightColor.xyz;
  lowp float tmpvar_35;
  tmpvar_35 = dot (c_34, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_36;
  tmpvar_36 = (tmpvar_32 * tmpvar_35);
  res_2.w = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_38;
  tmpvar_38 = (res_2 * tmpvar_37);
  res_2 = tmpvar_38;
  tmpvar_1 = tmpvar_38;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 359
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 361
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 364
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 366
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    #line 370
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 373
mediump vec4 CalculateLight( in v2f i ) {
    #line 375
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 379
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 383
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    #line 387
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 391
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 395
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 399
    return res;
}
#line 401
lowp vec4 frag( in v2f i ) {
    #line 403
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump float tmpvar_23;
  highp vec4 packDist_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureCube (_ShadowMapTexture, tmpvar_18);
  packDist_24 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (packDist_24, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_27;
  if ((tmpvar_26 < tmpvar_22)) {
    tmpvar_27 = _LightShadowData.x;
  } else {
    tmpvar_27 = 1.0;
  };
  tmpvar_23 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_15;
  lowp vec4 tmpvar_29;
  highp vec3 P_30;
  P_30 = (_LightMatrix0 * tmpvar_28).xyz;
  tmpvar_29 = textureCube (_LightTexture0, P_30);
  highp float tmpvar_31;
  tmpvar_31 = ((atten_5 * tmpvar_23) * tmpvar_29.w);
  atten_5 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (spec_3 * clamp (tmpvar_31, 0.0, 1.0));
  spec_3 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = (_LightColor.xyz * (tmpvar_32 * tmpvar_31));
  res_2.xyz = tmpvar_36;
  lowp vec3 c_37;
  c_37 = _LightColor.xyz;
  lowp float tmpvar_38;
  tmpvar_38 = dot (c_37, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_35 * tmpvar_38);
  res_2.w = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (res_2 * tmpvar_40);
  res_2 = tmpvar_41;
  tmpvar_1 = tmpvar_41;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 359
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 361
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 364
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 366
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    #line 370
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 373
mediump vec4 CalculateLight( in v2f i ) {
    #line 375
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 379
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 383
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    #line 387
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    #line 391
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 395
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 399
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 402
lowp vec4 frag( in v2f i ) {
    #line 404
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_15;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_World2Shadow[0] * tmpvar_27);
  mediump vec4 shadows_29;
  highp vec4 shadowVals_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_28.xyz / tmpvar_28.w);
  highp vec2 P_32;
  P_32 = (tmpvar_31.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_33;
  tmpvar_33 = texture2D (_ShadowMapTexture, P_32).x;
  shadowVals_30.x = tmpvar_33;
  highp vec2 P_34;
  P_34 = (tmpvar_31.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, P_34).x;
  shadowVals_30.y = tmpvar_35;
  highp vec2 P_36;
  P_36 = (tmpvar_31.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_37;
  tmpvar_37 = texture2D (_ShadowMapTexture, P_36).x;
  shadowVals_30.z = tmpvar_37;
  highp vec2 P_38;
  P_38 = (tmpvar_31.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, P_38).x;
  shadowVals_30.w = tmpvar_39;
  bvec4 tmpvar_40;
  tmpvar_40 = lessThan (shadowVals_30, tmpvar_31.zzzz);
  highp vec4 tmpvar_41;
  tmpvar_41 = _LightShadowData.xxxx;
  highp float tmpvar_42;
  if (tmpvar_40.x) {
    tmpvar_42 = tmpvar_41.x;
  } else {
    tmpvar_42 = 1.0;
  };
  highp float tmpvar_43;
  if (tmpvar_40.y) {
    tmpvar_43 = tmpvar_41.y;
  } else {
    tmpvar_43 = 1.0;
  };
  highp float tmpvar_44;
  if (tmpvar_40.z) {
    tmpvar_44 = tmpvar_41.z;
  } else {
    tmpvar_44 = 1.0;
  };
  highp float tmpvar_45;
  if (tmpvar_40.w) {
    tmpvar_45 = tmpvar_41.w;
  } else {
    tmpvar_45 = 1.0;
  };
  highp vec4 tmpvar_46;
  tmpvar_46.x = tmpvar_42;
  tmpvar_46.y = tmpvar_43;
  tmpvar_46.z = tmpvar_44;
  tmpvar_46.w = tmpvar_45;
  shadows_29 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = dot (shadows_29, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_48;
  tmpvar_48 = clamp ((tmpvar_47 + tmpvar_26), 0.0, 1.0);
  tmpvar_25 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_51;
  mediump float tmpvar_52;
  tmpvar_52 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = (spec_3 * clamp (tmpvar_49, 0.0, 1.0));
  spec_3 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (_LightColor.xyz * (tmpvar_50 * tmpvar_49));
  res_2.xyz = tmpvar_54;
  lowp vec3 c_55;
  c_55 = _LightColor.xyz;
  lowp float tmpvar_56;
  tmpvar_56 = dot (c_55, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_57;
  tmpvar_57 = (tmpvar_53 * tmpvar_56);
  res_2.w = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_59;
  tmpvar_59 = (res_2 * tmpvar_58);
  res_2 = tmpvar_59;
  tmpvar_1 = tmpvar_59;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 362
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 364
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 350
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 352
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    highp vec4 shadowVals;
    shadowVals.x = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[0].xy)).x;
    shadowVals.y = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[1].xy)).x;
    #line 356
    shadowVals.z = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[2].xy)).x;
    shadowVals.w = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[3].xy)).x;
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, coord.zzzz), vec4( _LightShadowData.xxxx), vec4( 1.0));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 360
    return shadow;
}
#line 367
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 369
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 373
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 375
mediump vec4 CalculateLight( in v2f i ) {
    #line 377
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 381
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 385
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 389
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 393
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 397
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 401
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 406
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_15;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_World2Shadow[0] * tmpvar_26);
  mediump vec4 shadows_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_27.xyz / tmpvar_27.w);
  highp vec3 coord_30;
  coord_30 = (tmpvar_29 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_31;
  tmpvar_31 = shadow2DEXT (_ShadowMapTexture, coord_30);
  shadows_28.x = tmpvar_31;
  highp vec3 coord_32;
  coord_32 = (tmpvar_29 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_33;
  tmpvar_33 = shadow2DEXT (_ShadowMapTexture, coord_32);
  shadows_28.y = tmpvar_33;
  highp vec3 coord_34;
  coord_34 = (tmpvar_29 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_35;
  tmpvar_35 = shadow2DEXT (_ShadowMapTexture, coord_34);
  shadows_28.z = tmpvar_35;
  highp vec3 coord_36;
  coord_36 = (tmpvar_29 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, coord_36);
  shadows_28.w = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (_LightShadowData.xxxx + (shadows_28 * (1.0 - _LightShadowData.xxxx)));
  shadows_28 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = dot (shadows_28, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_40;
  tmpvar_40 = clamp ((tmpvar_39 + clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_25 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (spec_3 * clamp (tmpvar_41, 0.0, 1.0));
  spec_3 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (_LightColor.xyz * (tmpvar_42 * tmpvar_41));
  res_2.xyz = tmpvar_46;
  lowp vec3 c_47;
  c_47 = _LightColor.xyz;
  lowp float tmpvar_48;
  tmpvar_48 = dot (c_47, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_45 * tmpvar_48);
  res_2.w = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_51;
  tmpvar_51 = (res_2 * tmpvar_50);
  res_2 = tmpvar_51;
  tmpvar_1 = tmpvar_51;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 362
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 364
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 350
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 352
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    mediump vec4 shadows;
    shadows.x = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[0])).xyz);
    shadows.y = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[1])).xyz);
    #line 356
    shadows.z = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[2])).xyz);
    shadows.w = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[3])).xyz);
    shadows = (_LightShadowData.xxxx + (shadows * (1.0 - _LightShadowData.xxxx)));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 360
    return shadow;
}
#line 367
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 369
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 373
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 375
mediump vec4 CalculateLight( in v2f i ) {
    #line 377
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 381
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 385
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 389
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 393
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 397
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 401
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 406
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump vec4 shadows_23;
  highp vec4 shadowVals_24;
  highp vec3 vec_25;
  vec_25 = (tmpvar_18 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureCube (_ShadowMapTexture, vec_25);
  packDist_26 = tmpvar_27;
  shadowVals_24.x = dot (packDist_26, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_28;
  vec_28 = (tmpvar_18 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureCube (_ShadowMapTexture, vec_28);
  packDist_29 = tmpvar_30;
  shadowVals_24.y = dot (packDist_29, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_31;
  vec_31 = (tmpvar_18 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureCube (_ShadowMapTexture, vec_31);
  packDist_32 = tmpvar_33;
  shadowVals_24.z = dot (packDist_32, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_34;
  vec_34 = (tmpvar_18 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = textureCube (_ShadowMapTexture, vec_34);
  packDist_35 = tmpvar_36;
  shadowVals_24.w = dot (packDist_35, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_37;
  tmpvar_37 = lessThan (shadowVals_24, vec4(tmpvar_22));
  highp vec4 tmpvar_38;
  tmpvar_38 = _LightShadowData.xxxx;
  highp float tmpvar_39;
  if (tmpvar_37.x) {
    tmpvar_39 = tmpvar_38.x;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_37.y) {
    tmpvar_40 = tmpvar_38.y;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_37.z) {
    tmpvar_41 = tmpvar_38.z;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_37.w) {
    tmpvar_42 = tmpvar_38.w;
  } else {
    tmpvar_42 = 1.0;
  };
  highp vec4 tmpvar_43;
  tmpvar_43.x = tmpvar_39;
  tmpvar_43.y = tmpvar_40;
  tmpvar_43.z = tmpvar_41;
  tmpvar_43.w = tmpvar_42;
  shadows_23 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_45;
  tmpvar_45 = (atten_5 * tmpvar_44);
  atten_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (spec_3 * clamp (tmpvar_45, 0.0, 1.0));
  spec_3 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = (_LightColor.xyz * (tmpvar_46 * tmpvar_45));
  res_2.xyz = tmpvar_50;
  lowp vec3 c_51;
  c_51 = _LightColor.xyz;
  lowp float tmpvar_52;
  tmpvar_52 = dot (c_51, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_53;
  tmpvar_53 = (tmpvar_49 * tmpvar_52);
  res_2.w = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_55;
  tmpvar_55 = (res_2 * tmpvar_54);
  res_2 = tmpvar_55;
  tmpvar_1 = tmpvar_55;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 407
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 407
#line 365
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    #line 360
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 370
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    #line 374
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 379
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 383
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 387
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 391
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 395
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    #line 399
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    #line 403
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 407
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump vec4 shadows_23;
  highp vec4 shadowVals_24;
  highp vec3 vec_25;
  vec_25 = (tmpvar_18 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureCube (_ShadowMapTexture, vec_25);
  packDist_26 = tmpvar_27;
  shadowVals_24.x = dot (packDist_26, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_28;
  vec_28 = (tmpvar_18 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureCube (_ShadowMapTexture, vec_28);
  packDist_29 = tmpvar_30;
  shadowVals_24.y = dot (packDist_29, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_31;
  vec_31 = (tmpvar_18 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureCube (_ShadowMapTexture, vec_31);
  packDist_32 = tmpvar_33;
  shadowVals_24.z = dot (packDist_32, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_34;
  vec_34 = (tmpvar_18 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = textureCube (_ShadowMapTexture, vec_34);
  packDist_35 = tmpvar_36;
  shadowVals_24.w = dot (packDist_35, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_37;
  tmpvar_37 = lessThan (shadowVals_24, vec4(tmpvar_22));
  highp vec4 tmpvar_38;
  tmpvar_38 = _LightShadowData.xxxx;
  highp float tmpvar_39;
  if (tmpvar_37.x) {
    tmpvar_39 = tmpvar_38.x;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_37.y) {
    tmpvar_40 = tmpvar_38.y;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_37.z) {
    tmpvar_41 = tmpvar_38.z;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_37.w) {
    tmpvar_42 = tmpvar_38.w;
  } else {
    tmpvar_42 = 1.0;
  };
  highp vec4 tmpvar_43;
  tmpvar_43.x = tmpvar_39;
  tmpvar_43.y = tmpvar_40;
  tmpvar_43.z = tmpvar_41;
  tmpvar_43.w = tmpvar_42;
  shadows_23 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_15;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = (_LightMatrix0 * tmpvar_45).xyz;
  tmpvar_46 = textureCube (_LightTexture0, P_47);
  highp float tmpvar_48;
  tmpvar_48 = ((atten_5 * tmpvar_44) * tmpvar_46.w);
  atten_5 = tmpvar_48;
  mediump float tmpvar_49;
  tmpvar_49 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = (spec_3 * clamp (tmpvar_48, 0.0, 1.0));
  spec_3 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (_LightColor.xyz * (tmpvar_49 * tmpvar_48));
  res_2.xyz = tmpvar_53;
  lowp vec3 c_54;
  c_54 = _LightColor.xyz;
  lowp float tmpvar_55;
  tmpvar_55 = dot (c_54, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_56;
  tmpvar_56 = (tmpvar_52 * tmpvar_55);
  res_2.w = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_58;
  tmpvar_58 = (res_2 * tmpvar_57);
  res_2 = tmpvar_58;
  tmpvar_1 = tmpvar_58;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 408
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 408
#line 365
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    #line 360
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 370
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    #line 374
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 379
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 383
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 387
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 391
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 395
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 399
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 403
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 408
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i);
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}
}
 }
 Pass {
  ZWrite Off
  Fog { Mode Off }
  Blend One One
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_18;
  tmpvar_18 = -(normalize(tmpvar_17));
  lightDir_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19)).w;
  atten_5 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (spec_3 * clamp (atten_5, 0.0, 1.0));
  spec_3 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (_LightColor.xyz * (tmpvar_21 * atten_5));
  res_2.xyz = tmpvar_25;
  lowp vec3 c_26;
  c_26 = _LightColor.xyz;
  lowp float tmpvar_27;
  tmpvar_27 = dot (c_26, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_24 * tmpvar_27);
  res_2.w = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_2 * tmpvar_29);
  res_2 = tmpvar_30;
  tmpvar_1 = tmpvar_30.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 385
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 385
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 373
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    #line 377
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    #line 381
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 385
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec4 nspec_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_8);
  nspec_7 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(((nspec_7.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_8).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = max (0.0, dot (lightDir_5, tmpvar_10));
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (0.0, dot (h_4, tmpvar_10)), (nspec_7.w * 128.0));
  spec_3 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (spec_3 * clamp (1.0, 0.0, 1.0));
  spec_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_LightColor.xyz * tmpvar_17);
  res_2.xyz = tmpvar_21;
  lowp vec3 c_22;
  c_22 = _LightColor.xyz;
  lowp float tmpvar_23;
  tmpvar_23 = dot (c_22, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_20 * tmpvar_23);
  res_2.w = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 - ((mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_26;
  tmpvar_26 = (res_2 * tmpvar_25);
  res_2 = tmpvar_26;
  tmpvar_1 = tmpvar_26.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 373
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 377
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 381
    return res;
}
#line 383
lowp vec4 frag( in v2f i ) {
    #line 385
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_17);
  lightDir_6 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_15;
  highp vec4 tmpvar_20;
  tmpvar_20 = (_LightMatrix0 * tmpvar_19);
  lowp float tmpvar_21;
  tmpvar_21 = texture2DProj (_LightTexture0, tmpvar_20).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_LightTextureB0, vec2(tmpvar_22));
  highp float tmpvar_24;
  tmpvar_24 = ((atten_5 * float((tmpvar_20.w < 0.0))) * tmpvar_23.w);
  atten_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  tmpvar_1 = tmpvar_34.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    #line 373
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    #line 377
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 381
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 385
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 388
lowp vec4 frag( in v2f i ) {
    #line 390
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_18;
  tmpvar_18 = -(normalize(tmpvar_17));
  lightDir_6 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (dot (tmpvar_17, tmpvar_17) * _LightPos.w);
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_LightTextureB0, vec2(tmpvar_19)).w;
  atten_5 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_15;
  lowp vec4 tmpvar_22;
  highp vec3 P_23;
  P_23 = (_LightMatrix0 * tmpvar_21).xyz;
  tmpvar_22 = textureCube (_LightTexture0, P_23);
  highp float tmpvar_24;
  tmpvar_24 = (atten_5 * tmpvar_22.w);
  atten_5 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_6, tmpvar_11));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, tmpvar_11)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  tmpvar_1 = tmpvar_34.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
#line 353
#line 357
#line 386
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
#line 353
#line 357
#line 386
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 373
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 377
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 381
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 386
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec4 nspec_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_CameraNormalsTexture, tmpvar_8);
  nspec_7 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(((nspec_7.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_8).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_14;
  lowp vec4 tmpvar_18;
  highp vec2 P_19;
  P_19 = (_LightMatrix0 * tmpvar_17).xy;
  tmpvar_18 = texture2D (_LightTexture0, P_19);
  highp float tmpvar_20;
  tmpvar_20 = tmpvar_18.w;
  mediump float tmpvar_21;
  tmpvar_21 = max (0.0, dot (lightDir_5, tmpvar_10));
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (0.0, dot (h_4, tmpvar_10)), (nspec_7.w * 128.0));
  spec_3 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (spec_3 * clamp (tmpvar_20, 0.0, 1.0));
  spec_3 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (_LightColor.xyz * (tmpvar_21 * tmpvar_20));
  res_2.xyz = tmpvar_25;
  lowp vec3 c_26;
  c_26 = _LightColor.xyz;
  lowp float tmpvar_27;
  tmpvar_27 = dot (c_26, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_28;
  tmpvar_28 = (tmpvar_24 * tmpvar_27);
  res_2.w = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp ((1.0 - ((mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w) * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_30;
  tmpvar_30 = (res_2 * tmpvar_29);
  res_2 = tmpvar_30;
  tmpvar_1 = tmpvar_30.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
#line 353
#line 357
#line 348
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 353
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 357
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 361
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 365
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 369
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xy).w;
    #line 373
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 377
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 381
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 384
lowp vec4 frag( in v2f i ) {
    #line 386
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_15;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_World2Shadow[0] * tmpvar_27);
  mediump float shadow_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2DProj (_ShadowMapTexture, tmpvar_28);
  highp float tmpvar_31;
  if ((tmpvar_30.x < (tmpvar_28.z / tmpvar_28.w))) {
    tmpvar_31 = _LightShadowData.x;
  } else {
    tmpvar_31 = 1.0;
  };
  shadow_29 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp ((shadow_29 + tmpvar_26), 0.0, 1.0);
  tmpvar_25 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = (spec_3 * clamp (tmpvar_33, 0.0, 1.0));
  spec_3 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (_LightColor.xyz * (tmpvar_34 * tmpvar_33));
  res_2.xyz = tmpvar_38;
  lowp vec3 c_39;
  c_39 = _LightColor.xyz;
  lowp float tmpvar_40;
  tmpvar_40 = dot (c_39, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_41;
  tmpvar_41 = (tmpvar_37 * tmpvar_40);
  res_2.w = tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_43;
  tmpvar_43 = (res_2 * tmpvar_42);
  res_2 = tmpvar_43;
  tmpvar_1 = tmpvar_43.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 398
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 398
#line 354
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 356
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 349
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = (( (textureProj( _ShadowMapTexture, shadowCoord).x < (shadowCoord.z / shadowCoord.w)) ) ? ( _LightShadowData.x ) : ( 1.0 ));
    #line 352
    return shadow;
}
#line 359
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 361
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 365
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 367
mediump vec4 CalculateLight( in v2f i ) {
    #line 369
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 373
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 377
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 381
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 385
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 389
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 393
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 398
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_15;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_World2Shadow[0] * tmpvar_26);
  mediump float shadow_28;
  lowp float tmpvar_29;
  tmpvar_29 = shadow2DProjEXT (_ShadowMapTexture, tmpvar_27);
  shadow_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (_LightShadowData.x + (shadow_28 * (1.0 - _LightShadowData.x)));
  shadow_28 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp ((shadow_28 + clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_25 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_34;
  mediump float tmpvar_35;
  tmpvar_35 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = (spec_3 * clamp (tmpvar_32, 0.0, 1.0));
  spec_3 = tmpvar_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = (_LightColor.xyz * (tmpvar_33 * tmpvar_32));
  res_2.xyz = tmpvar_37;
  lowp vec3 c_38;
  c_38 = _LightColor.xyz;
  lowp float tmpvar_39;
  tmpvar_39 = dot (c_38, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_40;
  tmpvar_40 = (tmpvar_36 * tmpvar_39);
  res_2.w = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_42;
  tmpvar_42 = (res_2 * tmpvar_41);
  res_2 = tmpvar_42;
  tmpvar_1 = tmpvar_42.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 399
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2Dproj(mediump sampler2DShadow s, vec4 coord) { return textureProj (s, coord); }
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 399
#line 355
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 357
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 349
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    mediump float shadow = xll_shadow2Dproj( _ShadowMapTexture, shadowCoord);
    #line 352
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    return shadow;
}
#line 360
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 362
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 366
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 368
mediump vec4 CalculateLight( in v2f i ) {
    #line 370
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 374
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 378
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 382
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 386
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 390
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 394
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 399
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec3 normal_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  normal_7 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_16;
  tmpvar_16 = mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_17;
  mediump float tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowMapTexture, tmpvar_9);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19.x + clamp (((tmpvar_16 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_18 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = tmpvar_18;
  mediump float tmpvar_22;
  tmpvar_22 = max (0.0, dot (lightDir_5, normal_7));
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (0.0, dot (h_4, normal_7)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = (spec_3 * clamp (tmpvar_21, 0.0, 1.0));
  spec_3 = tmpvar_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = (_LightColor.xyz * (tmpvar_22 * tmpvar_21));
  res_2.xyz = tmpvar_26;
  lowp vec3 c_27;
  c_27 = _LightColor.xyz;
  lowp float tmpvar_28;
  tmpvar_28 = dot (c_27, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_29;
  tmpvar_29 = (tmpvar_25 * tmpvar_28);
  res_2.w = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp ((1.0 - ((tmpvar_16 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_31;
  tmpvar_31 = (res_2 * tmpvar_30);
  res_2 = tmpvar_31;
  tmpvar_1 = tmpvar_31.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 349
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    #line 352
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 354
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 356
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    return xll_saturate_f((texture( _ShadowMapTexture, uv).x + fade));
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 361
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 365
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 369
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 373
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 377
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 381
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 385
    return res;
}
#line 387
lowp vec4 frag( in v2f i ) {
    #line 389
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightDir;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  mediump vec3 lightDir_5;
  highp float depth_6;
  mediump vec3 normal_7;
  mediump vec4 nspec_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_CameraNormalsTexture, tmpvar_9);
  nspec_8 = tmpvar_10;
  normal_7 = normalize(((nspec_8.xyz * 2.0) - 1.0));
  lowp float tmpvar_11;
  tmpvar_11 = texture2D (_CameraDepthTexture, tmpvar_9).x;
  depth_6 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (1.0/(((_ZBufferParams.x * depth_6) + _ZBufferParams.y)));
  depth_6 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_12);
  highp vec3 tmpvar_14;
  tmpvar_14 = (_CameraToWorld * tmpvar_13).xyz;
  highp vec3 p_15;
  p_15 = (tmpvar_14 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_16;
  tmpvar_16 = mix (tmpvar_13.z, sqrt(dot (p_15, p_15)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_17;
  tmpvar_17 = -(_LightDir.xyz);
  lightDir_5 = tmpvar_17;
  mediump float tmpvar_18;
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_ShadowMapTexture, tmpvar_9);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19.x + clamp (((tmpvar_16 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_18 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = tmpvar_14;
  lowp vec4 tmpvar_22;
  highp vec2 P_23;
  P_23 = (_LightMatrix0 * tmpvar_21).xy;
  tmpvar_22 = texture2D (_LightTexture0, P_23);
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_18 * tmpvar_22.w);
  mediump float tmpvar_25;
  tmpvar_25 = max (0.0, dot (lightDir_5, normal_7));
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize((lightDir_5 - normalize((tmpvar_14 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (0.0, dot (h_4, normal_7)), (nspec_8.w * 128.0));
  spec_3 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (spec_3 * clamp (tmpvar_24, 0.0, 1.0));
  spec_3 = tmpvar_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (_LightColor.xyz * (tmpvar_25 * tmpvar_24));
  res_2.xyz = tmpvar_29;
  lowp vec3 c_30;
  c_30 = _LightColor.xyz;
  lowp float tmpvar_31;
  tmpvar_31 = dot (c_30, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_32;
  tmpvar_32 = (tmpvar_28 * tmpvar_31);
  res_2.w = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp ((1.0 - ((tmpvar_16 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_34;
  tmpvar_34 = (res_2 * tmpvar_33);
  res_2 = tmpvar_34;
  tmpvar_1 = tmpvar_34.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
uniform lowp vec4 _WorldSpaceLightPos0;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
#line 361
#line 349
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    #line 352
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 354
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 356
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    return xll_saturate_f((texture( _ShadowMapTexture, uv).x + fade));
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 361
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 365
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 369
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 373
    mediump vec3 lightDir = (-_LightDir.xyz);
    highp float atten = 1.0;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xy).w;
    #line 377
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 381
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 385
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 388
lowp vec4 frag( in v2f i ) {
    #line 390
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump float tmpvar_23;
  highp vec4 packDist_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureCube (_ShadowMapTexture, tmpvar_18);
  packDist_24 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (packDist_24, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_27;
  if ((tmpvar_26 < tmpvar_22)) {
    tmpvar_27 = _LightShadowData.x;
  } else {
    tmpvar_27 = 1.0;
  };
  tmpvar_23 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = (atten_5 * tmpvar_23);
  atten_5 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = (spec_3 * clamp (tmpvar_28, 0.0, 1.0));
  spec_3 = tmpvar_32;
  highp vec3 tmpvar_33;
  tmpvar_33 = (_LightColor.xyz * (tmpvar_29 * tmpvar_28));
  res_2.xyz = tmpvar_33;
  lowp vec3 c_34;
  c_34 = _LightColor.xyz;
  lowp float tmpvar_35;
  tmpvar_35 = dot (c_34, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_36;
  tmpvar_36 = (tmpvar_32 * tmpvar_35);
  res_2.w = tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_38;
  tmpvar_38 = (res_2 * tmpvar_37);
  res_2 = tmpvar_38;
  tmpvar_1 = tmpvar_38.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 359
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 361
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 364
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 366
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    #line 370
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 373
mediump vec4 CalculateLight( in v2f i ) {
    #line 375
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 379
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 383
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    #line 387
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    #line 391
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    #line 395
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    #line 399
    return res;
}
#line 401
lowp vec4 frag( in v2f i ) {
    #line 403
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump float tmpvar_23;
  highp vec4 packDist_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureCube (_ShadowMapTexture, tmpvar_18);
  packDist_24 = tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = dot (packDist_24, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp float tmpvar_27;
  if ((tmpvar_26 < tmpvar_22)) {
    tmpvar_27 = _LightShadowData.x;
  } else {
    tmpvar_27 = 1.0;
  };
  tmpvar_23 = tmpvar_27;
  highp vec4 tmpvar_28;
  tmpvar_28.w = 1.0;
  tmpvar_28.xyz = tmpvar_15;
  lowp vec4 tmpvar_29;
  highp vec3 P_30;
  P_30 = (_LightMatrix0 * tmpvar_28).xyz;
  tmpvar_29 = textureCube (_LightTexture0, P_30);
  highp float tmpvar_31;
  tmpvar_31 = ((atten_5 * tmpvar_23) * tmpvar_29.w);
  atten_5 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = (spec_3 * clamp (tmpvar_31, 0.0, 1.0));
  spec_3 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = (_LightColor.xyz * (tmpvar_32 * tmpvar_31));
  res_2.xyz = tmpvar_36;
  lowp vec3 c_37;
  c_37 = _LightColor.xyz;
  lowp float tmpvar_38;
  tmpvar_38 = dot (c_37, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_39;
  tmpvar_39 = (tmpvar_35 * tmpvar_38);
  res_2.w = tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_41;
  tmpvar_41 = (res_2 * tmpvar_40);
  res_2 = tmpvar_41;
  tmpvar_1 = tmpvar_41.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 359
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 361
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float dist = SampleCubeDistance( vec);
    return (( (dist < mydist) ) ? ( _LightShadowData.x ) : ( 1.0 ));
}
#line 364
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 366
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    #line 370
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 373
mediump vec4 CalculateLight( in v2f i ) {
    #line 375
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 379
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 383
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    #line 387
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    #line 391
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    #line 395
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 399
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 402
lowp vec4 frag( in v2f i ) {
    #line 404
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0);
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = tmpvar_15;
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_World2Shadow[0] * tmpvar_27);
  mediump vec4 shadows_29;
  highp vec4 shadowVals_30;
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_28.xyz / tmpvar_28.w);
  highp vec2 P_32;
  P_32 = (tmpvar_31.xy + _ShadowOffsets[0].xy);
  lowp float tmpvar_33;
  tmpvar_33 = texture2D (_ShadowMapTexture, P_32).x;
  shadowVals_30.x = tmpvar_33;
  highp vec2 P_34;
  P_34 = (tmpvar_31.xy + _ShadowOffsets[1].xy);
  lowp float tmpvar_35;
  tmpvar_35 = texture2D (_ShadowMapTexture, P_34).x;
  shadowVals_30.y = tmpvar_35;
  highp vec2 P_36;
  P_36 = (tmpvar_31.xy + _ShadowOffsets[2].xy);
  lowp float tmpvar_37;
  tmpvar_37 = texture2D (_ShadowMapTexture, P_36).x;
  shadowVals_30.z = tmpvar_37;
  highp vec2 P_38;
  P_38 = (tmpvar_31.xy + _ShadowOffsets[3].xy);
  lowp float tmpvar_39;
  tmpvar_39 = texture2D (_ShadowMapTexture, P_38).x;
  shadowVals_30.w = tmpvar_39;
  bvec4 tmpvar_40;
  tmpvar_40 = lessThan (shadowVals_30, tmpvar_31.zzzz);
  highp vec4 tmpvar_41;
  tmpvar_41 = _LightShadowData.xxxx;
  highp float tmpvar_42;
  if (tmpvar_40.x) {
    tmpvar_42 = tmpvar_41.x;
  } else {
    tmpvar_42 = 1.0;
  };
  highp float tmpvar_43;
  if (tmpvar_40.y) {
    tmpvar_43 = tmpvar_41.y;
  } else {
    tmpvar_43 = 1.0;
  };
  highp float tmpvar_44;
  if (tmpvar_40.z) {
    tmpvar_44 = tmpvar_41.z;
  } else {
    tmpvar_44 = 1.0;
  };
  highp float tmpvar_45;
  if (tmpvar_40.w) {
    tmpvar_45 = tmpvar_41.w;
  } else {
    tmpvar_45 = 1.0;
  };
  highp vec4 tmpvar_46;
  tmpvar_46.x = tmpvar_42;
  tmpvar_46.y = tmpvar_43;
  tmpvar_46.z = tmpvar_44;
  tmpvar_46.w = tmpvar_45;
  shadows_29 = tmpvar_46;
  mediump float tmpvar_47;
  tmpvar_47 = dot (shadows_29, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_48;
  tmpvar_48 = clamp ((tmpvar_47 + tmpvar_26), 0.0, 1.0);
  tmpvar_25 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_51;
  tmpvar_51 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_51;
  mediump float tmpvar_52;
  tmpvar_52 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = (spec_3 * clamp (tmpvar_49, 0.0, 1.0));
  spec_3 = tmpvar_53;
  highp vec3 tmpvar_54;
  tmpvar_54 = (_LightColor.xyz * (tmpvar_50 * tmpvar_49));
  res_2.xyz = tmpvar_54;
  lowp vec3 c_55;
  c_55 = _LightColor.xyz;
  lowp float tmpvar_56;
  tmpvar_56 = dot (c_55, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_57;
  tmpvar_57 = (tmpvar_53 * tmpvar_56);
  res_2.w = tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_59;
  tmpvar_59 = (res_2 * tmpvar_58);
  res_2 = tmpvar_59;
  tmpvar_1 = tmpvar_59.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 362
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 364
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 350
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 352
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    highp vec4 shadowVals;
    shadowVals.x = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[0].xy)).x;
    shadowVals.y = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[1].xy)).x;
    #line 356
    shadowVals.z = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[2].xy)).x;
    shadowVals.w = texture( _ShadowMapTexture, (vec2( coord) + _ShadowOffsets[3].xy)).x;
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, coord.zzzz), vec4( _LightShadowData.xxxx), vec4( 1.0));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 360
    return shadow;
}
#line 367
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 369
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 373
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 375
mediump vec4 CalculateLight( in v2f i ) {
    #line 377
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 381
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 385
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 389
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 393
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 397
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 401
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 406
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (_LightPos.xyz - tmpvar_15);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_18);
  lightDir_6 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_15;
  highp vec4 tmpvar_21;
  tmpvar_21 = (_LightMatrix0 * tmpvar_20);
  lowp float tmpvar_22;
  tmpvar_22 = texture2DProj (_LightTexture0, tmpvar_21).w;
  atten_5 = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2D (_LightTextureB0, vec2(tmpvar_23));
  atten_5 = ((atten_5 * float((tmpvar_21.w < 0.0))) * tmpvar_24.w);
  mediump float tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.w = 1.0;
  tmpvar_26.xyz = tmpvar_15;
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_World2Shadow[0] * tmpvar_26);
  mediump vec4 shadows_28;
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_27.xyz / tmpvar_27.w);
  highp vec3 coord_30;
  coord_30 = (tmpvar_29 + _ShadowOffsets[0].xyz);
  lowp float tmpvar_31;
  tmpvar_31 = shadow2DEXT (_ShadowMapTexture, coord_30);
  shadows_28.x = tmpvar_31;
  highp vec3 coord_32;
  coord_32 = (tmpvar_29 + _ShadowOffsets[1].xyz);
  lowp float tmpvar_33;
  tmpvar_33 = shadow2DEXT (_ShadowMapTexture, coord_32);
  shadows_28.y = tmpvar_33;
  highp vec3 coord_34;
  coord_34 = (tmpvar_29 + _ShadowOffsets[2].xyz);
  lowp float tmpvar_35;
  tmpvar_35 = shadow2DEXT (_ShadowMapTexture, coord_34);
  shadows_28.z = tmpvar_35;
  highp vec3 coord_36;
  coord_36 = (tmpvar_29 + _ShadowOffsets[3].xyz);
  lowp float tmpvar_37;
  tmpvar_37 = shadow2DEXT (_ShadowMapTexture, coord_36);
  shadows_28.w = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (_LightShadowData.xxxx + (shadows_28 * (1.0 - _LightShadowData.xxxx)));
  shadows_28 = tmpvar_38;
  mediump float tmpvar_39;
  tmpvar_39 = dot (shadows_28, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_40;
  tmpvar_40 = clamp ((tmpvar_39 + clamp (((tmpvar_17 * _LightShadowData.z) + _LightShadowData.w), 0.0, 1.0)), 0.0, 1.0);
  tmpvar_25 = tmpvar_40;
  highp float tmpvar_41;
  tmpvar_41 = (atten_5 * tmpvar_25);
  atten_5 = tmpvar_41;
  mediump float tmpvar_42;
  tmpvar_42 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_43;
  tmpvar_43 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = (spec_3 * clamp (tmpvar_41, 0.0, 1.0));
  spec_3 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (_LightColor.xyz * (tmpvar_42 * tmpvar_41));
  res_2.xyz = tmpvar_46;
  lowp vec3 c_47;
  c_47 = _LightColor.xyz;
  lowp float tmpvar_48;
  tmpvar_48 = dot (c_47, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_49;
  tmpvar_49 = (tmpvar_45 * tmpvar_48);
  res_2.w = tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_51;
  tmpvar_51 = (res_2 * tmpvar_50);
  res_2 = tmpvar_51;
  tmpvar_1 = tmpvar_51.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _ShadowOffsets[4];
#line 406
#line 362
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    #line 364
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 350
mediump float unitySampleShadow( in highp vec4 shadowCoord ) {
    #line 352
    highp vec3 coord = (shadowCoord.xyz / shadowCoord.w);
    mediump vec4 shadows;
    shadows.x = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[0])).xyz);
    shadows.y = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[1])).xyz);
    #line 356
    shadows.z = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[2])).xyz);
    shadows.w = xll_shadow2D( _ShadowMapTexture, (coord + vec3( _ShadowOffsets[3])).xyz);
    shadows = (_LightShadowData.xxxx + (shadows * (1.0 - _LightShadowData.xxxx)));
    mediump float shadow = dot( shadows, vec4( 0.25));
    #line 360
    return shadow;
}
#line 367
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    #line 369
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    highp vec4 shadowCoord = (unity_World2Shadow[0] * vec4( vec, 1.0));
    return xll_saturate_f((unitySampleShadow( shadowCoord) + fade));
    #line 373
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 375
mediump vec4 CalculateLight( in v2f i ) {
    #line 377
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    #line 381
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    #line 385
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    highp vec3 tolight = (_LightPos.xyz - wpos);
    mediump vec3 lightDir = normalize(tolight);
    #line 389
    highp vec4 uvCookie = (_LightMatrix0 * vec4( wpos, 1.0));
    highp float atten = textureProj( _LightTexture0, uvCookie).w;
    atten *= float((uvCookie.w < 0.0));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    #line 393
    atten *= texture( _LightTextureB0, vec2( att)).w;
    atten *= ComputeShadow( wpos, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 397
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 401
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 406
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump vec4 shadows_23;
  highp vec4 shadowVals_24;
  highp vec3 vec_25;
  vec_25 = (tmpvar_18 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureCube (_ShadowMapTexture, vec_25);
  packDist_26 = tmpvar_27;
  shadowVals_24.x = dot (packDist_26, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_28;
  vec_28 = (tmpvar_18 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureCube (_ShadowMapTexture, vec_28);
  packDist_29 = tmpvar_30;
  shadowVals_24.y = dot (packDist_29, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_31;
  vec_31 = (tmpvar_18 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureCube (_ShadowMapTexture, vec_31);
  packDist_32 = tmpvar_33;
  shadowVals_24.z = dot (packDist_32, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_34;
  vec_34 = (tmpvar_18 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = textureCube (_ShadowMapTexture, vec_34);
  packDist_35 = tmpvar_36;
  shadowVals_24.w = dot (packDist_35, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_37;
  tmpvar_37 = lessThan (shadowVals_24, vec4(tmpvar_22));
  highp vec4 tmpvar_38;
  tmpvar_38 = _LightShadowData.xxxx;
  highp float tmpvar_39;
  if (tmpvar_37.x) {
    tmpvar_39 = tmpvar_38.x;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_37.y) {
    tmpvar_40 = tmpvar_38.y;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_37.z) {
    tmpvar_41 = tmpvar_38.z;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_37.w) {
    tmpvar_42 = tmpvar_38.w;
  } else {
    tmpvar_42 = 1.0;
  };
  highp vec4 tmpvar_43;
  tmpvar_43.x = tmpvar_39;
  tmpvar_43.y = tmpvar_40;
  tmpvar_43.z = tmpvar_41;
  tmpvar_43.w = tmpvar_42;
  shadows_23 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  highp float tmpvar_45;
  tmpvar_45 = (atten_5 * tmpvar_44);
  atten_5 = tmpvar_45;
  mediump float tmpvar_46;
  tmpvar_46 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_47;
  mediump float tmpvar_48;
  tmpvar_48 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = (spec_3 * clamp (tmpvar_45, 0.0, 1.0));
  spec_3 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = (_LightColor.xyz * (tmpvar_46 * tmpvar_45));
  res_2.xyz = tmpvar_50;
  lowp vec3 c_51;
  c_51 = _LightColor.xyz;
  lowp float tmpvar_52;
  tmpvar_52 = dot (c_51, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_53;
  tmpvar_53 = (tmpvar_49 * tmpvar_52);
  res_2.w = tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_55;
  tmpvar_55 = (res_2 * tmpvar_54);
  res_2 = tmpvar_55;
  tmpvar_1 = tmpvar_55.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 407
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 407
#line 365
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    #line 360
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 370
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    #line 374
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 379
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 383
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 387
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 391
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 395
    atten *= ComputeShadow( tolight, fadeDist, uv);
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    #line 399
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    res.w = (spec * Luminance( _LightColor.xyz));
    #line 403
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 407
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp float _LightAsQuad;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = mix (((glstate_matrix_modelview0 * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0)), _glesNormal, vec3(_LightAsQuad));
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform samplerCube _ShadowMapTexture;
uniform samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform highp mat4 _LightMatrix0;
uniform highp mat4 _CameraToWorld;
uniform highp vec4 unity_LightmapFade;
uniform highp vec4 _LightColor;
uniform highp vec4 _LightPos;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _CameraNormalsTexture;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _LightShadowData;
uniform highp vec4 _LightPositionRange;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 _ProjectionParams;
uniform highp vec3 _WorldSpaceCameraPos;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 res_2;
  highp float spec_3;
  mediump vec3 h_4;
  highp float atten_5;
  mediump vec3 lightDir_6;
  highp float depth_7;
  mediump vec3 normal_8;
  mediump vec4 nspec_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_CameraNormalsTexture, tmpvar_10);
  nspec_9 = tmpvar_11;
  normal_8 = normalize(((nspec_9.xyz * 2.0) - 1.0));
  lowp float tmpvar_12;
  tmpvar_12 = texture2D (_CameraDepthTexture, tmpvar_10).x;
  depth_7 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = (1.0/(((_ZBufferParams.x * depth_7) + _ZBufferParams.y)));
  depth_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = ((xlv_TEXCOORD1 * (_ProjectionParams.z / xlv_TEXCOORD1.z)) * tmpvar_13);
  highp vec3 tmpvar_15;
  tmpvar_15 = (_CameraToWorld * tmpvar_14).xyz;
  highp vec3 p_16;
  p_16 = (tmpvar_15 - unity_ShadowFadeCenterAndType.xyz);
  highp float tmpvar_17;
  tmpvar_17 = mix (tmpvar_14.z, sqrt(dot (p_16, p_16)), unity_ShadowFadeCenterAndType.w);
  highp vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_15 - _LightPos.xyz);
  highp vec3 tmpvar_19;
  tmpvar_19 = -(normalize(tmpvar_18));
  lightDir_6 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = (dot (tmpvar_18, tmpvar_18) * _LightPos.w);
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(tmpvar_20)).w;
  atten_5 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = ((sqrt(dot (tmpvar_18, tmpvar_18)) * _LightPositionRange.w) * 0.97);
  mediump vec4 shadows_23;
  highp vec4 shadowVals_24;
  highp vec3 vec_25;
  vec_25 = (tmpvar_18 + vec3(0.0078125, 0.0078125, 0.0078125));
  highp vec4 packDist_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureCube (_ShadowMapTexture, vec_25);
  packDist_26 = tmpvar_27;
  shadowVals_24.x = dot (packDist_26, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_28;
  vec_28 = (tmpvar_18 + vec3(-0.0078125, -0.0078125, 0.0078125));
  highp vec4 packDist_29;
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureCube (_ShadowMapTexture, vec_28);
  packDist_29 = tmpvar_30;
  shadowVals_24.y = dot (packDist_29, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_31;
  vec_31 = (tmpvar_18 + vec3(-0.0078125, 0.0078125, -0.0078125));
  highp vec4 packDist_32;
  lowp vec4 tmpvar_33;
  tmpvar_33 = textureCube (_ShadowMapTexture, vec_31);
  packDist_32 = tmpvar_33;
  shadowVals_24.z = dot (packDist_32, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  highp vec3 vec_34;
  vec_34 = (tmpvar_18 + vec3(0.0078125, -0.0078125, -0.0078125));
  highp vec4 packDist_35;
  lowp vec4 tmpvar_36;
  tmpvar_36 = textureCube (_ShadowMapTexture, vec_34);
  packDist_35 = tmpvar_36;
  shadowVals_24.w = dot (packDist_35, vec4(1.0, 0.00392157, 1.53787e-05, 6.22737e-09));
  bvec4 tmpvar_37;
  tmpvar_37 = lessThan (shadowVals_24, vec4(tmpvar_22));
  highp vec4 tmpvar_38;
  tmpvar_38 = _LightShadowData.xxxx;
  highp float tmpvar_39;
  if (tmpvar_37.x) {
    tmpvar_39 = tmpvar_38.x;
  } else {
    tmpvar_39 = 1.0;
  };
  highp float tmpvar_40;
  if (tmpvar_37.y) {
    tmpvar_40 = tmpvar_38.y;
  } else {
    tmpvar_40 = 1.0;
  };
  highp float tmpvar_41;
  if (tmpvar_37.z) {
    tmpvar_41 = tmpvar_38.z;
  } else {
    tmpvar_41 = 1.0;
  };
  highp float tmpvar_42;
  if (tmpvar_37.w) {
    tmpvar_42 = tmpvar_38.w;
  } else {
    tmpvar_42 = 1.0;
  };
  highp vec4 tmpvar_43;
  tmpvar_43.x = tmpvar_39;
  tmpvar_43.y = tmpvar_40;
  tmpvar_43.z = tmpvar_41;
  tmpvar_43.w = tmpvar_42;
  shadows_23 = tmpvar_43;
  mediump float tmpvar_44;
  tmpvar_44 = dot (shadows_23, vec4(0.25, 0.25, 0.25, 0.25));
  highp vec4 tmpvar_45;
  tmpvar_45.w = 1.0;
  tmpvar_45.xyz = tmpvar_15;
  lowp vec4 tmpvar_46;
  highp vec3 P_47;
  P_47 = (_LightMatrix0 * tmpvar_45).xyz;
  tmpvar_46 = textureCube (_LightTexture0, P_47);
  highp float tmpvar_48;
  tmpvar_48 = ((atten_5 * tmpvar_44) * tmpvar_46.w);
  atten_5 = tmpvar_48;
  mediump float tmpvar_49;
  tmpvar_49 = max (0.0, dot (lightDir_6, normal_8));
  highp vec3 tmpvar_50;
  tmpvar_50 = normalize((lightDir_6 - normalize((tmpvar_15 - _WorldSpaceCameraPos))));
  h_4 = tmpvar_50;
  mediump float tmpvar_51;
  tmpvar_51 = pow (max (0.0, dot (h_4, normal_8)), (nspec_9.w * 128.0));
  spec_3 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = (spec_3 * clamp (tmpvar_48, 0.0, 1.0));
  spec_3 = tmpvar_52;
  highp vec3 tmpvar_53;
  tmpvar_53 = (_LightColor.xyz * (tmpvar_49 * tmpvar_48));
  res_2.xyz = tmpvar_53;
  lowp vec3 c_54;
  c_54 = _LightColor.xyz;
  lowp float tmpvar_55;
  tmpvar_55 = dot (c_54, vec3(0.22, 0.707, 0.071));
  highp float tmpvar_56;
  tmpvar_56 = (tmpvar_52 * tmpvar_55);
  res_2.w = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = clamp ((1.0 - ((tmpvar_17 * unity_LightmapFade.z) + unity_LightmapFade.w)), 0.0, 1.0);
  mediump vec4 tmpvar_58;
  tmpvar_58 = (res_2 * tmpvar_57);
  res_2 = tmpvar_58;
  tmpvar_1 = tmpvar_58.wxyz;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Normal _glesNormal
in vec3 _glesNormal;

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
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 408
#line 284
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 286
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 329
v2f vert( in appdata v ) {
    v2f o;
    #line 332
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.uv = ComputeScreenPos( o.pos);
    o.ray = ((glstate_matrix_modelview0 * v.vertex).xyz * vec3( -1.0, -1.0, 1.0));
    o.ray = mix( o.ray, v.normal, vec3( _LightAsQuad));
    #line 336
    return o;
}
out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f xl_retval;
    appdata xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.normal = vec3(gl_Normal);
    xl_retval = vert( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.uv);
    xlv_TEXCOORD1 = vec3(xl_retval.ray);
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
vec2 xll_vecTSel_vb2_vf2_vf2 (bvec2 a, vec2 b, vec2 c) {
  return vec2 (a.x ? b.x : c.x, a.y ? b.y : c.y);
}
vec3 xll_vecTSel_vb3_vf3_vf3 (bvec3 a, vec3 b, vec3 c) {
  return vec3 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z);
}
vec4 xll_vecTSel_vb4_vf4_vf4 (bvec4 a, vec4 b, vec4 c) {
  return vec4 (a.x ? b.x : c.x, a.y ? b.y : c.y, a.z ? b.z : c.z, a.w ? b.w : c.w);
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
#line 321
struct v2f {
    highp vec4 pos;
    highp vec4 uv;
    highp vec3 ray;
};
#line 315
struct appdata {
    highp vec4 vertex;
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
#line 328
uniform highp float _LightAsQuad;
uniform sampler2D _CameraNormalsTexture;
uniform sampler2D _CameraDepthTexture;
#line 340
uniform highp vec4 _LightDir;
uniform highp vec4 _LightPos;
uniform highp vec4 _LightColor;
uniform highp vec4 unity_LightmapFade;
#line 344
uniform highp mat4 _CameraToWorld;
uniform highp mat4 _LightMatrix0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
#line 348
uniform samplerCube _ShadowMapTexture;
#line 365
#line 370
#line 379
#line 408
#line 365
highp float ComputeFadeDistance( in highp vec3 wpos, in highp float z ) {
    highp float sphereDist = distance( wpos, unity_ShadowFadeCenterAndType.xyz);
    return mix( z, sphereDist, unity_ShadowFadeCenterAndType.w);
}
#line 215
highp float DecodeFloatRGBA( in highp vec4 enc ) {
    highp vec4 kDecodeDot = vec4( 1.0, 0.00392157, 1.53787e-05, 6.22737e-09);
    return dot( enc, kDecodeDot);
}
#line 349
highp float SampleCubeDistance( in highp vec3 vec ) {
    highp vec4 packDist = texture( _ShadowMapTexture, vec);
    #line 352
    return DecodeFloatRGBA( packDist);
}
#line 354
mediump float unitySampleShadow( in highp vec3 vec, in highp float mydist ) {
    #line 356
    highp float z = 0.0078125;
    highp vec4 shadowVals;
    shadowVals.x = SampleCubeDistance( (vec + vec3( z, z, z)));
    shadowVals.y = SampleCubeDistance( (vec + vec3( (-z), (-z), z)));
    #line 360
    shadowVals.z = SampleCubeDistance( (vec + vec3( (-z), z, (-z))));
    shadowVals.w = SampleCubeDistance( (vec + vec3( z, (-z), (-z))));
    mediump vec4 shadows = xll_vecTSel_vb4_vf4_vf4 (lessThan( shadowVals, vec4( mydist)), vec4( _LightShadowData.xxxx), vec4( 1.0));
    return dot( shadows, vec4( 0.25));
}
#line 370
mediump float ComputeShadow( in highp vec3 vec, in highp float fadeDist, in highp vec2 uv ) {
    highp float fade = ((fadeDist * _LightShadowData.z) + _LightShadowData.w);
    fade = xll_saturate_f(fade);
    #line 374
    highp float mydist = (length(vec) * _LightPositionRange.w);
    mydist *= 0.97;
    return unitySampleShadow( vec, mydist);
    return 1.0;
}
#line 276
highp float Linear01Depth( in highp float z ) {
    #line 278
    return (1.0 / ((_ZBufferParams.x * z) + _ZBufferParams.y));
}
#line 173
lowp float Luminance( in lowp vec3 c ) {
    #line 175
    return dot( c, vec3( 0.22, 0.707, 0.071));
}
#line 379
mediump vec4 CalculateLight( in v2f i ) {
    i.ray = (i.ray * (_ProjectionParams.z / i.ray.z));
    highp vec2 uv = (i.uv.xy / i.uv.w);
    #line 383
    mediump vec4 nspec = texture( _CameraNormalsTexture, uv);
    mediump vec3 normal = ((nspec.xyz * 2.0) - 1.0);
    normal = normalize(normal);
    highp float depth = texture( _CameraDepthTexture, uv).x;
    #line 387
    depth = Linear01Depth( depth);
    highp vec4 vpos = vec4( (i.ray * depth), 1.0);
    highp vec3 wpos = (_CameraToWorld * vpos).xyz;
    highp float fadeDist = ComputeFadeDistance( wpos, vpos.z);
    #line 391
    highp vec3 tolight = (wpos - _LightPos.xyz);
    mediump vec3 lightDir = (-normalize(tolight));
    highp float att = (dot( tolight, tolight) * _LightPos.w);
    highp float atten = texture( _LightTextureB0, vec2( att)).w;
    #line 395
    atten *= ComputeShadow( tolight, fadeDist, uv);
    atten *= texture( _LightTexture0, (_LightMatrix0 * vec4( wpos, 1.0)).xyz).w;
    mediump float diff = max( 0.0, dot( lightDir, normal));
    mediump vec3 h = normalize((lightDir - normalize((wpos - _WorldSpaceCameraPos))));
    #line 399
    highp float spec = pow( max( 0.0, dot( h, normal)), (nspec.w * 128.0));
    spec *= xll_saturate_f(atten);
    mediump vec4 res;
    res.xyz = (_LightColor.xyz * (diff * atten));
    #line 403
    res.w = (spec * Luminance( _LightColor.xyz));
    highp float fade = ((fadeDist * unity_LightmapFade.z) + unity_LightmapFade.w);
    res *= xll_saturate_f((1.0 - fade));
    return res;
}
#line 408
lowp vec4 frag( in v2f i ) {
    return CalculateLight( i).wxyz;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f xlt_i;
    xlt_i.pos = vec4(0.0);
    xlt_i.uv = vec4(xlv_TEXCOORD0);
    xlt_i.ray = vec3(xlv_TEXCOORD1);
    xl_retval = frag( xlt_i);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
"!!GLES3"
}
}
 }
}
Fallback Off
}