-- chunkname: @modules/logic/resonance/defines/HeroResonanceEnum.lua

module("modules.logic.resonance.defines.HeroResonanceEnum", package.seeall)

local HeroResonanceEnum = {}

HeroResonanceEnum.PutCube = 0
HeroResonanceEnum.GetCube = 1
HeroResonanceEnum.FromRabbet = 2
HeroResonanceEnum.FromBag = 3
HeroResonanceEnum.StyleCubeState = {
	Lock = 3,
	Select = 2,
	New = 5,
	Use = 4,
	Normal = 1
}
HeroResonanceEnum.QuickLayoutType = {
	{
		isNeedParam = true,
		name = "character_copy_talentLayout_copy_code"
	},
	{
		isNeedParam = true,
		name = "character_copy_talentLayout_use_code"
	},
	{
		isNeedParam = false,
		name = "character_copy_talentLayout_default"
	}
}
HeroResonanceEnum.AttrChange = {
	[0] = {
		NumColor = "#CAC8C5"
	},
	{
		ChangeImage = "character_style_up",
		NumColor = "#52AA64"
	},
	{
		ChangeImage = "character_style_down",
		NumColor = "#B95959"
	}
}

return HeroResonanceEnum
