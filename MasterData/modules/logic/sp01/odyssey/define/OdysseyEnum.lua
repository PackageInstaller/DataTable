-- chunkname: @modules/logic/sp01/odyssey/define/OdysseyEnum.lua

module("modules.logic.sp01.odyssey.define.OdysseyEnum", package.seeall)

local OdysseyEnum = _M

OdysseyEnum.SceneRootName = "OdysseyDungeonScene"
OdysseyEnum.DungeonMapCameraSize = 5
OdysseyEnum.DungeonMapLightUrl = "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab"
OdysseyEnum.DungeonMainElement = 1
OdysseyEnum.DungeonElementNeedFollow = 1
OdysseyEnum.ElementOptionNotFinish = 1
OdysseyEnum.NotOpenInteractWithGuideId = 130516
OdysseyEnum.IconFrameType = {
	Gold = 1,
	Silver = 2,
	None = 0
}
OdysseyEnum.ElementType = {
	Fight = 3,
	Dialog = 2,
	Option = 1
}
OdysseyEnum.ElementTypeRoot = {
	[OdysseyEnum.ElementType.Dialog] = "dialog",
	[OdysseyEnum.ElementType.Option] = "option",
	[OdysseyEnum.ElementType.Fight] = "fight"
}
OdysseyEnum.ElementAnimName = {
	Tips = "tips",
	Close = "close",
	Idle = "idle",
	Select = "select",
	Open = "open"
}
OdysseyEnum.ConditionType = {
	FinishOption = "finishOption",
	Time = "time",
	Item = "item",
	TalentType = "talentType",
	Finish = "finish",
	Level = "level",
	TalentNode = "talentNode",
	Empty = ""
}
OdysseyEnum.FightType = {
	Conquer = 5,
	Myth = 6,
	Elite = 2,
	Religion = 4,
	Mercenary = 3,
	Normal = 1
}
OdysseyEnum.RecommendOffset = -30
OdysseyEnum.CurrentOffset = -20
OdysseyEnum.ConstId = {
	MercenaryInitNum = 4,
	MainHeroEquipCount = 9,
	MercenaryLimitedNum = 5,
	EpicMercenarySuit = 14,
	MapSelectUrl = 17,
	NormalHeroEquipCount = 10,
	ReligionUnlock = 31,
	NormalMercenarySuit = 12,
	RareMercenarySuit = 13,
	ExpItemRare = 28,
	TrialHeroId = 2,
	TalentUnlockLevel = 30,
	MapSelectPos = 18,
	MainHeroId = 11,
	TalentItemRare = 29,
	MercenaryRecoverSpeed = 6,
	MercenaryUnlock = 3
}
OdysseyEnum.MercenaryType = {
	Epic = 3,
	Rare = 2,
	Normal = 1
}
OdysseyEnum.MercenaryTypeToSuit = {
	[OdysseyEnum.MercenaryType.Normal] = OdysseyEnum.ConstId.NormalMercenarySuit,
	[OdysseyEnum.MercenaryType.Rare] = OdysseyEnum.ConstId.RareMercenarySuit,
	[OdysseyEnum.MercenaryType.Epic] = OdysseyEnum.ConstId.EpicMercenarySuit
}
OdysseyEnum.MythRecord = {
	[0] = "",
	"B",
	"A",
	"S"
}
OdysseyEnum.FightElementTag = {
	Conquest = 7,
	NormalFight = 1,
	EpicMercenary = 5,
	NormalMercenary = 3,
	Religion = 6,
	RareMercenary = 4,
	EliteFight = 2,
	Myth = 8
}
OdysseyEnum.FightElementTagLang = {
	[OdysseyEnum.FightType.Normal] = {
		[0] = "odyssey_tag_fight"
	},
	[OdysseyEnum.FightType.Elite] = {
		[0] = "odyssey_tag_fight_elite"
	},
	[OdysseyEnum.FightType.Mercenary] = {
		"odyssey_tag_mercenary_normal",
		"odyssey_tag_mercenary_rare",
		"odyssey_tag_mercenary_epic"
	},
	[OdysseyEnum.FightType.Religion] = {
		[0] = "odyssey_tag_religion"
	},
	[OdysseyEnum.FightType.Conquer] = {
		[0] = "odyssey_tag_conquest"
	},
	[OdysseyEnum.FightType.Myth] = {
		[0] = "odyssey_tag_myth"
	}
}
OdysseyEnum.FightElementTagIcon = {
	[OdysseyEnum.FightType.Normal] = "odyssey_map_event_fight_6",
	[OdysseyEnum.FightType.Elite] = "odyssey_map_event_fight_5",
	[OdysseyEnum.FightType.Mercenary] = "odyssey_map_event_fight_2",
	[OdysseyEnum.FightType.Religion] = "odyssey_map_event_fight_3",
	[OdysseyEnum.FightType.Conquer] = "odyssey_map_event_fight_1",
	[OdysseyEnum.FightType.Myth] = "odyssey_map_event_fight_4"
}
OdysseyEnum.FightElementEnemyIcon = {
	[OdysseyEnum.FightType.Normal] = "odyssey_map_level6",
	[OdysseyEnum.FightType.Elite] = "odyssey_map_level3",
	[OdysseyEnum.FightType.Mercenary] = "odyssey_map_level2",
	[OdysseyEnum.FightType.Religion] = "odyssey_map_level4",
	[OdysseyEnum.FightType.Conquer] = "odyssey_map_level3",
	[OdysseyEnum.FightType.Myth] = "odyssey_map_level5"
}
OdysseyEnum.EquipTypeLang = {
	"odyssey_equip_normal",
	"odyssey_equip_rare",
	"odyssey_equip_epic",
	"odyssey_equip_legend"
}
OdysseyEnum.EquipRareColor = {
	"#59B388",
	"#80C2F0",
	"#FE8EFF",
	"#FFE490"
}
OdysseyEnum.BlockKey = {
	LoadingMapEffect = "OdysseyDungeonLoadingMapEffect",
	FocusNewElement = "OdysseyDungeonFocusNewElement"
}
OdysseyEnum.LocalSaveKey = {
	MythNew = "OdysseyMythNew",
	MapNew = "OdysseyMapNew",
	ReligionClue = "OdysseyReligionClue",
	FightLevelSuppress = "OdysseyFightElementLevelSuppress"
}
OdysseyEnum.ElementStatus = {
	Finish = 1,
	Normal = 0
}
OdysseyEnum.DungeonUISideType = {
	Bottom = 1,
	Right = 2
}
OdysseyEnum.ItemType = {
	Item = 1,
	Equip = 2
}
OdysseyEnum.RewardItemType = {
	Exp = "exp",
	Talent = "talent",
	Item = "item",
	OuterItem = "OuterItem"
}
OdysseyEnum.OuterItemRareColor = {
	1,
	1,
	2,
	3,
	4,
	4
}
OdysseyEnum.TalentType = {
	Worrior = 2,
	Hunter = 1,
	Assassin = 3
}
OdysseyEnum.TalentUnlockCondition = {
	TalentNode = "talentNode",
	TalentType = "talentType"
}
OdysseyEnum.MemberStatus = {
	Dead = 2,
	Expose = 1
}
OdysseyEnum.Reason = {
	MapUpdateExplore = 202,
	MapElementCreate = 203,
	TalentLevelUp = 401,
	CommonFightReward = 601,
	TalentNodeReset = 402,
	ReligionFightReward = 602,
	MapElementFinish = 204,
	ConquestFightReward = 604,
	MapUnlock = 201,
	MercenaryFightReward = 603,
	TalentAllReset = 403,
	LevelUp = 102,
	MythicFightReward = 605,
	ElementOptionReward = 205,
	GM = 101
}
OdysseyEnum.GetItemPushReason = {
	[OdysseyEnum.Reason.GM] = true,
	[OdysseyEnum.Reason.LevelUp] = true,
	[OdysseyEnum.Reason.ElementOptionReward] = true,
	[OdysseyEnum.Reason.CommonFightReward] = true,
	[OdysseyEnum.Reason.ReligionFightReward] = true,
	[OdysseyEnum.Reason.MercenaryFightReward] = true,
	[OdysseyEnum.Reason.ConquestFightReward] = true,
	[OdysseyEnum.Reason.MythicFightReward] = true
}
OdysseyEnum.HeroGroupType = {
	Fight = 2,
	Prepare = 1
}
OdysseyEnum.MaxHeroGroupCount = 5
OdysseyEnum.TaskGroupType = {
	Fight = 3000,
	Collect = 4000,
	Story = 2000,
	LevelReward = 1000,
	Myth = 5000
}
OdysseyEnum.NormalTaskGroupType = {
	[OdysseyEnum.TaskGroupType.Story] = 1,
	[OdysseyEnum.TaskGroupType.Fight] = 2,
	[OdysseyEnum.TaskGroupType.Collect] = 3,
	[OdysseyEnum.TaskGroupType.Myth] = 4
}
OdysseyEnum.NormalTaskGroupTypeLang = {
	[OdysseyEnum.TaskGroupType.Story] = "odyssey_task_tab_1",
	[OdysseyEnum.TaskGroupType.Fight] = "odyssey_task_tab_2",
	[OdysseyEnum.TaskGroupType.Collect] = "odyssey_task_tab_3",
	[OdysseyEnum.TaskGroupType.Myth] = "odyssey_task_tab_4"
}
OdysseyEnum.TaskType = {
	LevelReward = 1,
	NormalTask = 2
}
OdysseyEnum.RareToConst = {
	24,
	25,
	26,
	27
}
OdysseyEnum.BagType = {
	FightPrepare = 1,
	Bag = 2,
	OnlyDisplay = 3
}
OdysseyEnum.TaskBigRewardType = 0
OdysseyEnum.Result = {
	Win = 1,
	Lose = 0
}
OdysseyEnum.JumpType = {
	JumpToLibrary = 7,
	JumpToHeroPos = 3,
	JumpToReligion = 4,
	JumpToMyth = 5,
	JumpToElementAndOpen = 2,
	JumpToLevelReward = 6,
	JumpToMainElement = 1
}
OdysseyEnum.SuitDescColor = {
	Active = "#B8B3A2"
}
OdysseyEnum.ResultRewardType = {
	Exp = 2,
	Talent = 3,
	Item = 1
}
OdysseyEnum.EquipOptionType = {
	Unload = 2,
	Equip = 1,
	Replace = 3
}
OdysseyEnum.EquipSuitType = {
	All = 1,
	SingleType = 2
}
OdysseyEnum.HeroGroupSaveType = {
	ItemUnload = 3,
	FormUpdate = 4,
	ItemReplace = 2,
	ItemEquip = 1
}
OdysseyEnum.EquipDefaultIndex = 1

return OdysseyEnum
