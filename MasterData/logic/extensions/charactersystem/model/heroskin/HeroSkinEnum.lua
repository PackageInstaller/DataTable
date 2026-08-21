-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/model/heroskin/HeroSkinEnum.lua

module("logic.extensions.charactersystem.model.heroskin.HeroSkinEnum", package.seeall)

local HeroSkinEnum = {}

HeroSkinEnum.SkinLabelType = {
	Appearance = 1,
	Effect = 2,
	Action = 4,
	Dubbing = 3
}
HeroSkinEnum.ShowType = {
	AllSkin = 2,
	SingleSkin = 1,
	ModelPreview = 3
}
HeroSkinEnum.DefaultSkin = 0

return HeroSkinEnum
