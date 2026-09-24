-- chunkname: @modules/logic/handbook/define/HandbookEnum.lua

module("modules.logic.handbook.define.HandbookEnum", package.seeall)

local HandbookEnum = _M

HandbookEnum.Type = {
	Character = 3,
	Story = 1,
	CG = 2,
	Equip = 4
}
HandbookEnum.HeroType = {
	Common = 1,
	AllHero = 99
}
HandbookEnum.CGType = {
	Role = 2,
	Rouge = 3,
	Dungeon = 1
}
HandbookEnum.BookBGRes = {
	[HandbookEnum.HeroType.Common] = {
		left = "peper_06",
		right = "peper_05"
	},
	[HandbookEnum.HeroType.AllHero] = {
		left = "img_tujian_bg_zuo",
		right = "img_tujian_bg_you"
	}
}
HandbookEnum.SkinSceneAsset = {
	"ui/animations/dynamic/skinbook_camerar.controller",
	"scenes/v2a8_m_s17_pftj/prefab/skin_sence_01.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10002.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10003.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10004.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10005.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10006.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10007.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10009.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10001.prefab",
	"scenes/v3a0_m_s17_pftj/prefab/sence_10010.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_12001.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/sence_10008.prefab",
	"scenes/v3a3_m_s17_pftj/prefab/sence_13001.prefab",
	"scenes/v2a8_m_s17_pftj/prefab/v3a9_m_s17_ui_new.prefab",
	"ui/viewres/skinhandbook/vx_skintaro_unlock.prefab",
	"scenes/v4a0_m_s17_pftj/prefab/sence_14001.prefab",
	"ui/viewres/skinhandbook/vx_skinsevenvirtues_unlock.prefab"
}
HandbookEnum.SkinSuitSceneType = {
	Festival = 3,
	Seven = 4,
	Tarot = 2,
	Normal = 1
}
HandbookEnum.SubScene = {
	[HandbookEnum.SkinSuitSceneType.Seven] = true
}
HandbookEnum.SkinUnlockVxPath = {
	Static = "ui/viewres/skinhandbook/vx_skin_unlock.prefab",
	Seven = "ui/viewres/skinhandbook/vx_skinsevenvirtues_unlock.prefab",
	Tarot = "ui/viewres/skinhandbook/vx_skintaro_unlock.prefab",
	Spine = "ui/viewres/skinhandbook/vx_skinspine_unlock.prefab"
}
HandbookEnum.SkinUnlockState = {
	HaveRead = 0,
	NotRead = 1
}
HandbookEnum.SkinUnlockAnimName = {
	Loop = "loop",
	Idle = "idle",
	Open = "open"
}
HandbookEnum.SkinSuitId2SceneType = {
	[11001] = HandbookEnum.SkinSuitSceneType.Tarot,
	[13001] = HandbookEnum.SkinSuitSceneType.Festival,
	[14001] = HandbookEnum.SkinSuitSceneType.Seven
}
HandbookEnum.SkinSpAnimEnum = {
	[310003] = true
}
HandbookEnum.SkinSp2AnimEnum = {
	[315503] = true
}
HandbookEnum.SkinSuitEnum = {
	Festival = 11001
}
HandbookEnum.SkinSuitLowEnum = {
	Festival = 21002,
	OldStories = 20015
}
HandbookEnum.HideRootSuit = {
	[HandbookEnum.SkinSuitLowEnum.OldStories] = true
}
HandbookEnum.SkinSuitGroupDefaultScene = "scenes/v2a8_m_s17_pftj/prefab/skin_sence_01.prefab"
HandbookEnum.SkinSuitRedDotPath = "scenes/v2a8_m_s17_pftj/prefab/v3a9_m_s17_ui_new.prefab"
HandbookEnum.TarotSkinDefaultCardPath = "singlebg/skinhandbook_singlebg/tarot/card00.png"
HandbookEnum.TarotSkinCount = 21
HandbookEnum.TarotCardCount = 5
HandbookEnum.TarotSkinCardDir = "singlebg/skinhandbook_singlebg/tarot"
HandbookEnum.TarotDefaultFOV = 22
HandbookEnum.SevenSkinDefaultCardPath = "singlebg/skinhandbook_singlebg/sevenvirtues/card00.png"
HandbookEnum.SevenSkinCount = 7
HandbookEnum.SevenCardCount = 5
HandbookEnum.SevenSkinCardDir = "singlebg/skinhandbook_singlebg/sevenvirtues"
HandbookEnum.HandbookSkinShowRedDotMap = {
	[10001] = true,
	[13001] = true,
	[11001] = true
}
HandbookEnum.Color = {
	Lock = "#808080",
	Unlock = "#FFFFFF"
}
HandbookEnum.Audio = {
	play_ui_activity_hero37_checkpoint_gather = 390009,
	play_ui_tujianskin_special_unlock = 390010,
	ui_tujianskin_qimeide_open = 400175
}
HandbookEnum.CharacterType = {
	MixedBlood = 4,
	InfectedPerson = 5,
	SupernaturalBeing = 1,
	Occultist = 3,
	Cryptozoology = 8,
	Unknown = 7,
	Awake = 2,
	Human = 6
}
HandbookEnum.CharacterTypeList = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8
}
HandbookEnum.CharacterCareerList = {
	1,
	2,
	3,
	4,
	5,
	6
}
HandbookEnum.PageCharacterNum = 8
HandbookEnum.PageCareerNum = 6

return HandbookEnum
