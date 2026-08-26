-- chunkname: @modules/logic/character/defines/CharacterEnum.lua

module("modules.logic.character.defines.CharacterEnum", package.seeall)

local CharacterEnum = _M

CharacterEnum.VoiceType = {
	FightBehit = 6,
	Skill = 18,
	FightCardStar12 = 3,
	MainViewSpecialTouch = 12,
	EnterFight = 2,
	BreakThrough = 10,
	SpecialIdle1 = 20,
	LimitedEntrance = 22,
	HeroGroup = 1,
	MainViewNoInteraction = 16,
	MainViewDragSpecialRespond = 25,
	FightCardUnique = 5,
	Summon = 11,
	FightDie = 8,
	GetSkin = 9,
	SpecialIdle2 = 21,
	FightResult = 7,
	FightCardSkill3 = 27,
	MultiVoice = 26,
	MainViewSpecialInteraction = 23,
	WeatherChange = 14,
	MainViewNormalTouch = 13,
	GreetingInThumbnail = 19,
	FightCardStar3 = 4,
	MainViewSpecialRespond = 24,
	Greeting = 17,
	MainViewWelcome = 15
}
CharacterEnum.AttrDarkColor = GameUtil.parseColor("#736e6a")
CharacterEnum.AttrLightColor = GameUtil.parseColor("#efece6")
CharacterEnum.MaxSkillExLevel = 5
CharacterEnum.DrawingState = {
	Dynamic = 0,
	Static = 1
}
CharacterEnum.CharacterSwitchViewOffsetX = -108
CharacterEnum.SkinOpen = true
CharacterEnum.TalentOpen = false
CharacterEnum.Star = {
	2,
	3,
	4,
	5,
	6
}
CharacterEnum.Color = {
	2,
	3,
	4,
	5,
	6
}
CharacterEnum.LevelUpGuideId = 108
CharacterEnum.MaxRare = 5
CharacterEnum.CareerType = {
	Shou = 4,
	Zhi = 6,
	Ling = 5,
	Xing = 2,
	Mu = 3,
	Yan = 1
}
CharacterEnum.DamageType = {
	Real = 1,
	Spirit = 2
}
CharacterEnum.TalentRank = 2
CharacterEnum.showAttributeOption = {
	ShowCurrent = 0,
	ShowMax = 1,
	ShowMin = -1
}
CharacterEnum.CharacterDataItemType = {
	Culture = 3,
	Item = 2,
	Title = 1
}
CharacterEnum.CharacterDataUnLockType = {
	Faith = 1,
	TalentLevel = 5,
	RankLevel = 2,
	Level = 3,
	Episode = 6,
	SkillLevel = 4
}
CharacterEnum.SkinGainApproach = {
	Activity = 3,
	Store = 2,
	Rank = 1,
	BPReward = 4,
	Permanent = 5,
	Init = 0
}
CharacterEnum.FilterType = {
	HeroGroup = 2,
	BackpackHero = 1,
	AdventureCharacter = 4,
	SkinOffsetAdjust = 5,
	ShowCharacter = 3,
	CharVoiceSetting = 7,
	Survival = 8,
	WeekWalk = 6
}
CharacterEnum.AttrId = {
	Cri = 201,
	Absorb = 210,
	Recri = 202,
	DefenseIgnore = 213,
	Heal = 212,
	ReboundDmg = 218,
	Attack = 102,
	DefenseBase = 603,
	CriDmg = 203,
	MdefenseBase = 604,
	DropDmg = 206,
	HpBase = 601,
	Technic = 105,
	CriDef = 204,
	Mdefense = 104,
	Clutch = 211,
	MdefensePercent = 608,
	AttackBase = 602,
	Revive = 209,
	CurrentHp = 100,
	HpPercent = 605,
	ReuseDmg = 220,
	PoisonAddRate = 301,
	ExtraDmg = 219,
	DefensePercent = 607,
	PlayAddRate = 215,
	AddDmg = 205,
	PlayDropRate = 216,
	AttackPercent = 606,
	NormalSkillRate = 214,
	Hp = 101,
	LostHp = 99,
	Defense = 103
}
CharacterEnum.AttrIdToAttrName = {
	[CharacterEnum.AttrId.Hp] = "hp",
	[CharacterEnum.AttrId.Attack] = "atk",
	[CharacterEnum.AttrId.Defense] = "def",
	[CharacterEnum.AttrId.Mdefense] = "mdef",
	[CharacterEnum.AttrId.Technic] = "technic",
	[CharacterEnum.AttrId.Cri] = "cri",
	[CharacterEnum.AttrId.Recri] = "recri",
	[CharacterEnum.AttrId.CriDmg] = "cri_dmg",
	[CharacterEnum.AttrId.CriDef] = "cri_def",
	[CharacterEnum.AttrId.AddDmg] = "add_dmg",
	[CharacterEnum.AttrId.DropDmg] = "drop_dmg"
}
CharacterEnum.BaseAttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Mdefense,
	CharacterEnum.AttrId.Technic
}
CharacterEnum.UpAttrIdList = {
	CharacterEnum.AttrId.Cri,
	CharacterEnum.AttrId.Recri,
	CharacterEnum.AttrId.CriDmg,
	CharacterEnum.AttrId.CriDef,
	CharacterEnum.AttrId.AddDmg,
	CharacterEnum.AttrId.DropDmg,
	CharacterEnum.AttrId.NormalSkillRate,
	CharacterEnum.AttrId.Clutch,
	CharacterEnum.AttrId.Revive,
	CharacterEnum.AttrId.Absorb,
	CharacterEnum.AttrId.Heal,
	CharacterEnum.AttrId.DefenseIgnore
}
CharacterEnum.ShowSkinEnum = {
	Static = 1,
	Dynamic = 2
}
CharacterEnum.OpenSkinViewEnum = {
	SkinStore = 2,
	SkinTip = 3,
	Normal = 1
}
CharacterEnum.TalentTxtByHeroType = {
	"1",
	"1",
	"1",
	"1",
	"1",
	"6"
}
CharacterEnum.skillIndex = {
	Skill2 = 2,
	SkillEx = 3,
	Skill1 = 1
}
CharacterEnum.DefaultSkinId = {
	DuDuGu = 310401
}
CharacterEnum.StatType = {
	ALL = -1,
	NotStat = 1,
	Normal = 0
}

setmetatable(CharacterEnum.TalentTxtByHeroType, {
	__index = function(t, key)
		return "1"
	end
})

CharacterEnum.HumanHeroType = 6
CharacterEnum.DeviceViewType = {
	HeroGroupEditView = 2,
	CharacterView = 1
}
CharacterEnum.DeviceViewParam = {
	[CharacterEnum.DeviceViewType.CharacterView] = {
		OpenAniName = "characterview_open"
	},
	[CharacterEnum.DeviceViewType.HeroGroupEditView] = {
		OpenAniName = "herogroupeditview_open"
	}
}
CharacterEnum.SkinRare = {
	Common = 1,
	Garment = 3,
	Good = 2,
	Unique = 5,
	Advanced = 4,
	None = 0
}
CharacterEnum.TwinssychubeEquip = {
	1571,
	1572
}
CharacterEnum.TwinssychubeHeroId = 3149

return CharacterEnum
