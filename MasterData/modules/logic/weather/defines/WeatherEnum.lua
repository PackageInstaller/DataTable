-- chunkname: @modules/logic/weather/defines/WeatherEnum.lua

module("modules.logic.weather.defines.WeatherEnum", package.seeall)

local WeatherEnum = _M

WeatherEnum.WeatherEffectName = {
	"天气无",
	"阳光明媚",
	"小雨",
	"大雨",
	"暴风雨",
	"小雪",
	"大雪",
	"大雾",
	"白天烟花",
	"夜晚烟花",
	"夜晚闪电",
	"梅小雪",
	"梅大雪"
}
WeatherEnum.LightMode = {
	"During",
	"Overcast",
	"Dusk",
	"Night"
}
WeatherEnum.LightModeDuring = 1
WeatherEnum.LightModeOvercast = 2
WeatherEnum.LightModeDusk = 3
WeatherEnum.LightModeNight = 4
WeatherEnum.DayTimeFireworks = 9
WeatherEnum.NightTimeFireworks = 10
WeatherEnum.SpRainStorm = 11
WeatherEnum.EffectAudioTime = {
	[WeatherEnum.DayTimeFireworks] = 40,
	[WeatherEnum.NightTimeFireworks] = 40,
	[WeatherEnum.SpRainStorm] = 15
}
WeatherEnum.EffectPlayAudio = {
	[WeatherEnum.DayTimeFireworks] = 20250601,
	[WeatherEnum.NightTimeFireworks] = 20250601,
	[WeatherEnum.SpRainStorm] = 20305004
}
WeatherEnum.EffectStopAudio = {
	[WeatherEnum.DayTimeFireworks] = 20250602,
	[WeatherEnum.NightTimeFireworks] = 20250602,
	[WeatherEnum.SpRainStorm] = 20305005
}
WeatherEnum.EffectMode = {
	"Normal",
	"Sunny",
	"Light_Rain",
	"Heavy_Rain",
	"Heavy_Rainstorm",
	"Little_Snow",
	"Heavy_Snow",
	"Heavy_Fog",
	"Normal",
	"Normal",
	"Heavy_Rainstorm",
	"Little_Snow",
	"Heavy_Snow"
}
WeatherEnum.EffectAirColor = {
	{
		255,
		255,
		255,
		150
	},
	{
		47,
		112,
		212,
		94
	},
	{
		255,
		241,
		235,
		100
	},
	{
		0,
		103,
		255,
		148
	}
}
WeatherEnum.DoorLightColor = {
	{
		247,
		245,
		242,
		255
	},
	{
		184,
		186,
		188,
		255
	},
	{
		195,
		174,
		161,
		255
	},
	{
		148,
		160,
		186,
		255
	}
}
WeatherEnum.BloomFactor = 1
WeatherEnum.Percent = 1
WeatherEnum.BloomFactor2 = {
	0,
	0,
	0,
	0
}
WeatherEnum.Luminance = {
	0,
	0.223,
	0,
	0
}
WeatherEnum.FrameTintColor = {
	{
		1,
		1,
		1,
		0
	},
	{
		0.043,
		0.207,
		0.353,
		0.54
	},
	{
		0.235,
		0.196,
		0.203,
		0.54
	},
	{
		0.156,
		0.282,
		0.529,
		0.54
	}
}
WeatherEnum.FrameLumFactor = {
	0.5,
	0.77,
	0.77,
	0.77
}
WeatherEnum.HeroInFrameColor = {
	Color.New(0.74, 0.68, 0.59, 1),
	Color.New(0.51, 0.48, 0.45, 1),
	Color.New(0.44, 0.43, 0.39, 1),
	Color.New(0.41, 0.44, 0.5, 1)
}
WeatherEnum.HeroInFrameLumFactor = {
	0.25,
	0.5,
	0.5,
	0.5
}
WeatherEnum.HeroInSceneLumFactor = 0
WeatherEnum.Default = 0
WeatherEnum.Heavy_Rain = 4
WeatherEnum.Heavy_Rainstorm = 5
WeatherEnum.RainOn = {
	[WeatherEnum.Default] = 0,
	[WeatherEnum.Heavy_Rain] = 1,
	[WeatherEnum.Heavy_Rainstorm] = 1
}
WeatherEnum.RainValue = {
	[WeatherEnum.Default] = 0,
	[WeatherEnum.Heavy_Rain] = 1,
	[WeatherEnum.Heavy_Rainstorm] = 1
}
WeatherEnum.RainDistortionFactor = {
	[WeatherEnum.Default] = Vector4(0, 0, 0, 0),
	[WeatherEnum.Heavy_Rain] = Vector4(0, 1.3, 4.7, 0),
	[WeatherEnum.Heavy_Rainstorm] = Vector4(3, 1.3, 4.7, 0)
}
WeatherEnum.RainEmission = {
	[WeatherEnum.Default] = Vector4(0, 0, 0, 0),
	[WeatherEnum.Heavy_Rain] = Vector4(0, 3.5, 1.86, 0),
	[WeatherEnum.Heavy_Rainstorm] = Vector4(1.5, 3, 1.86, 0)
}
WeatherEnum.EffectTag = {
	Frame = "frame",
	EffectAirStartColor = "effectAirStartColor"
}

return WeatherEnum
