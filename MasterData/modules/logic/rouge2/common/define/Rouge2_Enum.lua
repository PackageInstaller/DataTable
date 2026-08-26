-- chunkname: @modules/logic/rouge2/common/define/Rouge2_Enum.lua

module("modules.logic.rouge2.common.define.Rouge2_Enum", package.seeall)

local Rouge2_Enum = _M

Rouge2_Enum.ResPath = {
	ActiveSkillAttrUpdateItem = "ui/viewres/rouge2/attribute/rouge2_activeskillattrupdateitem.prefab",
	BackpackPet = "ui/viewres/rouge2/backpack/rouge2_backpackpet.prefab",
	BackpackTalentView = "ui/viewres/rouge2/backpack/rouge2_backpacktalentview.prefab",
	ItemDescSpriteAb = "font/bmfont",
	ItemRefreshComp = "ui/viewres/rouge2/map/rouge2_itemrefreshcomp.prefab",
	ComBuffItem = "ui/viewres/rouge2/backpack/rouge2_commonbuffitem.prefab",
	SaveInfoActiveSkillComp = "ui/viewres/rouge2/bossbattle/rouge2_saveinfoactiveskillcomp.prefab",
	BackpackSkillView = "ui/viewres/rouge2/backpack/rouge2_backpackskillview.prefab",
	AttrSplitToolbar = "ui/viewres/rouge2/backpack/rouge2_attrsplittoolbar.prefab",
	AttributeMap = "ui/viewres/rouge2/rouge2_careerattributemap.prefab",
	BackpackFormulaItem = "ui/viewres/rouge2/backpack/rouge2_backpackformulaitem.prefab",
	BossBattleHeroGroup = "ui/viewres/rouge2/bossbattle/rouge2_bossbattle_herogroup.prefab",
	CareerAttrActiveItem = "ui/viewres/rouge2/rouge2_careerattributeactiveitem.prefab",
	BossBattleHeroGroupItem1 = "ui/viewres/rouge2/bossbattle/rouge2_bossbattle_herogroupitem1.prefab",
	CareerAttributeTips = "ui/viewres/rouge2/attribute/rouge2_careerattributetipsview.prefab",
	MapExploreChoiceItem = "ui/viewres/rouge2/map/rouge2_mapexplorechoiceitem.prefab",
	ItemDescModeSwitcher = "ui/viewres/rouge2/backpack/rouge2_itemdescmodeswitcher.prefab",
	MapChoiceItem = "ui/viewres/rouge2/map/rouge2_mapchoiceitem.prefab",
	ItemDescSprite = "font/bmfont/rouge2/rouge2_1.asset",
	BackpackSkillPanelView = "ui/viewres/rouge2/backpack/rouge2_backpackskillpanelview.prefab",
	CommonSkillIconItem = "ui/viewres/rouge2/backpack/rouge2_commonskilliconitem.prefab",
	ResultHeroItem = "ui/viewres/rouge2/result/rouge2_resultheroitem.prefab",
	RecommendSystemTips = "ui/viewres/rouge2/system/rouge2_teamrecommendtips.prefab",
	SaveInfoHeroGroupComp = "ui/viewres/rouge2/bossbattle/rouge2_saveinfoherogroupcomp.prefab",
	CommonSkillItem = "ui/viewres/rouge2/backpack/rouge2_commonskillitem.prefab",
	BackpackSkillShowItem = "ui/viewres/rouge2/backpack/rouge2_backpackskillshowitem.prefab",
	AttrToolBar = "ui/viewres/rouge2/attribute/rouge2_attributetoolbar.prefab",
	CoinView = "ui/viewres/rouge2/map/rouge2_mapcoinview.prefab",
	BuffDropItem = "ui/viewres/rouge2/map/rouge2_buffdropitem.prefab",
	DifficultyItem = "ui/viewres/rouge2/rouge2_difficultyitem.prefab",
	ChoiceCheckItem = "ui/viewres/rouge2/map/rouge2_mapchoicecheckitem.prefab",
	BossBattleHeroGroupItem2 = "ui/viewres/rouge2/bossbattle/rouge2_bossbattle_herogroupitem2.prefab",
	SaveInfoListItem = "ui/viewres/rouge2/bossbattle/rouge2_saveinfolistitem.prefab",
	ComRelicsItem = "ui/viewres/rouge2/backpack/rouge2_commonrelicsitem.prefab",
	BossBattleResultAssessIcon = "ui/viewres/rouge2/bossbattle/rouge2_bossbattleresultassessicon.prefab"
}
Rouge2_Enum.State = {
	Difficulty = 1,
	isEnd = 3,
	Start = 2,
	Empty = 0
}
Rouge2_Enum.PopType = {
	ViewName = 1,
	Func = 2
}
Rouge2_Enum.TweenFocusDifficultyDuration = 0.2
Rouge2_Enum.DifficultyPageNum = 2
Rouge2_Enum.TweenSwitchPageDuration = 1
Rouge2_Enum.MinSwitchPageOffset = 100
Rouge2_Enum.BackpackTabContainerId = 2
Rouge2_Enum.MaxActiveSkillNum = 3
Rouge2_Enum.EmptyActiveSkill = 0
Rouge2_Enum.BackpackBuffType = 0
Rouge2_Enum.SkillTipsUsage = {
	Default = 1,
	BackpackEditView_Right = 3,
	BackpackEditView_Left = 2
}
Rouge2_Enum.SkillTipsPos = {
	BackpackSkillEdit1 = Vector2(-340, -7),
	BackpackSkillEdit2 = Vector2(-340, -7)
}
Rouge2_Enum.AttributeData = {
	Server = 2,
	Config = 1,
	Custom = 3
}
Rouge2_Enum.OutSideConstId = {
	SettleScoreIcon = 116,
	CollectRotateParam = 121,
	AlchemySubMaterialCount = 115,
	RougeNewGuideStartTime = 122,
	TalentPointId = 102,
	TalentPointMaxCount = 103,
	ActivityUpdateVersion = 123,
	StoreFinalReward = 107,
	ActivityUpdateTips = 124
}
Rouge2_Enum.RewardGroupConstIdOffset = 116
Rouge2_Enum.ConstId = {
	AchievementJumpId = 51,
	DifficultyIndexDuration = 11,
	DifficultyIndexCount = 12
}
Rouge2_Enum.AttrMapUsage = {
	MapAttributeUpView = 3,
	BackpackCareerView = 2,
	CareerSelectView = 1
}
Rouge2_Enum.BagType = {
	Relics = 1,
	InVisibleRelics = 2,
	Buff = 3,
	AttrBuff = 5,
	ActiveSkill = 4
}
Rouge2_Enum.BagType2MoCls = {
	[Rouge2_Enum.BagType.Relics] = Rouge2_BagMO,
	[Rouge2_Enum.BagType.InVisibleRelics] = Rouge2_BagMO,
	[Rouge2_Enum.BagType.Buff] = Rouge2_BagMO,
	[Rouge2_Enum.BagType.ActiveSkill] = Rouge2_ActiveSkillBagMO,
	[Rouge2_Enum.BagType.AttrBuff] = Rouge2_BagMO
}
Rouge2_Enum.ItemType2DescHelper = {
	[Rouge2_Enum.BagType.Relics] = Rouge2_RelicsDescHelper,
	[Rouge2_Enum.BagType.InVisibleRelics] = Rouge2_RelicsDescHelper,
	[Rouge2_Enum.BagType.Buff] = Rouge2_BuffDescHelper,
	[Rouge2_Enum.BagType.ActiveSkill] = Rouge2_ActiveSkillDescHelper,
	[Rouge2_Enum.BagType.AttrBuff] = Rouge2_RelicsDescHelper
}
Rouge2_Enum.ItemDataType = {
	Server = 1,
	Unknow = 0,
	Clone = 3,
	Config = 2
}
Rouge2_Enum.ItemFilterType = {
	Attribute = 6,
	GreaterAndEqualRare = 4,
	GreaterRare = 3,
	EqualRare = 5,
	Unique = 7,
	Remove = 8,
	LessRare = 1,
	LessAndEqualRare = 2
}
Rouge2_Enum.ItemDescMode = {
	Simply = 1,
	Full = 2
}
Rouge2_Enum.ItemExpressionData = {
	LeaderAttr = 2,
	ItemAttr = 1,
	LeaderAttrSum = 3
}
Rouge2_Enum.ItemDescModeDataKey = {
	Default = 1,
	SkillAttrUpdate = 1,
	RelicsDrop = 1,
	AttrBuffDrop = 1,
	BackpackBuff = 1,
	SkillDrop = 1,
	BackpackSkill = 1,
	RelicsAbandon = 1,
	BackpackRelics = 1,
	BuffDrop = 1,
	BuffAbandon = 1
}
Rouge2_Enum.ItemStatus = {
	New = 1,
	Old = 0,
	SecNew = 2
}
Rouge2_Enum.RelicsDescType = {
	NarrativeDescOutside = 5,
	AttrBuffTips = 6,
	LevelUp = 4,
	NarrativeDesc = 3,
	UnlockDesc = 2,
	Desc = 1
}
Rouge2_Enum.RelicsDescParam = {
	LevelUp = "levelup",
	isTrigger = "isTrigger",
	Condition = "condition",
	Desc = "desc"
}
Rouge2_Enum.TalentType = {
	Common = 0
}
Rouge2_Enum.SkillEditItemLongPressTime = 0.5
Rouge2_Enum.BagItemTabId_All = 0
Rouge2_Enum.BagTabType = {
	Relics = 4,
	ActiveSkill = 2,
	Career = 1,
	Buff = 3
}
Rouge2_Enum.BagTabTypeNameLangId = {
	[Rouge2_Enum.BagTabType.Career] = "rouge2_backpacktabview_career",
	[Rouge2_Enum.BagTabType.ActiveSkill] = "rouge2_backpacktabview_skill",
	[Rouge2_Enum.BagTabType.Relics] = "rouge2_backpacktabview_relics",
	[Rouge2_Enum.BagTabType.Buff] = "rouge2_backpacktabview_buff"
}
Rouge2_Enum.BagTabTypeNameEn = {
	[Rouge2_Enum.BagTabType.Career] = "Character Profile",
	[Rouge2_Enum.BagTabType.ActiveSkill] = "Resonator",
	[Rouge2_Enum.BagTabType.Relics] = "Artefacts",
	[Rouge2_Enum.BagTabType.Buff] = "Harmonic"
}
Rouge2_Enum.BagTabType2Reddot = {
	[Rouge2_Enum.BagTabType.ActiveSkill] = RedDotEnum.DotNode.Rouge2ActiveSkillTab,
	[Rouge2_Enum.BagTabType.Relics] = RedDotEnum.DotNode.Rouge2RelicsTab,
	[Rouge2_Enum.BagTabType.Buff] = RedDotEnum.DotNode.Rouge2BuffTab
}
Rouge2_Enum.ItemType2Reddot = {
	[Rouge2_Enum.BagType.ActiveSkill] = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.ActiveSkill],
	[Rouge2_Enum.BagType.Relics] = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.Relics],
	[Rouge2_Enum.BagType.Buff] = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.Buff]
}
Rouge2_Enum.AttributeToolType = {
	Default = 1,
	Enter_Attr_Detail = 3,
	Enter_Skill_Detail = 6,
	Enter_Attr = 2,
	Attr_Detail = 4,
	Enter = 5,
	Skill_Detail = 7
}
Rouge2_Enum.AttrToolParam = {
	IsShowEmptySkill = 2,
	SelectSkillIndex = 1
}
Rouge2_Enum.AttrIconSuffix = {
	Big = "_1",
	CircleBg = "_5",
	Large = "_6",
	Tag = "_4",
	Circle = "_3",
	Small = "_2"
}
Rouge2_Enum.CareerIconSuffix = {
	Bag = "_1",
	Mini = "_3",
	Tab = "_2"
}
Rouge2_Enum.ItemRareIconType = {
	TagBg = 3,
	CircleBg = 4,
	Default = 0,
	CircleIcon = 5,
	Bg = 1,
	NameBg = 2
}
Rouge2_Enum.ItemIconType = {
	Default = "_1",
	Type2 = "_2"
}
Rouge2_Enum.SystemIconType = {
	Black = 0,
	White = 1
}
Rouge2_Enum.AttrSplitToolbarEventFlag = {
	Relics = 1,
	AbandonBuff = 4,
	Buff = 2,
	AbandonRelics = 3
}
Rouge2_Enum.BXSCareerId = 1
Rouge2_Enum.GuideView = {
	ActivityView = 1
}
Rouge2_Enum.BagTalentType = {
	Transform = 1,
	Hole = 3,
	Normal = 0
}
Rouge2_Enum.BagTalentType2Cls = {
	[Rouge2_Enum.BagTalentType.Normal] = Rouge2_BackpackTalentItem,
	[Rouge2_Enum.BagTalentType.Transform] = Rouge2_BackpackTalentItem,
	[Rouge2_Enum.BagTalentType.Hole] = Rouge2_BackpackSkillTalentItem
}
Rouge2_Enum.BagTalentStatus = {
	Lock = 1,
	Active = 4,
	UnlockNotActive = 2,
	UnlockCanActive = 3
}
Rouge2_Enum.BagTalentNotActiveReason = {
	LackTalentPoint = 3,
	NotPassCondition = 2,
	HasActive = 4,
	NotActivePreTalent = 1
}
Rouge2_Enum.ActiveSkillHoleStatus = {
	Lock = 1,
	Equip = 5,
	UnlockCanActive = 3,
	UnlockNotActive = 2,
	Empty = 4
}
Rouge2_Enum.BagTalentTreeEndWidth = 400
Rouge2_Enum.BagTalentLineTweenDuration = 0.001
Rouge2_Enum.PassiveSkillDescType = {
	Fight = 2,
	Explore = 3,
	Career = 1
}
Rouge2_Enum.PassiveSkillDescType2FieldName = {
	[Rouge2_Enum.PassiveSkillDescType.Career] = "effectDesc",
	[Rouge2_Enum.PassiveSkillDescType.Fight] = "desc",
	[Rouge2_Enum.PassiveSkillDescType.Explore] = "upDesc"
}
Rouge2_Enum.PassiveSkillDescType2LangId = {
	[Rouge2_Enum.PassiveSkillDescType.Career] = "rouge2_attributedetailview_skilldesctype_career",
	[Rouge2_Enum.PassiveSkillDescType.Fight] = "rouge2_attributedetailview_skilldesctype_fight",
	[Rouge2_Enum.PassiveSkillDescType.Explore] = "rouge2_attributedetailview_skilldesctype_explore"
}
Rouge2_Enum.UnselectTeamSystemId = 0
Rouge2_Enum.TeamRecommendTipType = {
	Default = 1,
	Single = 3,
	AttrBuffDrop = 6,
	HeroCard = 7,
	System = 4,
	MultiItemSystemTag = 9,
	Default_Layout = 2,
	ItemRecommend = 5,
	HeroGroupEdit = 8
}
Rouge2_Enum.TeamRecommendParam = {
	ItemId = 1,
	IsShowSystemIcon = 3,
	Pivot = 6,
	LayoutType = 4,
	Spacing = 9,
	Scale = 7,
	HeroId = 5,
	IsShowSystemName = 2,
	MinIconWidth = 8
}
Rouge2_Enum.AttrDetailTabGroupType = {
	Overview = 1,
	SkillList = 3,
	AttrList = 2
}
Rouge2_Enum.AttrDetailTabGroupCls = {
	[Rouge2_Enum.AttrDetailTabGroupType.Overview] = Rouge2_AttrDetailTabGroupBaseItem,
	[Rouge2_Enum.AttrDetailTabGroupType.AttrList] = Rouge2_AttrDetailAttrTabGroupItem,
	[Rouge2_Enum.AttrDetailTabGroupType.SkillList] = Rouge2_AttrDetailTabGroupBaseItem
}
Rouge2_Enum.AttrDetailTabGroupLangId = {
	[Rouge2_Enum.AttrDetailTabGroupType.Overview] = "rouge2_attributedetailview_dropoverview",
	[Rouge2_Enum.AttrDetailTabGroupType.AttrList] = "rouge2_attributedetailview_attroverview",
	[Rouge2_Enum.AttrDetailTabGroupType.SkillList] = "rouge2_attributedetailview_skilloverview"
}
Rouge2_Enum.AttrDropStatus = {
	HasGet = 3,
	CanGet = 2,
	Lock = 1
}
Rouge2_Enum.AttrDropArrowType = {
	Black = 2,
	White = 1
}
Rouge2_Enum.AttrDropArrowSpriteIndex = {
	[Rouge2_Enum.AttrDropArrowType.Black] = 6,
	[Rouge2_Enum.AttrDropArrowType.White] = 1
}
Rouge2_Enum.CommonSkillIconType = {
	Type_2 = 2,
	Type_1 = 1,
	Type_3 = 3,
	None = 0
}

return Rouge2_Enum
