Shader "Triniti/Scene/COL_LM" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("MainTex", 2D) = "" {}
 _LightMap ("Lightmap (RGB)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Geometry" }
 Pass {
  Tags { "QUEUE"="Geometry" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "texcoord", TexCoord0
   Bind "texcoord1", TexCoord1
  }
  Fog { Mode Off }
  SetTexture [_MainTex] { ConstantColor [_Color] combine texture * constant }
  SetTexture [_LightMap] { combine texture * previous }
 }
}
}