-- chunkname: @modules/logic/character/defines/CharacterBackpackEnum.lua

module("modules.logic.character.defines.CharacterBackpackEnum", package.seeall)

local CharacterBackpackEnum = _M

CharacterBackpackEnum.TagId = {
	CharacterFeaturesHigh = "4",
	Dmgs = "1",
	Core = "2",
	System = "3",
	CharacterFeaturesLow = "5"
}
CharacterBackpackEnum.LocalTags = {
	CharacterBackpackEnum.TagId.Core,
	CharacterBackpackEnum.TagId.System,
	CharacterBackpackEnum.TagId.CharacterFeaturesHigh
}
CharacterBackpackEnum.Tag10000 = "10000"
CharacterBackpackEnum.HiddenTags = {
	[CharacterBackpackEnum.Tag10000] = true
}
CharacterBackpackEnum.ShowMappingTags = {
	[CharacterBackpackEnum.Tag10000] = 61
}
CharacterBackpackEnum.CharacterSkillHideEffect = {
	[3146] = true
}
CharacterBackpackEnum.dmgItemCount = 2
CharacterBackpackEnum.destinyItemCount = 2
CharacterBackpackEnum.attrItemCount = 6

return CharacterBackpackEnum
