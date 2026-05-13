// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'glstate_matrix_invtrans_modelview0' with 'UNITY_MATRIX_IT_MV'
// Upgrade NOTE: replaced 'glstate_matrix_mvp' with 'UNITY_MATRIX_MVP'

Shader "Custom/FlashAppear" 
{
    Properties
    {
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _FlashColor ("FlashColor", Color) = (1,1,1,1)
    }
    SubShader
    {
        LOD 200
        Tags { "QUEUE"="Transparent+1" }
        Pass
        {
            Name "LIGHT"
            Tags { "QUEUE"="Transparent+1" }
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            float4 _FlashColor;
            struct appdata_t
            {
                float3 normal : NORMAL;
                float4 vertex : POSITION;
            };
            struct v2f
            {
                float4 color : COLOR;
                float4 vertex : POSITION;
            };
            v2f vert(appdata_t v)
            {
                v2f o;
                float4 tmpvar_1;
                float4 tmpvar_2;
                tmpvar_2 = UnityObjectToClipPos(v.vertex);
                tmpvar_1.zw = tmpvar_2.zw;
                float4 tmpvar_3;
                tmpvar_3.w = 0.0;
                tmpvar_3.xyz = normalize(v.normal);
                tmpvar_1.xy = (tmpvar_2.xy + (((tmpvar_2.z * mul(UNITY_MATRIX_IT_MV, tmpvar_3)) * (1.0 - _FlashColor.w)) / 25.5).xy);
                o.vertex = tmpvar_1;
                o.color = _FlashColor;
                return o;
            }
            float4 frag(v2f i) : COLOR
            {
                return i.color;
            }
            ENDCG
        }
        Pass
        {
            Name "OBJ"
            Tags { "QUEUE"="Transparent+1" }
            Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            float4 _FlashColor;
            sampler2D _MainTex;
            struct appdata_t
            {
                float4 texcoord0 : TEXCOORD0;
                float4 vertex : POSITION;
            };
            struct v2f
            {
                float4 color : COLOR;
                float2 texcoord0 : TEXCOORD0;
                float4 vertex : POSITION;
            };
            v2f vert(appdata_t v)
            {
                v2f o;
                float2 tmpvar_1;
                float2 tmpvar_2;
                tmpvar_2 = v.texcoord0.xy;
                tmpvar_1 = tmpvar_2;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.texcoord0 = tmpvar_1;
                o.color = _FlashColor;
                return o;
            }
            float4 frag(v2f i) : COLOR
            {
                float4 color_1;
                float4 tmpvar_2;
                tmpvar_2 = tex2D (_MainTex, i.texcoord0);
                color_1.xyz = tmpvar_2.xyz;
                color_1.w = clamp ((1.1 - i.color.w), 0.0, 1.0);
                return color_1;
            }
            ENDCG
        }
    }
    Fallback "Diffuse"
}