Shader "Triniti/Character/COL_VL_AB" {
    Properties {
        _Color ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Main Texture (RGB)", 2D) = "white" {}
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows
        #pragma target 3.0

        sampler2D _MainTex;
        fixed4 _Color;

        struct Input {
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutputStandard o) {
            fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 finalColor = tex * _Color;

            o.Albedo = finalColor.rgb;
            o.Alpha = finalColor.a;
            o.Emission = finalColor.rgb * 1;
        }
        ENDCG
    }
    FallBack "Diffuse"
}