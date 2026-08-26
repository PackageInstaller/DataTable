-- chunkname: @modules/logic/character/defines/CharacterDestinyEnum.lua

module("modules.logic.character.defines.CharacterDestinyEnum", package.seeall)

local CharacterDestinyEnum = _M

CharacterDestinyEnum.DestinyStoneOpenLevelConstId = {
	[4] = ConstEnum.UnlockDestinyHeroLevel5,
	[5] = ConstEnum.UnlockDestinyHeroLevel6
}
CharacterDestinyEnum.DestinyUpBaseAttr = {
	CharacterEnum.AttrId.HpBase,
	CharacterEnum.AttrId.AttackBase,
	CharacterEnum.AttrId.DefenseBase,
	CharacterEnum.AttrId.MdefenseBase
}
CharacterDestinyEnum.DestinyUpBaseAttrPercent = {
	CharacterEnum.AttrId.HpPercent,
	CharacterEnum.AttrId.AttackPercent,
	CharacterEnum.AttrId.DefensePercent,
	CharacterEnum.AttrId.MdefensePercent
}
CharacterDestinyEnum.DestinyUpSpecialAttr = {
	CharacterEnum.AttrId.ReboundDmg,
	CharacterEnum.AttrId.ExtraDmg,
	CharacterEnum.AttrId.ReuseDmg,
	CharacterEnum.AttrId.PoisonAddRate
}
CharacterDestinyEnum.DestinyUpBaseParseAttr = {
	[CharacterEnum.AttrId.Hp] = {
		CharacterEnum.AttrId.HpBase,
		CharacterEnum.AttrId.HpPercent
	},
	[CharacterEnum.AttrId.Attack] = {
		CharacterEnum.AttrId.AttackBase,
		CharacterEnum.AttrId.AttackPercent
	},
	[CharacterEnum.AttrId.Defense] = {
		CharacterEnum.AttrId.DefenseBase,
		CharacterEnum.AttrId.DefensePercent
	},
	[CharacterEnum.AttrId.Mdefense] = {
		CharacterEnum.AttrId.MdefenseBase,
		CharacterEnum.AttrId.MdefensePercent
	}
}
CharacterDestinyEnum.SlotTitle = {
	[1] = "character_destiny_slot_title_1",
	[6] = "character_destiny_slot_title_2"
}
CharacterDestinyEnum.EffectItemCount = 4
CharacterDestinyEnum.SlotViewAnim = {
	OpenUnlock = "open_unlock",
	Switch = "switch",
	LockIdle = "lock_idle",
	CloseUnlock = "close_unlock",
	OpenLock = "open_lock",
	Unlock = "unlock",
	CloseLock = "close_lock",
	LevelUp = "leveup",
	UnlockIdle = "unlock_idle"
}
CharacterDestinyEnum.StoneViewAnim = {
	SwitchLeft = "switch_left",
	Switch_reshape = "switch_reshape",
	Close = "close",
	LevelUp = "leveup",
	SwitchRight = "switch_right",
	Switch_normal = "switch_normal",
	Idle = "idle",
	Open = "open"
}
CharacterDestinyEnum.AnimEventName = {
	RefreshView = "RefreshView",
	UnlockAttrAnim = "UnlockAttrAnim",
	UnlockEnd = "UnlockEnd",
	LevelUpEnd = "LevelUpEnd"
}
CharacterDestinyEnum.SlotTend = {
	{
		TitleColor = "#ff938a",
		TitleIconName = "character_destiny_icon_1",
		RuneColor = Color(0.7450980392156863, 0.13725490196078433, 0.13725490196078433, 1)
	},
	{
		TitleColor = "#ffdf8a",
		TitleIconName = "character_destiny_icon_2",
		RuneColor = Color(0.8, 0.6980392156862745, 0.29411764705882354, 1)
	},
	{
		TitleColor = "#bedf9f",
		TitleIconName = "character_destiny_icon_3",
		RuneColor = Color(0.11764705882352941, 0.49019607843137253, 0.09803921568627451, 1)
	},
	{
		TitleColor = "#b5bfdf",
		TitleIconName = "character_destiny_icon_4",
		RuneColor = Color(0.2549019607843137, 0.4117647058823529, 0.7372549019607844, 1)
	},
	{
		TitleColor = "#aea0b4",
		TitleIconName = "character_destiny_icon_5",
		RuneColor = Color(0.4823529411764706, 0.32941176470588235, 0.5882352941176471, 1)
	}
}
CharacterDestinyEnum.RomanNum = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ",
	"Ⅶ",
	"Ⅷ",
	"Ⅸ"
}
CharacterDestinyEnum.StoneType = {
	Reshape = 1,
	Normal = 0
}

return CharacterDestinyEnum
