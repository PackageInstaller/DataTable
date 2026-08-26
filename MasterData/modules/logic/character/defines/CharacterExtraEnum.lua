-- chunkname: @modules/logic/character/defines/CharacterExtraEnum.lua

module("modules.logic.character.defines.CharacterExtraEnum", package.seeall)

local CharacterExtraEnum = _M

CharacterExtraEnum.TalentSkillSubCount = 3
CharacterExtraEnum.TalentSkillTreeNodeCount = 3
CharacterExtraEnum.UnlockTalentPointCountConst = 52
CharacterExtraEnum.SkillTreeNodeStatus = {
	Light = 3,
	Lock = 2,
	Normal = 1
}
CharacterExtraEnum.SkillTreeAnimName = {
	Click = "click",
	OpenTip = "open",
	Lock = "lock",
	OpenNomal = "open_nomal",
	OpenBottom = "open_bottom",
	CloseTip = "close",
	Bottom = "bottom",
	Normal = "normal"
}
CharacterExtraEnum.EffectCellHeight = 136
CharacterExtraEnum.EffectCellSpace = 26
CharacterExtraEnum.WeaponType = {
	Second = 2,
	First = 1
}
CharacterExtraEnum.WeaponStatus = {
	Equip = 3,
	Lock = 2,
	Normal = 1
}
CharacterExtraEnum.WeaponParams = {
	[CharacterExtraEnum.WeaponType.First] = {
		RankupShow = "character_rankup_system_2",
		UnlockConst = 53
	},
	[CharacterExtraEnum.WeaponType.Second] = {
		RankupShow = "character_rankup_system_3",
		UnlockConst = 54
	}
}
CharacterExtraEnum.WeaponTypeReddot = "CharacterExtraEnum_WeaponTypeReddot"
CharacterExtraEnum.WeaponReddot = "CharacterExtraEnum_WeaponReddot"
CharacterExtraEnum.WeaponAnimName = {
	Switch = "switch",
	Idle = "idle",
	Unlock = "unlock"
}

return CharacterExtraEnum
