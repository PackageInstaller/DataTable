-- chunkname: @modules/logic/versionactivity1_3/astrology/define/VersionActivity1_3AstrologyEnum.lua

module("modules.logic.versionactivity1_3.astrology.define.VersionActivity1_3AstrologyEnum", package.seeall)

local VersionActivity1_3AstrologyEnum = _M

VersionActivity1_3AstrologyEnum.Planet = {
	muxing = 6,
	huoxing = 5,
	tuxing = 7,
	shuixing = 2,
	taiyang = 1,
	jinxing = 3,
	yueliang = 4
}
VersionActivity1_3AstrologyEnum.PlanetItem = {
	[VersionActivity1_3AstrologyEnum.Planet.shuixing] = 970004,
	[VersionActivity1_3AstrologyEnum.Planet.jinxing] = 970005,
	[VersionActivity1_3AstrologyEnum.Planet.yueliang] = 970006,
	[VersionActivity1_3AstrologyEnum.Planet.huoxing] = 970007,
	[VersionActivity1_3AstrologyEnum.Planet.muxing] = 970008,
	[VersionActivity1_3AstrologyEnum.Planet.tuxing] = 970009
}
VersionActivity1_3AstrologyEnum.TipPos = {
	{
		-130,
		280
	},
	{
		25,
		275
	},
	{
		-210,
		245
	}
}
VersionActivity1_3AstrologyEnum.PlanetOffsetX = -779
VersionActivity1_3AstrologyEnum.PlanetOffsetY = -152
VersionActivity1_3AstrologyEnum.Angle = 60
VersionActivity1_3AstrologyEnum.MaxStarNum = 10

return VersionActivity1_3AstrologyEnum
