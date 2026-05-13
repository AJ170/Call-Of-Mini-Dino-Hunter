Shader "Triniti/Particle/AA_COL_DO_1" {
    Properties {
        _Color ("Main Color", Color) = (0.5,0.5,0.5,0.5)
        _MainTex ("Particle Texture", 2D) = "white" {}
    }
    SubShader {
        Tags { "Queue" = "Transparent+1" }
        Pass {
            Tags { "Queue" = "Transparent+1" }
            ZWrite Off
            Cull Off
            Fog { Color (0,0,0,0) }
            Blend SrcAlpha One

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            fixed4 _Color;

            struct appdata {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                float4 color : COLOR;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                fixed4 col : COLOR;
            };

            v2f vert (appdata v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                o.col = v.color;
                return o;
            }

            fixed4 frag (v2f i) : COLOR {
                fixed4 tex = tex2D(_MainTex, i.uv);
                tex.a *= saturate(tex.r + tex.g + tex.b); // simulate RGB-to-alpha
                return tex * _Color * 2.0;
            }
            ENDCG
        }
    }

    SubShader {
        Tags { "Queue" = "Transparent+1" }
        Pass {
            Tags { "Queue" = "Transparent+1" }
            ZWrite Off
            Cull Off
            Fog { Color (0,0,0,0) }
            Blend SrcAlpha One
            SetTexture [_MainTex] { ConstantColor [_Color] combine constant * primary }
            SetTexture [_MainTex] { combine texture * previous double }
        }
    }

    Fallback Off
}
