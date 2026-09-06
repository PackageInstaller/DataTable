-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/constdef/GameEnum.lua

module("logiccommon.common.constdef.GameEnum", package.seeall)

local GameEnum = {}

GameEnum.VERSION_ANDROID_20240513 = 799
GameEnum.VERSION_IOS_20240513 = 799
GameEnum.VERSION_ANDROID_20241017 = 840
GameEnum.FootStep = {
	ROAD = 0,
	WATER = 3,
	SNOW = 4,
	SAND = 2,
	WOOD = 5,
	BARRIER = 6,
	GRASS = 1
}
GameEnum.Gender = {
	Female = 0,
	Neutral = 2,
	Male = 1
}
GameEnum.SkinGender = {
	Female = 1,
	Male = 2
}
GameEnum.SkinGenderFemale = "女"
GameEnum.SkinGenderMale = "男"
GameEnum.SkinGenderId = {
	[GameEnum.SkinGenderMale] = GameEnum.SkinGender.Male,
	[GameEnum.SkinGenderFemale] = GameEnum.SkinGender.Female
}
GameEnum.FormationGenderFemale = "女性"
GameEnum.FormationGenderMale = "男性"
GameEnum.FormationGenderId = {
	[GameEnum.FormationGenderMale] = GameEnum.SkinGender.Male,
	[GameEnum.FormationGenderFemale] = GameEnum.SkinGender.Female
}
GameEnum.RoleCV = {
	Female = {
		9999801,
		9999802,
		9999803
	},
	Male = {
		9999901,
		9999902,
		9999903
	}
}
GameEnum.TopType = {
	SUM = 1,
	BUDDY = 2
}
GameEnum.ResCopyType = {
	Coin = 2,
	Stargod = 3,
	Exp = 1,
	Equip = 4
}
GameEnum.SkipType = {
	VIP_SKIP = 2,
	VIP_FIRST_SKIP = 3,
	UNABLE_SKIP = 0,
	UNABLE_SKIP_FORCED = 4,
	NORMAL_SKIP = 1
}
GameEnum.DisconnectFlag_SkipHandler = -1
GameEnum.DisconnectFlag_Net = 1
GameEnum.DisconnectFlag_GetLostFail = 2
GameEnum.DisconnectFlag_RepeatLogin = 3
GameEnum.DisconnectFlag_IdleTimeout = 4
GameEnum.DisconnectFlag_Kickout = 5
GameEnum.DisconnectFlag_ServerShutdown = 6
GameEnum.DisconnectFlag_ReLoginFail = 7
GameEnum.DisconnectFlag_ServerMaintain = 8
GameEnum.DisconnectFlag_LogoutSuccess = 9
GameEnum.DisconnectFlag_LoginRateLimit = 10
GameEnum.DisconnectFlag_ServerFull = 11
GameEnum.DisconnectFlag_ServerNotInService = 12
GameEnum.DisconnectFlag_AccountNoExisted = 13
GameEnum.DisconnectFlag_AccountLoginTimeout = 14
GameEnum.DisconnectFlag_NoOperationTimeout = 15
GameEnum.DisconnectFlag_DataWritingBack = 16
GameEnum.DisconnectFlag_LoginingOnOtherDevice = 17
GameEnum.DisconnectFlag_LoginingServerHot = 18
GameEnum.DisconnectFlag_LoginingMaxRegisterCount = 19
GameEnum.DisconnectFlag_NetBlock = 20
GameEnum.DisconnectFlag_ServerNotWorkingThisTime = 21
GameEnum.DisconnectFlag_Anti_Error = 22
GameEnum.DisconnectFlag_Qudao_Del_Role = 23
GameEnum.BattleRecordEntry = {
	BountyPkCompete = 6,
	Scuffle = 4,
	Arena = 2,
	Challenge = 1,
	RankRace = 3,
	CampScuffle = 5
}
GameEnum.TaskViewTab = {
	Guide = 5,
	Branch = 4,
	Achievement = 7,
	Main = 3,
	TimeLimit = 6,
	Daily = 1,
	Weekly = 2
}
GameEnum.TaskType = {
	ColorfulEggs = 5,
	Branch = 2,
	Count = 6,
	Main = 1,
	Festival = 6,
	Daily = 4,
	Guide = 3
}
GameEnum.NpcTaskState = {
	Accepted = 2,
	TaskGoing = 3,
	Commited = 4,
	None = 1
}
GameEnum.Tag = {
	Special = 2,
	Normal = 1
}
GameEnum.AttrType = {
	AttackPhysical = 2,
	DodgeRate = 10,
	AttackSuperRate = 22,
	HpRate = 17,
	DefenseSuperRate = 23,
	AntiCriticalRate = 14,
	AttackMagicRate = 20,
	DefenseMagic = 5,
	AttackRate = 25,
	Attack = 15,
	DefenseSuper = 7,
	CriticalRate = 13,
	SpeedRate = 24,
	DefensePhysical = 3,
	BlockRate = 12,
	OriginalVigour = 16,
	HitRate = 9,
	AttackPhysicalRate = 18,
	AttackMagic = 4,
	AttackSuper = 6,
	Hp = 1,
	DefensePhysicalRate = 19,
	Speed = 8,
	DefenseMagicRate = 21,
	StrikeRate = 11
}
GameEnum.AttrTypeName = {
	"生命",
	"物攻",
	"物防",
	"魔攻",
	"魔防",
	"超攻",
	"超防",
	"速度",
	"命中率",
	"闪避率",
	"破击率",
	"格挡率",
	"暴击率",
	"防暴率",
	"攻击",
	"起始气势",
	"生命率",
	"物攻率",
	"物防率",
	"魔攻率",
	"魔防率",
	"超攻率",
	"超防率",
	"速度率",
	"攻击率"
}
GameEnum.ItemAttrNormal = {
	[GameEnum.AttrType.Hp] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.AttackPhysical] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.DefensePhysical] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.AttackMagic] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.DefenseMagic] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.AttackSuper] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.DefenseSuper] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.Speed] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.HitRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.DodgeRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.StrikeRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.BlockRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.CriticalRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.AntiCriticalRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.HpRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.AttackPhysicalRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.DefensePhysicalRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.AttackMagicRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.DefenseMagicRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.AttackSuperRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.DefenseSuperRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.SpeedRate] = {
		kind = 2,
		symbol = 1
	},
	[GameEnum.AttrType.Attack] = {
		kind = 1,
		symbol = 1
	},
	[GameEnum.AttrType.OriginalVigour] = {
		kind = 1,
		symbol = 1
	}
}
GameEnum.SeverSkillType = {
	PSYCHICED_ULTIMATE = 5,
	PASSIVE = 3,
	PSYCHICED_NORMAL = 4,
	ULTIMATE = 2,
	NORMAL = 1
}
GameEnum.SkillRaceType = {
	ShenShiSkill = 16,
	AwakenSkill = 13,
	Element = 12,
	TianjueSkill = 18,
	Domain = 8,
	PsychicSkillNormal = 10,
	JuanYouSkill = 15,
	SourceTraceSkill = 19,
	Passive = 1,
	GenesisSkill = 20,
	Contract = 7,
	BookSpiritSkill = 21,
	SpiritInvocationSkill = 22,
	Hero = 4,
	Summon = 5,
	Normal = 2,
	Combine = 6,
	PsychicSkillUtl = 11,
	BenyuanSkill = 17,
	PsychicSkill = 9,
	ShenYaoSkill = 14,
	Ult = 3
}
GameEnum.SkillRaceTypeExt = {
	Normal_Phy = 101,
	Normal_Mag = 102
}
GameEnum.SkillNameToType = {
	神使技 = 16,
	元素技 = 12,
	普攻 = 2,
	被动 = 1,
	觉醒技 = 13,
	吞噬技 = 21,
	召唤技 = 5,
	超杀 = 3,
	契约技 = 7,
	["通灵-超杀"] = 11,
	眷佑技 = 15,
	唤灵技 = 22,
	合体技 = 6,
	创世技 = 20,
	["通灵-普攻"] = 10,
	天觉技 = 18,
	英雄技 = 4,
	本源技 = 17,
	源迹技 = 19,
	领域技 = 8,
	神曜技 = 14,
	通灵技 = 9
}
GameEnum.SkillNameToTypeExt = {
	魔攻 = 102,
	物攻 = 101
}
GameEnum.CONSTANT_TYPE = "常量"
GameEnum.RATE_TYPE = "比例"
GameEnum.LESS_THAN = "小于"
GameEnum.LESS_THAN_OR_EQUAL_TO = "小于等于"
GameEnum.EQUAL_TO = "等于"
GameEnum.NOT_EQUAL_TO = "不等于"
GameEnum.GREATER_THAN_OR_EQUAL_TO = "大于等于"
GameEnum.GREATER_THAN = "大于"
GameEnum.FormationType = {
	PhyDef = 3,
	UltAtk = 4,
	MagAtk = 8,
	HitRate = 7,
	Crit = 5,
	Dodge = 6,
	PhyAtk = 2,
	Block = 1
}
GameEnum.TargetType = {
	Enemy = 2,
	Friend = 1
}
GameEnum.MountPointType = {
	Head = 1,
	Foot = 3,
	Count = 4,
	Front = 4,
	Center = 2
}
GameEnum.SkillType = {
	Domain = "领域技",
	Utl = "超杀",
	Combine = "合体技",
	PsychicSkillUtl = "通灵-超杀",
	Passive = "被动",
	PsychicSkillNormal = "通灵-普攻",
	ShenyaoSkill = "神曜技",
	SourceTraceSkill = "源迹技",
	PsychicSkill = "通灵技",
	GenesisSkill = "创世技",
	SpiritInvocationSkill = "唤灵技",
	SourceSkill = "本源技",
	Hero = "英雄技",
	Normal = "普攻"
}
GameEnum.ActionModel = {
	UserAction_Catch = 2,
	UserAction_Skill = 3,
	NoneAction = 1
}
GameEnum.SkillExecuteState = {
	PhysicalSkillDisable = -5,
	LongRangeSkillDisable = -3,
	SkillDisable = -1,
	MeleeSkillDisable = -2,
	DamageSkillDisable = -7,
	WaterAndBlackDisable = -10,
	HealSkillDisable = -8,
	MagicSkillDisable = -4,
	BuffOnlySkillDisable = -9,
	UltimateSkillDisable = -6,
	CanExecute = 1
}
GameEnum.SkillFuncType = {
	Treat = "治疗",
	Summon = "召唤",
	Hurt = "伤害",
	BuffOnly = "BuffOnly"
}
GameEnum.SkillPowerType = {
	AttackPhysical = "物攻",
	AttackSuper = "超攻",
	Summon = "召唤",
	AttackMagic = "魔攻"
}
GameEnum.BuffHurtOriginType = {
	Rebound = "反弹",
	Null = "null",
	Frozen = "冻伤",
	Burn = "烧伤",
	Poison = "中毒"
}
GameEnum.BuffTextType = {
	超攻 = 3,
	格挡 = 1,
	受伤加深 = 11,
	暴击 = 0,
	攻击 = 17,
	生命 = 14,
	防爆 = 4,
	魔防 = 6,
	受伤减少 = 18,
	魔攻 = 15,
	物防 = 12,
	伤害 = 16,
	气势 = 8,
	破击 = 7,
	物攻 = 13,
	全属性 = 9,
	闪避 = 10,
	超防 = 2,
	命中 = 5
}
GameEnum.BulletTargetType = {
	TARGET_OBJECT = 1,
	TARGET_POS = 2
}
GameEnum.BulletTrackType = {
	CatmullRom_Parabola = 3,
	CatmullRom_Random = 2,
	Line_Random_StartPos = 4,
	Line = 1
}
GameEnum.BattleLayer = {
	Effect = 0,
	Map = 100
}
GameEnum.CareerType = {
	Pingheng = 5,
	Tianjue = 31,
	JiSu = 1,
	Yingxiong = 21,
	ZhiLiao = 6,
	Psychic = 28,
	Zhaohuanshi = 22,
	Yuanguchong = 24,
	SourceTrace = 32,
	Shenqi = 27,
	SpiritInvocation = 33,
	Dun = 4,
	Mowangkexing = 23,
	Mofa = 2,
	Yuanshou = 25,
	Element = 29,
	LiZhua = 3,
	ShenYao = 30,
	Mowang = 26
}
GameEnum.JobZhDefine = {
	Pingheng = "平衡",
	Tianjue = "天觉者",
	JiSu = "疾速",
	Yingxiong = "英雄",
	ZhiLiao = "治疗",
	Psychic = "通灵师",
	Zhaohuanshi = "召唤师",
	Yuanguchong = "远古宠",
	SourceTrace = "源起",
	Shenqi = "神启",
	SpiritInvocation = "唤灵师",
	Dun = "肉盾",
	Mowangkexing = "魔王克星",
	Mofa = "魔法",
	Yuanshou = "源兽",
	Element = "元素师",
	LiZhua = "利爪",
	ShenYao = "神曜",
	Mowang = "魔王"
}
GameEnum.JobTxt = {
	[GameEnum.CareerType.JiSu] = GameEnum.JobZhDefine.JiSu,
	[GameEnum.CareerType.Mofa] = GameEnum.JobZhDefine.Mofa,
	[GameEnum.CareerType.LiZhua] = GameEnum.JobZhDefine.LiZhua,
	[GameEnum.CareerType.Dun] = GameEnum.JobZhDefine.Dun,
	[GameEnum.CareerType.Pingheng] = GameEnum.JobZhDefine.Pingheng,
	[GameEnum.CareerType.ZhiLiao] = GameEnum.JobZhDefine.ZhiLiao,
	[GameEnum.CareerType.Yingxiong] = GameEnum.JobZhDefine.Yingxiong,
	[GameEnum.CareerType.Zhaohuanshi] = GameEnum.JobZhDefine.Zhaohuanshi,
	[GameEnum.CareerType.Mowangkexing] = GameEnum.JobZhDefine.Mowangkexing,
	[GameEnum.CareerType.Yuanguchong] = GameEnum.JobZhDefine.Yuanguchong,
	[GameEnum.CareerType.Yuanshou] = GameEnum.JobZhDefine.Yuanshou,
	[GameEnum.CareerType.Mowang] = GameEnum.JobZhDefine.Mowang,
	[GameEnum.CareerType.Shenqi] = GameEnum.JobZhDefine.Shenqi,
	[GameEnum.CareerType.Psychic] = GameEnum.JobZhDefine.Psychic,
	[GameEnum.CareerType.Element] = GameEnum.JobZhDefine.Element,
	[GameEnum.CareerType.ShenYao] = GameEnum.JobZhDefine.ShenYao,
	[GameEnum.CareerType.Tianjue] = GameEnum.JobZhDefine.Tianjue,
	[GameEnum.CareerType.SourceTrace] = GameEnum.JobZhDefine.SourceTrace,
	[GameEnum.CareerType.SpiritInvocation] = GameEnum.JobZhDefine.SpiritInvocation
}
GameEnum.JobZh = {
	[GameEnum.JobZhDefine.JiSu] = GameEnum.CareerType.JiSu,
	[GameEnum.JobZhDefine.Mofa] = GameEnum.CareerType.Mofa,
	[GameEnum.JobZhDefine.LiZhua] = GameEnum.CareerType.LiZhua,
	[GameEnum.JobZhDefine.Dun] = GameEnum.CareerType.Dun,
	[GameEnum.JobZhDefine.Pingheng] = GameEnum.CareerType.Pingheng,
	[GameEnum.JobZhDefine.ZhiLiao] = GameEnum.CareerType.ZhiLiao,
	[GameEnum.JobZhDefine.Yingxiong] = GameEnum.CareerType.Yingxiong,
	[GameEnum.JobZhDefine.Zhaohuanshi] = GameEnum.CareerType.Zhaohuanshi,
	[GameEnum.JobZhDefine.Mowangkexing] = GameEnum.CareerType.Mowangkexing,
	[GameEnum.JobZhDefine.Yuanguchong] = GameEnum.CareerType.Yuanguchong,
	[GameEnum.JobZhDefine.Yuanshou] = GameEnum.CareerType.Yuanshou,
	[GameEnum.JobZhDefine.Mowang] = GameEnum.CareerType.Mowang,
	[GameEnum.JobZhDefine.Shenqi] = GameEnum.CareerType.Shenqi,
	[GameEnum.JobZhDefine.Psychic] = GameEnum.CareerType.Psychic,
	[GameEnum.JobZhDefine.Element] = GameEnum.CareerType.Element,
	[GameEnum.JobZhDefine.ShenYao] = GameEnum.CareerType.ShenYao,
	[GameEnum.JobZhDefine.Tianjue] = GameEnum.CareerType.Tianjue,
	[GameEnum.JobZhDefine.SourceTrace] = GameEnum.CareerType.SourceTrace,
	[GameEnum.JobZhDefine.SpiritInvocation] = GameEnum.CareerType.SpiritInvocation
}
GameEnum.RaceType = {
	ShenKong = 16,
	ShenCao = 11,
	ShenHuo = 13,
	Chuang = 7,
	Guang = 4,
	ShenAn = 15,
	Kong = 6,
	ShenYuan = 18,
	ShenShui = 12,
	Shui = 2,
	Huo = 3,
	Yuan = 8,
	ShenChuang = 17,
	An = 5,
	WeiZhi = 0,
	ShenGuang = 14,
	Cao = 1
}
GameEnum.RaceStr = {
	An = "暗",
	Yuan = "源",
	Guang = "光",
	Chuang = "创",
	Huo = "火",
	Kong = "空",
	ShenCao = "神草",
	ShenHuo = "神火",
	ShenGuang = "神光",
	ShenAn = "神暗",
	ShenKong = "神空",
	ShenShui = "神水",
	ShenChuang = "神创",
	ShenYuan = "神源",
	Shui = "水",
	Cao = "草"
}
GameEnum.RaceTxt = {
	[GameEnum.RaceType.Cao] = "草",
	[GameEnum.RaceType.Shui] = "水",
	[GameEnum.RaceType.Huo] = "火",
	[GameEnum.RaceType.Guang] = "光",
	[GameEnum.RaceType.An] = "暗",
	[GameEnum.RaceType.Kong] = "空",
	[GameEnum.RaceType.Chuang] = "创",
	[GameEnum.RaceType.Yuan] = "源",
	[GameEnum.RaceType.ShenCao] = "神草",
	[GameEnum.RaceType.ShenShui] = "神水",
	[GameEnum.RaceType.ShenHuo] = "神火",
	[GameEnum.RaceType.ShenGuang] = "神光",
	[GameEnum.RaceType.ShenAn] = "神暗",
	[GameEnum.RaceType.ShenKong] = "神空",
	[GameEnum.RaceType.ShenChuang] = "神创",
	[GameEnum.RaceType.ShenYuan] = "神源"
}
GameEnum.Races = {
	未知 = GameEnum.RaceType.WeiZhi,
	[""] = GameEnum.RaceType.WeiZhi,
	无 = GameEnum.RaceType.WeiZhi,
	[GameEnum.RaceStr.Cao] = GameEnum.RaceType.Cao,
	[GameEnum.RaceStr.Shui] = GameEnum.RaceType.Shui,
	[GameEnum.RaceStr.Huo] = GameEnum.RaceType.Huo,
	[GameEnum.RaceStr.Guang] = GameEnum.RaceType.Guang,
	[GameEnum.RaceStr.An] = GameEnum.RaceType.An,
	[GameEnum.RaceStr.Kong] = GameEnum.RaceType.Kong,
	[GameEnum.RaceStr.Chuang] = GameEnum.RaceType.Chuang,
	[GameEnum.RaceStr.Yuan] = GameEnum.RaceType.Yuan,
	[GameEnum.RaceStr.ShenCao] = GameEnum.RaceType.ShenCao,
	[GameEnum.RaceStr.ShenShui] = GameEnum.RaceType.ShenShui,
	[GameEnum.RaceStr.ShenHuo] = GameEnum.RaceType.ShenHuo,
	[GameEnum.RaceStr.ShenGuang] = GameEnum.RaceType.ShenGuang,
	[GameEnum.RaceStr.ShenAn] = GameEnum.RaceType.ShenAn,
	[GameEnum.RaceStr.ShenKong] = GameEnum.RaceType.ShenKong,
	[GameEnum.RaceStr.ShenChuang] = GameEnum.RaceType.ShenChuang,
	[GameEnum.RaceStr.ShenYuan] = GameEnum.RaceType.ShenYuan
}
GameEnum.BattleItemType = {
	Ball = "捕捉类",
	Skill = "技能类",
	Buff = "BUFF类"
}
GameEnum.BattleItemTargetType = {
	EnemySingle = "敌方-单体",
	EnemyRandom = "敌方-随机一只",
	FriendRealDie = "己方-死亡一只",
	EnemyRealDie = "敌方-死亡一只",
	EnemyDie = "敌方-重伤一只",
	FriendSingle = "已方-单体",
	EnemyAll = "敌方-全体",
	FriendAll = "已方-全体",
	FriendRandom = "己方-随机一只",
	FriendDie = "己方-重伤一只"
}
GameEnum.BattleItemTargetSelectType = {
	ServerMinHp = "后端选择最少血量一只",
	ClientSingle = "前端选择一只",
	ServerRandom = "后端随机一只",
	ServerRealDie = "后端随机选一只死亡的"
}
GameEnum.BattleTeam = {
	Left = 0,
	Right = 1
}
GameEnum.BattleTeamList = {
	GameEnum.BattleTeam.Left,
	GameEnum.BattleTeam.Right
}
GameEnum.BattleResult = {
	ExpSuccess = 3,
	DogFall = 2,
	Failed = 0,
	Success = 1
}
GameEnum.ChallengeBranchState = {
	LOCKED = 1,
	UNLOCKED = 2,
	PASSED = 3
}
GameEnum.BattleOc = {
	Beffore = 1,
	After = 2
}
GameEnum.GeniusType = {
	bailitiaoyi = 2,
	qianzainanfeng = 3,
	yiwushichu = 0,
	wanzhongzhumu = 4,
	shifenchangjian = 1,
	wangzhewudi = 5
}
GameEnum.FriendGroup = {
	Blacklist = 3,
	Stranger = 2,
	Friend = 1,
	Msg = 4,
	None = 0
}
GameEnum.RelTypeByFriend = {
	Tutor = 1,
	None = 0
}
GameEnum.RelIdByTutor = {
	Teacher = 2,
	Student = 1,
	None = 0
}
GameEnum.ChatChannel = {
	Zone = 1,
	LanternFestival = 16,
	System = 5,
	Help = 14,
	Share = 6,
	All = 8,
	ElementSpark = 12,
	League = 3,
	GoddessContest = 10,
	Camp = 9,
	GoddessCompetition = 13,
	Nearby = 4,
	Private = 0,
	World = 2,
	Battle = 7,
	Team = 11,
	Luyngarde = 15
}
GameEnum.ChatType = {
	Voice = 4,
	Share = 13,
	TimeStamp = -1,
	RedEnvelope = 3,
	System = 2,
	Lantern = 14,
	Honor = 16,
	CodeWord = 17,
	Recall = 15,
	CutePetTravel = 19,
	Word = 1,
	Form = 8,
	Pet = 7,
	Pk = 6,
	Sprite = 5
}
GameEnum.ChatItemType = {
	ItemOther = 2,
	ItemMy = 1,
	ItemTime = 4,
	ItemSystem = 3
}
GameEnum.Notice = {
	ThisWeek = 2,
	EveryTime = 0,
	Never = 1
}
GameEnum.RichText = {
	Emoji = 1
}
GameEnum.FtGameState = {}
GameEnum.FtPlayerState = {
	Jump = "PlayerJumpState",
	FallDown = "PlayerFallDownState",
	RunFaster = "PlayerRunFasterState",
	Stand = "PlayerStandState",
	Dash = "PlayerDashState",
	OnGround = "PlayerOnGroundState",
	Run = "PlayerRunState"
}
GameEnum.SxLimitName = {
	FamilyWeeklyLimit = "sx_weeklyCounterLimit",
	OneOffLimit = "sx_oneOffLimit",
	WeeklyCounterLimit = "sx_weeklyCounterLimit",
	MonthlyCounterLimit = "sx_monthlyCounterLimit",
	DailyCounterLimit = "sx_dailyCounterLimit",
	LongTimeCounterLimit = "sx_longTimeCounterLimit"
}
GameEnum.ArenaType = {
	Hero = 2,
	Elite = 1
}
GameEnum.MiniGameState = {
	NotStart = 1,
	End = 4,
	Pause = 3,
	Normal = 2
}
GameEnum.IconStatus = {
	Can = 2,
	Cannot = 1,
	Got = 3
}
GameEnum.NoticeType = {
	Game = 2,
	Activity = 1,
	MainTain = 3
}
GameEnum.RankType = {
	LONGHUANG_RANK = 13,
	RankMatchClass = 6,
	Huoqilin = 29,
	AchievementRank = "AchievementRank",
	MaxPower = 4,
	GloryTowerRank = "GloryTowerRank",
	Leila_RANK = 21,
	Mirror_Rank = "Mirror_Rank",
	RankMatchLimit = 7,
	LianjinMengmeng = 30,
	FamilyHonor = "FamilyHonor",
	SeniorArena = 9,
	DuolaMM_RANK = 16,
	AMIER_RANK = 15,
	PANDUOLA_RANK = 11,
	NianNian_RANK = 24,
	Arena = 3,
	Nuoya_RANK = 23,
	Moyan_RANK = 22,
	SendFlower_RANK = "SENDFLOWER_RANK",
	QIANLI_RANK = 25,
	ZhiXuLong_RANK = 26,
	Mingjing_RANK = 19,
	PowerSurgeRank = "PowerSurgeRank",
	FamilyTeamPlay = "FamilyTeamPlay",
	ShengGuangFeiLong = 12,
	SYGuangmingwang = 31,
	MIYA_RANK = 14,
	KingArena = 32,
	Youlie_RANK = 20,
	Mang_RANK = 18,
	WTower = 2,
	FlyNuo = 8,
	ShowOffRank = 33,
	ArenaCombine = 34,
	Athena = 27,
	PetChallengeFirstPassRank = "PetChallengeFirstPassRank",
	Charm_RANK = "CHARM_RANK",
	ARUISI_RANK = 10,
	BreakFormation = 1,
	AnheiMM_RANK = 17,
	XiaoNuoBian = 5,
	Luota = 28
}
GameEnum.RankClassType = {
	GainTime = 0,
	TotalScore = 2,
	Damage = 1,
	DailyScore = 3
}
GameEnum.TalentType = {
	Talent2 = 2,
	Talent4 = 4,
	Talent3 = 3,
	Talent5 = 5,
	Talent0 = 0,
	Talent1 = 1
}
GameEnum.PanelGuideType = {
	Mofang = 3,
	Formation = 2,
	GodMonTrain = 8,
	PetsHandBook = 6,
	XiaoNuoBian = 9,
	SourceMon = 4,
	ActionMode = 10,
	PetEgg = 5,
	DiamondTask = 7,
	Pet = 1
}
GameEnum.MagicLockType = {
	Task = 2,
	Challenge = 1,
	Scene = 3,
	Func = 4
}
GameEnum.TitleState = {
	OUTDATE = 3,
	OWN = 1,
	ON = 2,
	NONE = 0
}
GameEnum.PetShowTab = {
	Talent = 2,
	Equip = 4,
	Story = 5,
	Dress = 6,
	Info = 1,
	Awake = 3
}
GameEnum.Chapter = {
	Plot = 0
}
GameEnum.StarEquipmentQua = {
	Blue = 2,
	Golden = 4,
	Red = 5,
	Green = 1,
	Purple = 3
}
GameEnum.HandbookTab = {
	PetOverall = 3,
	PetFiles = 1,
	PetPoster = 2
}
GameEnum.PetUpType = {
	PetUpgrade = 4,
	PetEquipLvup = 5,
	PetStarLvup = 2,
	PetTalentLvup = 3,
	PetAwakeRing = 6,
	PetAwake = 1
}
GameEnum.PetCvType = {
	BattleLose = 4,
	Default = 1,
	PetUp = 2,
	BattleWin = 3,
	PetIntrod = 8,
	Formation = 5,
	UseSkill = 7,
	BattlePerfect = 6
}
GameEnum.FuncType = {
	Lottery = 43,
	Family = 60,
	Exchange = 46,
	FamilyTeamplay = 252
}
GameEnum.ItemIdType = {
	DrawTicket = 31
}
GameEnum.RomanNumber = {
	[0] = "N",
	"I",
	"II",
	"III",
	"IV",
	"V",
	"VI",
	"VII",
	"VIII",
	"IX",
	"X",
	[100] = "XX"
}
GameEnum.FamilyTag = {
	Fight = 3,
	NB = 6,
	Idle = 1,
	Oldhand = 4,
	Rich = 2,
	Gandhi = 5
}
GameEnum.PetStarUpStrategy = {
	RaceId = 1,
	RaceIds = 4,
	Attr = 2,
	Job = 3
}
GameEnum.PowerCrystalPosType = {
	Cool = 3,
	Hold = 2,
	Lock = 1,
	Empty = 4
}
GameEnum.GoldType = {
	FormationCore = "4:20000",
	Tili = "60:1",
	PetAssisCost2 = "4:4002",
	GodDiamondCoin = "204:102",
	Coin = "8:1",
	PixieDust = "8:8",
	TLChallengeCoin1 = "4:81",
	PowerStone = "4:401",
	FamilyCoin = "8:5",
	TimeWheelOverflow = "8:23",
	RankCoin = "8:7",
	PifuCoin = "8:17",
	DressCoin = "8:14",
	PetAssisCost1 = "4:4001",
	MirrorChip = "4:127",
	SeniorArenaTicket = "4:703",
	LegendchallengeCoin = "8:9",
	XiuxianCoin = "8:11",
	RuneCoin = "8:12",
	PetAssisCost3 = "4:4003",
	ExpeditionCoin = "8:10",
	Diamond = "104:2",
	PetAssisCost5 = "4:4005",
	FamilyCoinPremium = "8:27",
	PetAssisCost4 = "4:4004",
	SweepTicket = "4:3101",
	MountCoin = "8:26",
	TLChallengeCoin2 = "4:82",
	SeniorArenaCoin = "8:16",
	ArenaCoin = "8:3",
	ThanksCoin = "10:170001",
	PowerBook = "4:402",
	FamilyFund = "8:41",
	RecallCost = "10:74001"
}
GameEnum.PayShopMibaoTab = {
	Huodong = 3,
	DressCoin = 15,
	Chaozhi = 2,
	Xinshou = 1,
	Recharge = 4,
	GoldenDiamond = 16
}
GameEnum.PayShopFirstTab = {
	Mibao = 1,
	Shop = 2,
	Privilege = 5,
	VipShop = 6,
	Exchange = 3,
	WeekTotalRecharge = 7,
	DressShop = 4
}
GameEnum.PayShopMibaoSecTab = {
	Recharge = 2,
	Gift = 1
}
GameEnum.PayShopVipShopSecTab = {
	VipShop = 7
}
GameEnum.PayShopPrivilegeTab = {
	WholeLifeCard = 3,
	YearCard = 2,
	ResMonthCard = 4,
	MengxinCard = 6,
	MonthCard = 1,
	ChallengeCard = 5
}
GameEnum.PayShopWeekRechargeTab = {
	TotalRecharge = 3,
	WeekRecharge = 1,
	WeekRechargeShop = 2
}
GameEnum.PaySubGoodsType = {
	IntegrationChallenge = 28,
	PAY_TEMPT = 5,
	Privilege_GIFT = 7,
	OPERATINGGGIFT = 12,
	ANLONG_SELF_SELECT = 22,
	RED_STAR_GOD_SELL = 27,
	MONTH_CARD = 2,
	NEW_HAND_WELFARE = 37,
	Pay_YearCardGift = 34,
	PAY_WISHINGWELLSHOP = 9,
	MIRRORTRIAL = 21,
	LONG_YAN_XI_XI_SKIN = 11,
	DRESSACTIVITY = 14,
	PASS_PORT = 3,
	CLOTHES_SHOP = 4,
	PREHEAT_SALE = 29,
	PAY_PLAYERRETURNSHOP = 20,
	Pay_YearCardGiftNew = 47,
	DISCOUNT_DRESS_SHOP = 40,
	WELFARE_SUMMARY = 33,
	PACKDISCOUNT = 46,
	PAY_SHOP = 1,
	WANDERER_PASS = 50,
	DRESS_DISCOUNT = 42,
	PAY_ACTIVITY_STRENGTHEN = 36,
	SAINTKNIGHTCARDDRAWPLAN = 43,
	GOLDENDIAMONDCARD = 24,
	GOD_LONG_YAN_CHALLENGE = 41,
	GOLDEN_DIAMOND_CARD_GIFT = 38,
	NOAHCHALLENGE = 25,
	ANNUITY = 6,
	MONTH_CARD_PACK = 39,
	NewZeroPay = 17,
	RACE_STRENGTHEN = 23,
	COMPANION_MALL = 49,
	LEVEL_TIME_MACHINE = 10,
	NEW_HAND_CARD = 8,
	PAY_STRENGTHEN = 35,
	DISCOUNT_ACCRUYING_PAY = 18,
	ZERO_PAY = 16
}
GameEnum.PayShopPayType = {
	GAMEGOODS = 2,
	RMB = 1,
	JUMPGOODS = 0
}
GameEnum.PayShopShopType = {
	PetOverflow = 5,
	Shop = 2,
	Payshop = 1,
	DressShop = 4
}
GameEnum.ExchangeTab = {
	KingArena = 20,
	Zoo = 11,
	ExpeditionHigh = 12,
	Thankscoin = 15,
	Expedition = 7,
	TutorSystem = 14,
	CutePet = 18,
	WorldBoss = 10,
	MiniGame = 9,
	_3v3 = 8,
	Arena = 2,
	Family = 1
}
GameEnum.MiniGame = {
	SXGame = 3,
	XiaoNuo = 1
}
GameEnum.PayShopEasyJump = {
	Exchange3v3 = "Exchange3v3",
	ExchangeMiniGame = "ExchangeMiniGame",
	WholeLifeCard = "WholeLifeCard",
	MengxinCard = "MengxinCard",
	MonthCard = "MonthCard",
	MibaoShop = "MibaoShop",
	ExchangeTutorSystem = "ExchangeTutorSystem",
	ExchangeCutePet = "ExchangeCutePet",
	ExchangeKingArena = "ExchangeKingArena",
	TehuiGift = "TehuiGift",
	DiscountGift = "DiscountGift",
	YearCard = "YearCard",
	GoldenDiamondCard = "GoldenDiamondCard",
	TiliGift = "TiliGift",
	ZhaohuanGift = "ZhaohuanGift",
	GodDiamond = "GodDiamond",
	ExchangeFamily = "ExchangeFamily",
	HotGoods = "HotGoods",
	ResMonthCard = "ResMonthCard",
	ChallengeCard = "ChallengeCard",
	ExchangeWorldBoss = "ExchangeWorldBoss",
	Recharge = "Recharge",
	ExchangeExpedition = "ExchangeExpedition",
	Thankscoin = "Thankcoin",
	WeekRecharge = "WeekRecharge",
	ExchangeArena = "ExchangeArena",
	ShengxingGift = "ShengxingGift",
	Skin = "Skin",
	Yangcheng = "Yangcheng"
}
GameEnum.Evaluate = {
	ActiveCountLessThan = "ActiveCountLessThan",
	KillNum = "KillNum",
	ActiveCount = "ActiveCount",
	MyRaceIdMustActive = "MyRaceIdMustActive",
	PosHpRate = "PosHpRate",
	CircleCount = "CircleCount",
	BuffNum = "BuffNum",
	EnemyBuffNum = "EnemyBuffNum",
	Combination = "Combination",
	MyPosIdMustActive = "MyPosIdMustActive",
	DieCount = "DieCount",
	DamageTotal = "DamageTotal",
	DamageTotalRange = "DamageTotalRange",
	RaceHpRate = "RaceHpRate",
	EqualCircleCount = "EqualCircleCount",
	CharacterActiveNum = "CharacterActiveNum",
	EnemyActiveCount = "EnemyActiveCount",
	MyActivePetContainsAttrs = "MyActivePetContainsAttrs",
	EnemyActiveLessThanCount = "EnemyActiveLessThanCount"
}
GameEnum.BulletScene = {
	PlotCG = 3,
	InBattle = 2,
	Formation = 1
}
GameEnum.ShareType = {
	LotusBattle = 14,
	PowerCheck = 6,
	Formation = 2,
	ShareRecall = 7,
	ShareBoss = 3,
	BountyPKCompete = 11,
	ShareFood = 8,
	LiYangKing = 17,
	GoldendTen = 13,
	ShareHonor = 9,
	Pet = 1,
	FalLandlords = 12,
	Zoo = 5,
	MasterForm = 15,
	ShareFirePowerGame = 10,
	Luyngarde = 16,
	SharePk = 4
}
GameEnum.PetRare = {
	SR = 3,
	SSR = 4,
	UR = 5,
	R = 2,
	N = 1
}
GameEnum.RuneQuality = {
	TYPE_LAN = 3,
	TYPE_CHENG = 5,
	TYPE_BAI = 1,
	TYPE_LV = 2,
	TYPE_ZI = 4,
	TYPE_HONG = 6
}
GameEnum.StarGodPlusQuality = {
	TYPE_LAN = 2,
	TYPE_ZI = 3,
	TYPE_CHENG = 4,
	TYPE_HONG = 5
}
GameEnum.FriendHeartState = {
	CanSend = 2,
	CanGain = 1,
	Disable = 3
}
GameEnum.PetAwakenType = {
	MaxLv = -1,
	UpSun = 4,
	UpStar = 1,
	UpRareUtl = 3,
	UpRare = 2
}
GameEnum.ZooPartToGeneKey = {
	"headGene",
	"headWearGene",
	"expressionGene",
	"clothesGene",
	"foreheadGene",
	"weaponGene",
	"backWearGene",
	"tailWearGene"
}
GameEnum.ActivityType = {
	VillainPet = 163,
	PickUpIdea = 338,
	DivineMiRuiKe = 381,
	Spec = 3,
	GROUP_RED_PACK = 249,
	DragonTrial = 108,
	Boccaccioclg = 578,
	EternalDragon = 295,
	EternalCity = 557,
	SingleRecharge = 78,
	Parallelkingdragon = 519,
	DragonPool = 300,
	DivineKingDragonChallenge = 314,
	QIXI_SEND = 245,
	TunTianChallenge = 289,
	LINKAGE_LOTTERY = 229,
	FirstAnnualWelfare = 146,
	SixArtDaoguan = 447,
	NightFeastBoss = 335,
	MoorDiscountDressGift = 159,
	SnowManCar = 432,
	KingIsaacClg = 347,
	GeneralWorldProgress = 262,
	XIU_MUM_CHALLENGE = 239,
	Summontower = 85,
	SeekFood = 282,
	FemalePsychicChallenge = 253,
	AnswerFunc = 212,
	FlyNuo = 6,
	CallOrder = 149,
	TOP_UP_LOTTERY = 236,
	BOUNTY_PK = 204,
	GuessBoxGame = 138,
	Double = 19,
	RICH_MAN = 230,
	BrotherHood = 214,
	BIRTHDAY_SPORTS_WISHES = 222,
	PurchaseLimit = 298,
	SeckillZone = 210,
	CantonOperaRoad = 189,
	Hexagram = 53,
	DragonLords = 194,
	KingmmChallenge = 278,
	MakeGift = 92,
	XiaoNuoBirthdayGift = 220,
	OriginAshlessDragon = 564,
	EHolyDragon = 301,
	DANCING_LION_JUMP = 235,
	Kindergarten = 353,
	StarScratch = 364,
	SaintKnightTask = 175,
	PopularityList = 72,
	TaskCardHot = 52,
	DreamTeam = 24,
	AnnualActivity = 134,
	JiuClg = 386,
	RoleShip = 129,
	VersionForesight = 266,
	Anniversary_Preheat = 141,
	GoddessWaken = 130,
	HeatProgress = 105,
	DivineJieShen = 387,
	GoddessGlory = 131,
	AccumulateCharge = 22,
	ZeroPay = 28,
	AixinMMHospital = 281,
	MangTower = 39,
	FESTIVE_FLOWER = 174,
	ForceSlide = 148,
	DirectPurchase = 75,
	ThreeElimination = 339,
	DivineSaintKnightFireGod = 480,
	FIRE_POWER_CONTEST = 158,
	ClearStar = 479,
	GiftBox = 318,
	AnnualBox = 143,
	GoddessDelicacy = 125,
	Godgemconsume = 114,
	DisOrderPower = 422,
	DualDragon = 258,
	DivineGodDragonClg = 346,
	DirectPurchaseSec = 86,
	Summary = 17,
	DragonKingARuiShiClg = 361,
	LIUDAOLUNHUA = 198,
	WuDiClg = 317,
	FanRuiChallenge = 293,
	DivineDiShiTian = 363,
	DivineKingJiClg = 463,
	NumberPuzzle = 320,
	MusicGame = 370,
	KingKaYa = 371,
	YouthArenaThird = 624,
	DivineKingOrderClg = 357,
	EternalChallenge = 297,
	DaysRecharge = 79,
	RoseClg = 414,
	AngelPowerClg = 384,
	Ashe_Challenge = 246,
	PeakDiamond = 225,
	CashBackLucky = 193,
	DragonXiuer = 323,
	GODDESS = 121,
	LailisiPet = 165,
	TunTianHelp = 290,
	CakeSign = 26,
	ActivityDailyRecharge = 44,
	FirstCharge = 8,
	PsychicedTower = 388,
	CatchProps = 66,
	FlowerGoddess = 137,
	JieShenVsJiu = 390,
	NeverLand = 294,
	ChuangZhengli = 398,
	HelpDragonMom = 160,
	JieShenEvent = 397,
	WISH_TREE = 232,
	DuoLaMMGame = 375,
	DivineDakinosClg = 400,
	WelfareSummary = 96,
	SummonMasterHopeClg = 403,
	TourArenaFight = 310,
	ElvesRevealed = 406,
	AnniversaryKoi = 261,
	PAY_STRENGTHEN = 101,
	NuoYaSisterClg = 407,
	SaintKnightRui = 172,
	DivineCoronate = 410,
	BorrowPet = 411,
	CiYuanShengLong = 306,
	ReviveElizabeth = 416,
	Monopoly = 1,
	DivineJiClg = 421,
	DivineSuperDragon = 344,
	AoqiGod = 424,
	ProjectAsh = 265,
	KING_CI_YUAN_CHALLENGE = 241,
	ElementSpark = 311,
	DarknessSpring = 430,
	MississiChallenge = 135,
	UltimateWar = 434,
	NvdiChallenge = 342,
	AshlessLongYan = 435,
	LanternRiddle = 441,
	SlackOffGame = 442,
	RebateMall = 277,
	DivineShiKongLongZun = 418,
	NaiLongLottery = 448,
	MULTIPLEGIFTPACKS = 202,
	ActivityDailyRechargeShop = 45,
	Divineinfinitefutureclg = 455,
	JudgmentDragonClg = 461,
	PuzzleGameHud = 56,
	YearCard_Preheat_2023 = 233,
	Event_Preview = 181,
	DivineDualDragonClg = 469,
	Planetarium = 280,
	WaterTianYan = 305,
	ChopKing = 470,
	GuessPets = 139,
	OperatingGift = 16,
	DivineInvincible = 473,
	GuardDestroyClg = 474,
	DivineHaloGame = 476,
	DivineMiZongClg = 477,
	Divinemimengliclg = 460,
	YoungChampionKing = 391,
	SummaryPop = 41,
	SurvivalKing = 529,
	MiracleMultiplied = 380,
	WishTreeBottle = 328,
	ThrowShells = 64,
	DiscountaccruingPay = 38,
	ConsumeDiamondGift = 40,
	DirectUp = 60,
	AwakenOathAncestor = 496,
	OriginXingjiangClg = 570,
	ZhuanMai = 84,
	OriginAn = 589,
	FuYaoChallenge = 272,
	ShenJiChallenge = 312,
	DivineTeshamu = 504,
	HeartOfAoJiuClg = 505,
	WuWenChallenge = 374,
	FUN_CAMP_BATTLE = 187,
	MagicSchoolPvP = 514,
	HolyWaterOrder = 292,
	SignIn = 18,
	TongLinShiJi = 420,
	FreeZone = 211,
	WisdomCourageClg = 456,
	NEW_YEAR_INVEST = 238,
	ShadowDragonClg = 527,
	AnniversaryCake = 140,
	DivineKingCiYuan = 405,
	GloryBattle = 528,
	ConsumeLottery = 29,
	OriginKingCiYuanDragonClg = 534,
	LuckyDraw = 25,
	SummerHolidaysCheckIn = 283,
	OriginPsychicJi = 542,
	DiscountDressGift = 154,
	NewEraNuoya = 535,
	IdiomChain = 543,
	BuddyLuckyBag = 544,
	TimeServerPetGain = 162,
	DragonPsychicClg = 351,
	GODDESS_COLLECTOR = 124,
	PartyFood = 196,
	OriginGodDragonClg = 545,
	WeeklyGroup = 287,
	SaintKnightCard = 178,
	OriginaresMom = 549,
	ArmorHeroLottery = 553,
	CardHot = 36,
	PetActiveGet = 401,
	GROUP_RECHARGE = 180,
	DestroyEvil = 322,
	MonthCardPack = 150,
	HolyDragonField = 611,
	MiracleHero = 383,
	OriginDarkMoYanClg = 625,
	DragonSupper = 110,
	FreeScuffle = 489,
	AnlongSelfSelect = 57,
	PartyGift = 200,
	DoDragonChallenge = 252,
	SUMMER_LOTTERY = 167,
	KunWu = 444,
	KingMoYanClg = 429,
	EternalFarm = 296,
	DivineXiuErClg = 329,
	BoccaccioChapter = 580,
	SuppressGame = 161,
	SkinLottery = 215,
	MartialContest = 583,
	DivineHope = 518,
	DemonDescend = 497,
	HexLineup = 590,
	MMTeamPassport = 600,
	HolyDragonTemple = 609,
	StarTeam = 15,
	GoddessCompetition = 453,
	Scuffle = 37,
	KunLunChallenge = 304,
	Caiqingdraw = 242,
	XuChallenge = 613,
	GroupRegress = 598,
	TeshamuChallenge = 288,
	BirthdayCake = 224,
	OriginChenClg = 620,
	HeartOfJieShenClg = 389,
	AnchorSimulator = 446,
	MiracleFindTreasure = 379,
	NewYearPray = 326,
	SignIn2 = 49,
	DivineSKLieXinClg = 478,
	XplanArchives = 378,
	DragonAwaken = 419,
	DumplingFeast = 562,
	GuessLantern = 307,
	WheelLotteryPool = 409,
	SpringRedPack = 113,
	MaintainPowerPilla = 152,
	JiSummoner = 144,
	FanRuiLottery = 299,
	BrotherGroup = 209,
	EndlessChallenge = 123,
	SweepBattleField = 267,
	RECAP_2021 = 136,
	DomainAdventure = 402,
	DivineMiyaClg = 399,
	FireWork = 145,
	OriginKingMengMengClg = 594,
	PAY_SHOP_DISCOUNT_GIFT = 117,
	AceTeam = 71,
	PriceBreakDiscount = 219,
	Luyngarde = 466,
	LANDLORDS_PK = 243,
	SUPER_GHOST_LOTTERY = 260,
	StickCouplet = 439,
	RichManXPlan = 373,
	AthenaBless = 89,
	MAKE_SNOWMAN = 231,
	DivineWeiLeiTaClg = 433,
	ExploreUnder = 157,
	LionCulture = 237,
	PAY_STRENGTHEN_EXT = 118,
	HitBoss = 327,
	FiveYearRecap = 586,
	FUN_CAMP_EXCHANGE = 197,
	DivineGasiri = 369,
	Goddess_Contest = 251,
	BirthdayWishes = 223,
	PowerSurge = 166,
	ScratchLottery = 257,
	LotusBattle = 268,
	PartyPrize = 90,
	RelationPower = 354,
	LuckyMoney = 438,
	CHUANG_KONG_UNION = 102,
	HOLIDAY_GIFT = 186,
	MiyaChallenge = 218,
	GodDarkDragon = 331,
	GUARD_CITY = 250,
	ImageFragmentCollection = 69,
	DressActivityShop = 27,
	PetCardLottery = 271,
	CompetitionKing = 275,
	ShowDown = 360,
	FriendBargain = 255,
	DivineAsheslessDragon = 352,
	BestDragonSoul = 358,
	Farnas = 333,
	Dreamyouth = 93,
	PetAwakenVer = 115,
	YearCardPreheat = 97,
	HolyLight = 254,
	XiuNuoBrotherhood = 208,
	BabyBus = 256,
	DragonDishitian = 343,
	InvitationCard = 31,
	PackDiscount = 291,
	KingOfRadiantGoldClg = 462,
	SummontowerAnother = 199,
	WHEEL_FORTUNE = 227,
	SunWuKongChallenge = 263,
	XiaYin = 336,
	DragonVeinNuoYaClg = 427,
	WeakPathFinding = 151,
	HeroTrial = 9,
	YanmoBestPartner = 270,
	DivineFuYaoClg = 502,
	GratefulPuzzle = 122,
	DivineNuoYaChallenge = 316,
	OriginWeiLeiTa = 561,
	MagicContest = 514,
	PsychicHirePet = 221,
	OriginaruishiClg = 550,
	KingSpaceDragon = 350,
	StKnExp = 481,
	DuoLaLight = 279,
	BeastFightingChess = 412,
	COLLECT_CLOTHES_ACTIVITY = 185,
	DressActivityShopGodGem = 120,
	NaiLongHotSearch = 443,
	AoqiHero = 450,
	LingShenChallenge = 377,
	DivineCiYuan = 302,
	CollectTangyuan = 240,
	SaintKnightRegress = 483,
	ElizabethGame = 341,
	PinGame = 325,
	BuryGame = 50,
	IceQibuGame = 507,
	NewHandWelfare = 109,
	GoldendTen = 259,
	HolyDarkMM = 284,
	QI_CHALLENGE = 244,
	PASSPORT_NEWYEAR = 234,
	PowerLand = 156,
	Nor2 = 2,
	TourArenaGame = 309,
	FruitNinja = 475,
	ARuiShiDragonGame = 366,
	GatherTask = 100,
	AutoChess = 286,
	PET_OBTAIN = 206,
	RECASTGLORY = 248,
	OperationPlot = 12,
	RankVerify = 111,
	KingJiChallenge = 308,
	Gashapon = 32,
	CollectingSkin = 362,
	DivineWaterTianyan = 513,
	TripleMacthesGame = 349,
	GoddessVote = 127,
	WaterDrakTower = 59,
	DarkDragonKnife = 58,
	Divineisaacclg = 491,
	MirrorTrial = 51,
	GoddessShop = 459,
	FunArena = 98,
	DivineDisorderDragon = 423,
	LuoTianDaJiao = 55,
	Vacationpowersurge = 46,
	CRAZY_PARTNER = 153,
	PerheatSale = 87,
	DivineLongyan = 355,
	SAINT_KNIGHT_MO = 179,
	MiracleNuoyaChallenge = 382,
	AccumulateLottery = 42,
	INTO_THE_CAR = 228,
	LingShenConvene = 376,
	PeakTournament = 217,
	OriginKingOrderClg = 569,
	NewZeroPay = 34,
	COLLECTING_RACE = 184,
	WishList = 65,
	SummonMasterJi = 348,
	YearScratch = 356,
	FireDimension = 274,
	JigsawCollect = 20,
	LinkGame = 303,
	UltimateTrial = 472
}
GameEnum.Score = {
	A = "A",
	C = "C",
	D = "D",
	S = "S",
	B = "B"
}
GameEnum.AwakenCardTag = {
	SameRaceIdSSR = 6,
	SameShui = 2,
	SameHuo = 3,
	SameCao = 1,
	SameGuang = 4,
	SameRaceIdUR = 7,
	SameAn = 5
}
GameEnum.CampaignType = {
	EndlessAttack = "infiniteFightDailyRewardMultiply",
	Plot = "plotRewardMultiply",
	breachWorldPrize = "breachFormationRewardMultiply",
	petContractSkillSelfSelect = "petContractSkillSelfSelect",
	Expedition = "expeditionRewardMultiply",
	Material = "materialClgRewardMultiply",
	WorldBossPrize = "worldBossRewardMultiply",
	DiamondTask = "diamondTaskRewardMultiply",
	ShareTaskCount = "shareTaskTimesMultiply",
	familyEscortPrize = "convoyRewardMultiply",
	petSendPrize = "petDispatchRewardMultiply"
}
GameEnum.PrivateMainView = {
	MonthCard = 1,
	YearCard = 3,
	WholeLifeCard = 2,
	Private = 4
}
GameEnum.PetAttrScore = {
	C = 1,
	A = 3,
	SS = 5,
	D = 0,
	SSS = 6,
	S = 4,
	B = 2
}
GameEnum.PetAttrScoreTitle = {
	[GameEnum.AttrType.Hp] = "hpScore",
	[GameEnum.AttrType.Attack] = "attScore",
	[GameEnum.AttrType.DefensePhysical] = "defPhyScore",
	[GameEnum.AttrType.DefenseMagic] = "defMagScore",
	[GameEnum.AttrType.Speed] = "speedScore"
}
GameEnum.VerifyType = {
	KingWay = 2,
	Legend = 1
}
GameEnum.GFChatGroupType = {
	INTRODUCE = 1,
	SCHEDULE = 3,
	SELF = 2
}
GameEnum.GFRedType = {
	Reward = 4,
	LvReward = 3,
	Stroy = 5,
	AdressBookTab = 1,
	AdressBookItem = 2
}
GameEnum.MissionSetting = {
	AtkTarget = 2,
	RecPos = 3,
	Restrain = 1
}
GameEnum.ThroneTabType = {
	All = 0,
	Keji = 1,
	Baijian = 4,
	Baowu = 2,
	Shengqi = 3
}
GameEnum.HoshigamiEquipTipType = {
	Bag = 1,
	EditPrefab = 2
}
GameEnum.HoshigamiBagViewTabType = {
	Pos = 2,
	Type = 1
}
GameEnum.HoshigamiEquipItemPos = {
	{
		rotate = 180,
		x = 137,
		y = -245
	},
	{
		rotate = 90,
		x = -42.7,
		y = -201.6
	},
	{
		rotate = 43,
		x = 11.5,
		y = -78.6
	},
	{
		rotate = 0,
		x = 137.6,
		y = -26.5
	},
	{
		rotate = -44,
		x = 263,
		y = -78.6
	},
	{
		rotate = -88,
		x = 315.8,
		y = -201.6
	}
}
GameEnum.HoshigamiConditionFilter = {
	Power = 3,
	Quality = 2,
	Strength = 1
}
GameEnum.QuestionType = {
	FillInBlanks = 1,
	Remark = 4,
	Scoring = 3,
	ChoiceText = 2,
	ChoiceImage = 5
}
GameEnum.TimeLimitedChallengeType = {
	Circle = 1,
	Accumulate = 2
}
GameEnum.BattleTopViewType = {
	HeroTrial = 4,
	TimeLimitedChallenge = 5,
	WorldBoss = 3,
	FamilyBoss = 2,
	Normal = 1
}
GameEnum.StarGodPlusEquipTypeName = {
	"攻击",
	"防御",
	"生命",
	"暴击",
	"防暴",
	"命中",
	"闪避",
	"破击",
	"格挡",
	"气势"
}
GameEnum.MainUIFuncArea = {
	BomRight_Vertical = 3,
	BomRight_Horizontal = 4,
	TopRight_2 = 2,
	Fixed = 5,
	TopRight_1 = 1
}
GameEnum.MainUIFuncAreaKey = {
	[GameEnum.MainUIFuncArea.TopRight_1] = "TopRight_1",
	[GameEnum.MainUIFuncArea.TopRight_2] = "TopRight_2",
	[GameEnum.MainUIFuncArea.BomRight_Vertical] = "BomRight_Vertical",
	[GameEnum.MainUIFuncArea.BomRight_Horizontal] = "BomRight_Horizontal",
	[GameEnum.MainUIFuncArea.Fixed] = "Fixed"
}
GameEnum.TELEPHONE = 1
GameEnum.WE_CHAT = 2
GameEnum.QQ = 3
GameEnum.BIRTHDAY = 4
GameEnum.Rigidbody2DBodyType = {
	Static = 3,
	Kinematic = 2,
	Dynamic = 1
}
GameEnum.MiyaModeType = {
	FIND_DIFFERENCE = 3,
	DIRECT_SUCCESS = 5,
	BOSS_MONSTER = 2,
	ANSWER_QUIZ = 4,
	NORMAL_MONSTER = 1
}
GameEnum.ItemUseType = {
	Default = 0,
	Composite = 2,
	Use = 1,
	Evolve = 3
}
GameEnum.BattleWinnerOpType = {
	MyPosIdMustActive = "MyPosIdMustActive",
	RestraintAtt = "RestraintAtt",
	ActiveCount = "ActiveCount",
	CircleCount = "CircleCount",
	MyCriticalNum = "MyCriticalNum",
	DamageTotal = "DamageTotal",
	MyActivePetContainsAttrs = "MyActivePetContainsAttrs",
	DamageTotalRange = "DamageTotalRange",
	MyDodgeNum = "MyDodgeNum",
	EqualCircleCount = "EqualCircleCount"
}
GameEnum.FamilyTpSmallGame = {
	Flynuo = 2,
	ZSM = 3,
	KJT = 1
}
GameEnum.LightKingChallengeType = {
	YAOSHI = 2,
	SHENGGUANG = 1,
	JIXIAN = 3
}
GameEnum.MissionType = {
	BING_LING_WANG = 2,
	LIGHTKING = 1,
	CYNTHIA = 5,
	BountyPkCompete = 7,
	LONG_NV = 3,
	SaintKnightRui = 6,
	SUNRANBATTLE = 4
}
GameEnum.FRONT_PET = "前排"
GameEnum.BACK_PET = "后排"
GameEnum.ASSIST_PET = "点火"
GameEnum.FBBSlotType = {
	Scoop = 2,
	JL = 3,
	Empty = 1
}
GameEnum.BuryPitEnum = {
	CHICK = 2,
	DUCK = 3,
	DEAD = 1
}
GameEnum.LotteryBgEffectType = {
	YiRenZhiXia = 2,
	MengZhiDui = 1
}
GameEnum.PopularityList = {
	Pet = "race",
	PainterVote = "GameEnumPopularityListPainterVote",
	PetVote = "GameEnumPopularityListPetVote",
	Painter = "skin",
	First = "GameEnumPopularityListFirst"
}
GameEnum.GrowUpRoad = {
	Lv = 3,
	RightTask = 2,
	Equip = 5,
	Potential = 6,
	LeftTask = 1,
	Awake = 7,
	Star = 4
}
GameEnum.SweepType = {
	Default = -1,
	Arena = 1
}
GameEnum.PayShopTabSellType = {
	SellSkin = "SellSkin",
	SellPet = "SellPet",
	SellMount = "SellMount"
}
GameEnum.PayShopTabSellTypeJumpTo = {
	[GameEnum.PayShopTabSellType.SellPet] = "mibao#Skin",
	[GameEnum.PayShopTabSellType.SellSkin] = "mibao#Pifu",
	[GameEnum.PayShopTabSellType.SellMount] = "mibao#Mount"
}
GameEnum.Recap21Type = {
	GOOD_FEELING_MAX_RACE = 1,
	FIRST_AWAKEN_RACE = 4,
	TOTAL_ONLINE = 20,
	ARENA_3V3_GAIN_PRIZE = 10,
	EVER_TITLE = 16,
	TOTAL_GAIN_DIAMOND = 25,
	RANKING_MATCH_CLASSIC_BEST_TOP_GROUP = 11,
	USE_STRENGTH = 21,
	TOTAL_LOTTERY_EQM = 27,
	MAX_SSR_RACE = 3,
	ARENA_BEST_POSITION = 9,
	DAYS_IN_0_TO_5 = 22,
	RANKING_MATCH_EXTREME_BEST_TOP_GROUP = 12,
	EVER_HEAD_FRAME = 17,
	EVER_HEAD_ICON = 15,
	TOTAL_LOTTERY_PET = 26,
	DECOMPOSE_PET = 5,
	TOTAL_ONLINE_DAYS = 23,
	BATTLE_COUNT = 13,
	FULL_LEVEL_PETS = 6,
	PEAK_TOURNAMENT_WIN_TIMES = 28,
	SKINS = 18,
	PET_HISTORY_COUNT = 7,
	SEASON_MODE_PARTICIPATION_TIMES = 29,
	MAX_ZDL_RACE = 2,
	SEASON_MODE_OCCUPIED_NUM = 30,
	CLOTHES = 19,
	LATEST_LOG_OUT = 24,
	TOTAL_MOUNT = 14,
	MAX_ZDL_SIX_PETS = 8
}
GameEnum.Recap21EditionType = {
	CONSUME_MONEY = 1,
	GAIN_NEW_RACES = 2,
	EDITION_USE_STRENGTH = 3,
	GAIN_SKINS = 4
}
GameEnum.PayshopSellSkinTagType = {
	Recommend = 3,
	LimitSell = 1,
	NewGoods = 2,
	Discount = 4
}
GameEnum.PayshopSellSkinTagRank = {
	[GameEnum.PayshopSellSkinTagType.LimitSell] = 1,
	[GameEnum.PayshopSellSkinTagType.Discount] = 2,
	[GameEnum.PayshopSellSkinTagType.NewGoods] = 3,
	[GameEnum.PayshopSellSkinTagType.Recommend] = 4
}
GameEnum.PayshopSkinSortType = {
	DiamondBuy = 3,
	OnlineTime = 5,
	NotGet = 1,
	PifuCoinBuy = 4,
	Rare = 2
}
GameEnum.IdentityType = {
	FreeMan = 3,
	Student = 1,
	Teacher = 2
}
GameEnum.IdentityState = {
	StuHasFinish = 33,
	IsStudying = 11,
	NoStuTeaQuals = 34,
	TeaQuals = 31,
	NotRecruiting = 22,
	StuQuals = 32,
	Recruiting = 21
}
GameEnum.TsNotifyKey = {
	RelieveAsStu = 7,
	RelieveByMyStu = 11,
	GraduatedOfMyClassMate = 4,
	InvitationToBecomeStu = 2,
	RecruitClassMate = 12,
	RecruitStu = 14,
	RelieveByMyClassMate = 9,
	RelieveAsTea = 8,
	RelieveByMyTea = 10,
	RecruitTea = 13,
	GraduatedOfMyStu = 6,
	GraduatedOfMySelf = 5,
	InvitationToBecomeTea = 3
}
GameEnum.PrizeState = {
	IsNotEnough = 2,
	IsHasGain = 3,
	IsCanGet = 1
}
GameEnum.FormTeamClientDealType = {
	MagicSchoolPvP = 4,
	LingShenChallenge = 3,
	DrawAndGuess = 5,
	HolyStripe = 1,
	StarGodChallenge = 2
}
GameEnum.FormTeamAutoReadyState = {
	Auto = 1,
	Not_Play_Before = 0,
	Not_Ready = 2
}
GameEnum.ColorConst = {
	Green = "#20b376",
	Red = "#eb4642"
}
GameEnum.CycleRedType = {
	Week = 1,
	Day = 0,
	Moon = 2
}
GameEnum.KingDragonType = {
	Stage = 2,
	Unit = 3,
	Boss = 1
}
GameEnum.ModelTypeAsCOR = {
	CAKE = 3,
	BOSS = 4,
	SHOW = 5,
	JIGSAW = 2,
	Orign = 0,
	ANSWER = 1
}
GameEnum.ExitReasonAsCORAnswer = {
	NoEnergy = 1,
	ExProgress = 3,
	ExLimit = 2
}
GameEnum.ResultCode = {
	IsMaxLimitOfTimes = 26,
	NotPrizeCanGet = 12,
	AllPass = 11,
	NotPassLast = 20,
	ErrorTime = 3,
	IsHasVote = 17,
	PunctuationFailed = 19,
	Success = 0,
	IsPassJigsaw = 14,
	NotUnlockCond = 7,
	IsHasGain = 24,
	NotInActTime = 23,
	IsPurchased = 22,
	NotPass = 28,
	IsMaxLimit = 25,
	NotEnoughNum = 9,
	NoEnergy = 13,
	IsNil = 18,
	IsCollectEnough = 15,
	HasUnlock = 8,
	HasSure = 10,
	InTime = 5,
	Error = 30,
	IsDoingAnim = 27,
	IsPass = 1,
	ErrorLevel = 29,
	NotInTime = 2,
	BeforeTime = 4,
	NotEnoughProgress = 21,
	AfterTime = 6,
	NotEnoughTimes = 16
}
GameEnum.AnimOper = {
	Ready = 0,
	Clear = 1
}
GameEnum.PeakTournamentStep = {
	TopExhibition = 3,
	Eliminator = 2,
	Qualifier = 1
}
GameEnum.FamilyMemberType = {
	Common = 4,
	Elite = 3,
	ChiefVice = 1,
	ChiefMain = 0,
	Elder = 2
}
GameEnum.FamilyActivityType = {
	FamilyHoudingClg = 9,
	Task = 2,
	RedEnvelope = 7,
	FamilyPartyClg = 10,
	GodStatuesWar = 12,
	FamilyTutengClg = 11,
	Escort = 5,
	FamilyShop = 8,
	TeamPlay = 1,
	Battle = 4,
	Contribution = 3,
	FamilyWar = 6
}
GameEnum.FamilyRankType = {
	MemberRank = 1,
	FamilyRank = 0
}
GameEnum.FalIdentity = {
	Nothing = 0,
	Farmer = 2,
	Landlord = 1
}
GameEnum.TimeTxt = {
	M_D_H = 2,
	CN_M_D_H = 1,
	Y_M_D_H = 3
}
GameEnum.GoddessCollector_PrizeType = {
	VERIFICATION_PRIZE = 3,
	PET_PRIZE = 1,
	SKIN_PRIZE = 2
}
GameEnum.LotusBattleMissionStep = {
	Two = 2,
	One = 1
}
GameEnum.LotusBattleGameState = {
	Default = 0,
	ShowFormation = 8,
	SelectInitBuff = 5,
	SelectInitPet = 4,
	EnterBattle = 9,
	StartMatch = 2,
	EnterBattleField = 14,
	ForceFinishBattle = 15,
	EnterMainView = 1,
	ShowBattleResult = 10,
	SelectPetInWin = 11,
	SelectPetInEnd = 12,
	GameEndResutl = 13,
	MatchFail = 3,
	MissionSecond = 7,
	MinssionFirst = 6
}
GameEnum.TrainQiecuoTeamOpType = {
	Other = 2,
	My = 1
}
GameEnum.KingjiChallengeType = {
	Shizhe = 1,
	Hun = 2,
	Ronghe = 3
}
GameEnum.ElementSparkStageType = {
	Result = 3,
	Signup = 1,
	Battle = 2,
	RandomAssigned = 0,
	Notopen = -1
}
GameEnum.ElementChallengeType = {
	Boss = 2,
	Guard = 1
}
GameEnum.ElementSparkChunkType = {
	Spark = "spark",
	Guard = "guard",
	PetShop = "petShop",
	Camp = "camp",
	Blank = "blank",
	Resource = "resource"
}
GameEnum.ElementSparkTagType = {
	Retreat = 3,
	Attack = 1,
	Defend = 2
}
GameEnum.DivinesuperdragonClgType = {
	SuperStage = 2,
	BuffStage = 1
}
GameEnum.KingSpaceDragonClgMonsterType = {
	Time = 1,
	Space = 2
}
GameEnum.DivineLongyanClgType = {
	Line = 2,
	Power = 1
}
GameEnum.Test = {
	Test = 1
}
GameEnum.HeartofjieshenclgFmtType = {
	Chi = 2,
	Yi = 1
}
GameEnum.HolyStripeSelectType = {
	Suit = 1,
	AttrType = 3,
	Pos = 2,
	Status = 4
}
GameEnum.HolyStripeStatusFilterType = {
	Discard = 1
}
GameEnum.HolyStripeStatusFilterTypeName = {
	[GameEnum.HolyStripeStatusFilterType.Discard] = "弃置"
}
GameEnum.TonglingShiRaceType = {
	Water = 2,
	Fire = 4,
	Grass = 1,
	Light = 5,
	Dark = 3
}
GameEnum.TonglingShiRaceTypeName = {
	[GameEnum.TonglingShiRaceType.Grass] = "草",
	[GameEnum.TonglingShiRaceType.Water] = "水",
	[GameEnum.TonglingShiRaceType.Dark] = "暗",
	[GameEnum.TonglingShiRaceType.Fire] = "火",
	[GameEnum.TonglingShiRaceType.Light] = "光"
}
GameEnum.StickCoupletNormalType = {
	Left = 0,
	Right = 1
}
GameEnum.StickCoupletSelectType = {
	Correct = 1,
	Fault = 2,
	Empty = 0
}
GameEnum.FmtBaseAttrRateTypes = {
	GameEnum.AttrType.HpRate,
	GameEnum.AttrType.AttackRate,
	GameEnum.AttrType.DefensePhysicalRate,
	GameEnum.AttrType.DefenseMagicRate,
	GameEnum.AttrType.SpeedRate
}
GameEnum.FmtBaseAttrTypes = {
	GameEnum.AttrType.Hp,
	GameEnum.AttrType.Attack,
	GameEnum.AttrType.DefensePhysical,
	GameEnum.AttrType.DefenseMagic,
	GameEnum.AttrType.Speed
}
GameEnum.PlayerSettingSwitchBitPos = {
	SOUND_EFFECT = 1,
	SHOW_OTHER = 5,
	SHOW_FOLLOW_PET = 4,
	ACCEPT_CHALLENGE = 6,
	MAIL_OUTDATE_REMIND = 8,
	LING_WEN_STOP_TRIGGER = 10,
	ALLOW_STRANGER_CHAT = 11,
	NO_SHOW_VIP_LV = 12,
	SHARE_BOSS_STOP_TRIGGER = 9,
	SHOW_FAMILY_MEMBER = 2,
	SHOW_BUDDY = 3,
	QUICK_SHARE = 7,
	MUSIC = 0
}
GameEnum.SourceEffectModuleTypeCN = {
	Equipment = "装备",
	Mount = "坐骑",
	HolyStripe = "灵纹",
	CutePet = "萌宠"
}
GameEnum.AttrModelType = {
	Awaken = "觉醒",
	Rune = "星座",
	Decoration = "饰品",
	Assist = "助战之力",
	Hoshigami = "未定义",
	Throne = "神器",
	Goodfelling = "好感度",
	Book = "图鉴",
	CutePet = "萌宠",
	Animal = "宠物园",
	SourceTrace = "源核",
	HolyStripe = "灵纹",
	FormStrength = "阵法",
	StarGodPlus = "星神",
	Relation = "收集羁绊",
	Equipment = "装备",
	Talent = "天赋",
	Base = "等级",
	Team = "上阵羁绊",
	Mount = "坐骑",
	Skin = "皮肤"
}
GameEnum.PrivilegeType = {
	ChatWordEffect = 36,
	SkipGameLingWenExport = 38
}
GameEnum.VERIFYTYPE_POWER = "战力"
GameEnum.VERIFYTYPE_LEVEL = "等级"
GameEnum.VERIFYTYPE_STARLEVEL = "星级"
GameEnum.VERIFYTYPE = {
	等级 = 2,
	星级 = 3,
	战力 = 1
}
GameEnum.HolyStripeAttrType = {
	AttackPhysical = 2,
	SuperAttackReduce = 37,
	Attack = 15,
	AttackRate = 25,
	AttackMagicRate = 20,
	AntiCriticalRate = 14,
	HpRate = 17,
	DodgeRate = 10,
	IncidentalDamge = 29,
	RestrainAddDamge = 28,
	NormalAttackDamge = 34,
	SuperAttackDamge = 35,
	SpeedRate = 24,
	DefensePhysical = 3,
	NormalAttackReduce = 36,
	AOEDamage = 27,
	CriticalDamage = 26,
	HitRate = 9,
	AttackPhysicalRate = 18,
	AttackMagic = 4,
	PhysicalDamageDeduce = 30,
	DefenseMagicRate = 21,
	AttackSuperRate = 22,
	DefenseSuperRate = 23,
	DefenseMagic = 5,
	AOEDamageDeduce = 32,
	DefenseSuper = 7,
	CriticalRate = 13,
	BlockRate = 12,
	OriginalVigour = 16,
	ReboundDamage = 33,
	MagicDamageDeduce = 31,
	AttackSuper = 6,
	Hp = 1,
	DefensePhysicalRate = 19,
	Speed = 8,
	StrikeRate = 11
}
GameEnum.HolyStripeAttrTypeName = {
	"生命",
	"物攻",
	"物防",
	"魔攻",
	"魔防",
	"超攻",
	"超防",
	"速度",
	"命中率",
	"闪避率",
	"破击率",
	"格挡率",
	"暴击率",
	"防暴率",
	"攻击",
	"起始气势",
	"生命率",
	"物攻率",
	"物防率",
	"魔攻率",
	"魔防率",
	"超攻率",
	"超防率",
	"速度率",
	"攻击率",
	"暴击伤害",
	"群攻伤害",
	"克制增伤",
	"附带伤害",
	"物伤减免",
	"魔伤减免",
	"群攻减伤",
	"反弹伤害",
	"普攻增伤",
	"超杀增伤",
	"普攻减伤",
	"超杀减伤"
}
GameEnum.BusinessJudgmentZh = {
	STAR = "星级",
	OTHER = "其他",
	OUR_SIDE = "我方",
	ATTRIBUTE = "属性",
	CLAIMED = "已领取",
	TOTAL_AWAKEN = "总觉醒",
	MDEF_RATE = "魔防率",
	HP_RATE = "生命率",
	POSITION = "站位",
	PATK_RATE = "物攻率",
	POTENTIAL_POTION = "潜能药水",
	CAREER = "职业",
	TOTAL_LEVEL = "总等级",
	CONTENT = "内容",
	TARGET = "目标",
	AWAKEN = "觉醒",
	TRIGGER = "触发",
	NOT_TRIGGERED = "未触发",
	SUPER_DEF_RATE = "超防率",
	RARITY = "稀有度",
	MALE = "男性",
	RATE = "率",
	NORMAL = "普通",
	NorAttack = "普攻",
	TIME_SLOT = "时段",
	LEVEL = "等级",
	Fire = "火",
	Dark = "暗",
	ALLY_FORMATION = "己阵",
	FRONT_ROW = "前排",
	ENEMY_FORMATION = "敌阵",
	WEEKLY = "每周",
	SUPER_ATK_RATE = "超攻率",
	TOTAL_STAR = "总星级",
	MONTHLY = "每月",
	ALL_DAY = "全天",
	ALLY = "己方",
	ALL = "全体",
	CAN_RECLAIM = "可补领",
	ATTACK = "攻击",
	PDEF_RATE = "物防率",
	CAN_CLAIM = "可领取",
	ENEMY = "敌方",
	HOT = "热",
	MATK_RATE = "魔攻率",
	Overdrive = "超杀",
	NOT_TIME = "未到时间",
	EASY = "简单",
	NONE = "无"
}
GameEnum.AssignmentConditionType = {
	Num = 1,
	Rarity = 2,
	Career = 5,
	TotalLevel = 6,
	TotalAwaken = 7,
	Awaken = 3,
	Attr = 4,
	Level = 8
}
GameEnum.AssignmentConditionText = {
	[GameEnum.AssignmentConditionType.Num] = "数量",
	[GameEnum.AssignmentConditionType.Rarity] = "稀有度",
	[GameEnum.AssignmentConditionType.Awaken] = "觉醒",
	[GameEnum.AssignmentConditionType.Attr] = "属性",
	[GameEnum.AssignmentConditionType.Career] = "职业",
	[GameEnum.AssignmentConditionType.TotalLevel] = "总等级",
	[GameEnum.AssignmentConditionType.TotalAwaken] = "总觉醒",
	[GameEnum.AssignmentConditionType.Level] = "等级"
}
GameEnum.PeriodRefreshTypeByStr = {
	weekly = 2,
	allTime = 4,
	monthly = 3,
	daily = 1,
	none = 0
}
GameEnum.PeriodRefreshType = {
	Weekly = 2,
	Monthly = 3,
	AllTime = 4,
	Daily = 1,
	None = 0
}

return GameEnum
