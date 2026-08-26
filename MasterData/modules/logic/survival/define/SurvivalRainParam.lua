-- chunkname: @modules/logic/survival/define/SurvivalRainParam.lua

module("modules.logic.survival.define.SurvivalRainParam", package.seeall)

local SurvivalRainParam = _M
local Shader = UnityEngine.Shader

SurvivalRainParam._SurvivalEdgeFlow = Shader.PropertyToID("_SurvivalEdgeFlow")
SurvivalRainParam._SurvialObjectParams = Shader.PropertyToID("_SurvialObjectParams")
SurvivalRainParam._SurvialEdgeMap = Shader.PropertyToID("_SurvialEdgeMap")
SurvivalRainParam._SurvialEdgeMapParams = Shader.PropertyToID("_SurvialEdgeMapParams")
SurvivalRainParam._SurvialEdgeColor1 = Shader.PropertyToID("_SurvialEdgeColor1")
SurvivalRainParam._SurvialEdgeColor2 = Shader.PropertyToID("_SurvialEdgeColor2")
SurvivalRainParam._SurvialEdgeSize = Shader.PropertyToID("_SurvialEdgeSize")
SurvivalRainParam._SurvivalRain_Background = Shader.PropertyToID("_SurvivalRain_Background")
SurvivalRainParam._SurvivalRain_Background_Params = Shader.PropertyToID("_SurvivalRain_Background_Params")
SurvivalRainParam._SurvivalRain_FlowMap = Shader.PropertyToID("_SurvivalRain_FlowMap")
SurvivalRainParam._SurvivalRain_FlowMap_Params = Shader.PropertyToID("_SurvivalRain_FlowMap_Params")
SurvivalRainParam._SurvivalRain_Obj_Color = Shader.PropertyToID("_SurvivalRain_Obj_Color")
SurvivalRainParam._SurvivalRain_Glitch_Params = Shader.PropertyToID("_SurvivalRain_Glitch_Params")
SurvivalRainParam._SurvivalRain_TextMap = Shader.PropertyToID("_SurvivalRain_TextMap")
SurvivalRainParam._SurvivalRain_TextMap_Params = Shader.PropertyToID("_SurvivalRain_TextMap_Params")
SurvivalRainParam._SurvivalRain_NoiseMap = Shader.PropertyToID("_SurvivalRain_NoiseMap")
SurvivalRainParam._SurvivalRain_NoiseMap_Params = Shader.PropertyToID("_SurvivalRain_NoiseMap_Params")
SurvivalRainParam._SurvivalRain_Main_Color = Shader.PropertyToID("_SurvivalRain_Main_Color")
SurvivalRainParam.ParamToShaderFunc = {
	[SurvivalRainParam._SurvivalEdgeFlow] = Shader.SetGlobalFloat,
	[SurvivalRainParam._SurvialObjectParams] = Shader.SetGlobalVector,
	[SurvivalRainParam._SurvialEdgeMap] = Shader.SetGlobalTexture,
	[SurvivalRainParam._SurvialEdgeMapParams] = Shader.SetGlobalVector,
	[SurvivalRainParam._SurvialEdgeColor1] = Shader.SetGlobalColor,
	[SurvivalRainParam._SurvialEdgeColor2] = Shader.SetGlobalColor,
	[SurvivalRainParam._SurvialEdgeSize] = Shader.SetGlobalFloat,
	[SurvivalRainParam._SurvivalRain_Background] = Shader.SetGlobalTexture,
	[SurvivalRainParam._SurvivalRain_Background_Params] = Shader.SetGlobalVector,
	[SurvivalRainParam._SurvivalRain_FlowMap] = Shader.SetGlobalTexture,
	[SurvivalRainParam._SurvivalRain_FlowMap_Params] = Shader.SetGlobalVector,
	[SurvivalRainParam._SurvivalRain_Obj_Color] = Shader.SetGlobalColor,
	[SurvivalRainParam._SurvivalRain_Glitch_Params] = Shader.SetGlobalVector,
	[SurvivalRainParam._SurvivalRain_TextMap] = Shader.SetGlobalTexture,
	[SurvivalRainParam._SurvivalRain_TextMap_Params] = Shader.SetGlobalVector,
	[SurvivalRainParam._SurvivalRain_NoiseMap] = Shader.SetGlobalTexture,
	[SurvivalRainParam._SurvivalRain_NoiseMap_Params] = Shader.SetGlobalVector,
	[SurvivalRainParam._SurvivalRain_Main_Color] = Shader.SetGlobalColor
}
SurvivalRainParam[SurvivalEnum.RainType.Rain1] = {
	KeyWord = "_SURVIAL_SCENE",
	[SurvivalRainParam._SurvivalEdgeFlow] = 0.08
}

local rain2v3 = Quaternion.Euler(2.951, 247.931, 226.092) * Vector3.forward

SurvivalRainParam[SurvivalEnum.RainType.Rain2] = {
	KeyWord = "_ENABLE_SURVIVAL_RAIN_DISTORTION",
	[SurvivalRainParam._SurvivalEdgeFlow] = 0,
	[SurvivalRainParam._SurvialObjectParams] = Vector4(rain2v3.x, rain2v3.y, rain2v3.z, 0.08),
	[SurvivalRainParam._SurvialEdgeMap] = "rain_edge02",
	[SurvivalRainParam._SurvialEdgeMapParams] = Vector4(1, 1, 0.1, 0.62),
	[SurvivalRainParam._SurvialEdgeColor1] = Color(0.459, 0.8862, 0.5693, 1),
	[SurvivalRainParam._SurvialEdgeColor2] = Color(0.1618, 0.2839, 0.518, 1),
	[SurvivalRainParam._SurvialEdgeSize] = 3.82,
	[SurvivalRainParam._SurvivalRain_Background] = "rain_bg2",
	[SurvivalRainParam._SurvivalRain_Background_Params] = Vector4(0.025, 0.1, 0, 0),
	[SurvivalRainParam._SurvivalRain_FlowMap] = "rain_bg2_flow",
	[SurvivalRainParam._SurvivalRain_FlowMap_Params] = Vector4(0.25, 1, 0.18, 0.1),
	[SurvivalRainParam._SurvivalRain_Obj_Color] = Color(0.52201, 0.6588, 0.4018, 0.3411)
}

local rain3v3 = Quaternion.Euler(1, 250, 250) * Vector3.forward

SurvivalRainParam[SurvivalEnum.RainType.Rain3] = {
	KeyWord = "_ENABLE_SURVIVAL_RAIN_GLITCH",
	[SurvivalRainParam._SurvivalEdgeFlow] = 0,
	[SurvivalRainParam._SurvialObjectParams] = Vector4(rain3v3.x, rain3v3.y, rain3v3.z, 0.08),
	[SurvivalRainParam._SurvialEdgeMap] = "rain_edge02",
	[SurvivalRainParam._SurvialEdgeMapParams] = Vector4(1, 1, 0.1, 0.62),
	[SurvivalRainParam._SurvialEdgeColor1] = Color(0.8862, 0.7725, 0.6431, 1),
	[SurvivalRainParam._SurvialEdgeColor2] = Color(0.2392, 0.3176, 0.4352, 1),
	[SurvivalRainParam._SurvialEdgeSize] = 3.82,
	[SurvivalRainParam._SurvivalRain_Background] = "rain_3_map",
	[SurvivalRainParam._SurvivalRain_Background_Params] = Vector4(10, 10, 0.2, 1),
	[SurvivalRainParam._SurvivalRain_Glitch_Params] = Vector4(0.5, 1000, 10, 10),
	[SurvivalRainParam._SurvivalRain_TextMap] = "rain_bg3",
	[SurvivalRainParam._SurvivalRain_TextMap_Params] = Vector4(8, 0.5, 0.2, 1.18),
	[SurvivalRainParam._SurvivalRain_NoiseMap] = "rain_3_noise",
	[SurvivalRainParam._SurvivalRain_NoiseMap_Params] = Vector4(10, 10, 1, 1),
	[SurvivalRainParam._SurvivalRain_Main_Color] = Color(0.7882, 0.3098, 1, 0.2274),
	[SurvivalRainParam._SurvivalRain_Obj_Color] = Color(0.2, 0.2509804, 0.3647059, 0.8)
}

return SurvivalRainParam
