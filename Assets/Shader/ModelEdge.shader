Shader "Triniti/Model/ModelEdge" {
    Properties {
        _MainTex ("Texture (RGB)", 2D) = "black" {}
        _Color ("Color", Color) = (1,1,1,1)
        _AtmoColor ("Atmosphere Color", Color) = (0.5,0.5,1,1)
    }
    
    SubShader {
        Tags { "RenderType"="Opaque" }

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata_t {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _Color;
            float4 _AtmoColor;

            v2f vert (appdata_t v) {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : COLOR {
                float4 texColor = tex2D(_MainTex, i.uv);
                return texColor * _Color; 
            }
            ENDCG
        }
    }
}
