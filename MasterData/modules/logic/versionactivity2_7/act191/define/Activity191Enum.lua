-- chunkname: @modules/logic/versionactivity2_7/act191/define/Activity191Enum.lua

module("modules.logic.versionactivity2_7.act191.define.Activity191Enum", package.seeall)

local Activity191Enum = _M

Activity191Enum.MaxItemLevel = 4
Activity191Enum.NodeType = {
	playerBattle9 = 28,
	MonsterBattle11 = 25,
	playerBattle6 = 19,
	MonsterBattle2 = 9,
	MonsterBattle8 = 22,
	AfterGlowShop = 32,
	MonsterBattle7 = 21,
	CollectionShop = 3,
	MonsterBattle10 = 24,
	MonsterBattle3 = 10,
	MonsterBattle1 = 8,
	playerBattle2 = 12,
	MonsterBattle5 = 15,
	playerBattle1 = 11,
	playerBattle8 = 27,
	playerBattle7 = 20,
	MixStore = 1,
	playerBattle11 = 30,
	playerBattle3 = 13,
	BattleEvent = 6,
	MonsterBattle12 = 26,
	MonsterBattle6 = 16,
	playerBattle10 = 29,
	RoleShop = 2,
	playerBattle5 = 18,
	Enhance = 7,
	MonsterBattle4 = 14,
	playerBattle12 = 31,
	ReplaceEvent = 101,
	UpgradeEvent = 102,
	RewardEvent = 5,
	playerBattle4 = 17,
	MonsterBattle9 = 23,
	TagShop = 4
}
Activity191Enum.NodeType2Key = {}

for k, v in pairs(Activity191Enum.NodeType) do
	Activity191Enum.NodeType2Key[v] = k
end

Activity191Enum.EffectType = {
	ItemByItem = 7,
	HeroByTag = 3,
	AddSubTeamSlot = 26,
	ItemByTag = 6,
	AttrEffect = 19,
	Item = 5,
	EnhanceItem = 9,
	HeroByHero = 4,
	Hero = 2,
	DelayEffect = 10,
	EnhanceHero = 8,
	TeamPosExtraFetter = 33,
	HeroRandomUp = 30,
	HeroExtraFetter = 18,
	Money = 1,
	CountEffects = 11,
	TeamExtraFetter = 27
}
Activity191Enum.EffectGetHero = {
	Activity191Enum.EffectType.Hero,
	Activity191Enum.EffectType.HeroByHero,
	Activity191Enum.EffectType.HeroByTag,
	Activity191Enum.EffectType.HeroRandomUp
}
Activity191Enum.EffectGetItem = {
	Activity191Enum.EffectType.Item,
	Activity191Enum.EffectType.ItemByItem,
	Activity191Enum.EffectType.ItemByTag
}
Activity191Enum.PveFiled = {
	8,
	9,
	10,
	14,
	15,
	16,
	21,
	22,
	23,
	24,
	25,
	26
}
Activity191Enum.PvpFiled = {
	11,
	12,
	13,
	17,
	18,
	19,
	20,
	27,
	28,
	29,
	30,
	31
}
Activity191Enum.ShopFiled = {
	Activity191Enum.NodeType.MixStore,
	Activity191Enum.NodeType.RoleShop,
	Activity191Enum.NodeType.CollectionShop,
	Activity191Enum.NodeType.TagShop,
	Activity191Enum.NodeType.AfterGlowShop
}
Activity191Enum.AttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Mdefense
}
Activity191Enum.GameState = {
	Normal = 1,
	End = -1,
	None = 0
}
Activity191Enum.ConstKey = {
	EnhanceTitle = 8,
	CollectionTag = 11,
	PvpEpisodeName = 18,
	PlayerMaxScore = 7,
	EnhanceDesc = 9,
	ReplaceTitle = 42,
	ReplaceTag = 40,
	FightSpeed = 27,
	UpgradeDesc = 45,
	ShopFreshCost = 1,
	TagShopFreshCost = 28,
	PvpBattleEpisodeId = 6,
	ReplaceMaxCnt = 38,
	RoleTag = 10,
	ReplaceDesc = 44,
	MaxFreshNum = 13,
	CharacterUpExp = 4,
	FetterTag = 12,
	TagShopFreshLimit = 29,
	UpgradeTitle = 43,
	UpgradeMaxCnt = 39,
	UpgradeTag = 41
}
Activity191Enum.CharacterType = {
	Monster = "monster",
	Hero = "hero"
}
Activity191Enum.CollectionColor = {
	"587FA1",
	"8D6993",
	"B8945F",
	"BD5900"
}
Activity191Enum.CharacterMaxStar = 6
Activity191Enum.SortRule = {
	Down = 2,
	Up = 1
}
Activity191Enum.HyperLinkPattern = {
	EnhanceDestiny = "「(.-)」",
	Hero = "《(.-)》",
	SkillDesc = "﹝(.-)﹞",
	EnhanceItem = "『(.-)』"
}
Activity191Enum.PrefabPath = {
	HeroHeadItem = "ui/viewres/versionactivity_2_7/act191/item/act191heroheaditem.prefab",
	FetterItem = "ui/viewres/versionactivity_2_7/act191/item/act191fetteritem.prefab",
	CollectionItem = "ui/viewres/versionactivity_2_7/act191/item/act191collectionitem.prefab",
	NodeListItem = "ui/viewres/versionactivity_2_7/act191/item/act191nodelistitem.prefab",
	BossHpItem = "ui/viewres/fight/fight_act191bosshpview.prefab",
	HeroEditItem = "ui/viewres/versionactivity_2_7/act191/item/act191heroedititem.prefab",
	TeamComp = "ui/viewres/versionactivity_2_7/act191/item/act191teamitem.prefab",
	RewardItem = "ui/viewres/versionactivity_2_7/act191/item/act191rewarditem.prefab"
}
Activity191Enum.InitBuildType = {
	Random = 2,
	Extra = 3,
	Normal = 1
}
Activity191Enum.SummonType = {
	Monster = 2,
	Boss = 1
}
Activity191Enum.BadgeState = {
	Sp = 3,
	Light = 2,
	Normal = 1
}
Activity191Enum.BaseTeamSlot = {
	Sub = 4,
	Main = 4
}
Activity191Enum.GreenDeer = "greenDeer"
Activity191Enum.GreenDeerSkillIds = {
	118380112,
	118380116
}
Activity191Enum.ActiveBossType = {
	Remodeling = 1,
	RelationPerson = 2
}

return Activity191Enum
