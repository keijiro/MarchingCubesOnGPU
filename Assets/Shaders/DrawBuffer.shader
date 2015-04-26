﻿
Shader "Custom/DrawBuffer" 
{
	SubShader 
	{
		Pass 
		{
			Cull back

			CGPROGRAM
			#include "UnityCG.cginc"
			#pragma target 5.0
			#pragma vertex vert
			#pragma fragment frag
			
			struct Vert
			{
				float4 position;
				float3 normal;
			};

			uniform StructuredBuffer<Vert> _Buffer;
			int _IdOffset;

			struct v2f 
			{
				float4  pos : SV_POSITION;
				float3 col : Color;
			};

			v2f vert(appdata_base v)
			{
				Vert vert = _Buffer[v.texcoord.x + _IdOffset];

				v2f OUT;
				OUT.pos = mul(UNITY_MATRIX_MVP, float4(vert.position.xyz, 1));

				OUT.col = dot(float3(0, 1, 0), vert.normal) * 0.5 + 0.5;

				return OUT;
			}

			/*
			v2f vert(uint id : SV_VertexID)
			{
				Vert vert = _Buffer[id];

				v2f OUT;
				OUT.pos = mul(UNITY_MATRIX_MVP, float4(vert.position.xyz, 1));
				
				OUT.col = dot(float3(0,1,0), vert.normal) * 0.5 + 0.5;
				
				return OUT;
			}
			*/

			float4 frag(v2f IN) : COLOR
			{
				return float4(IN.col,1);
			}

			ENDCG

		}
	}
}