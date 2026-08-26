-- chunkname: @modules/logic/fight/config/FightEnum.lua

module("modules.logic.fight.config.FightEnum", package.seeall)

local FightEnum = _M

FightEnum.StepEffectCountLimit = 50
FightEnum.UniversalCard1 = 30000001
FightEnum.UniversalCard2 = 30000002
FightEnum.UniversalCard = {
	[FightEnum.UniversalCard1] = FightEnum.UniversalCard1,
	[FightEnum.UniversalCard2] = FightEnum.UniversalCard2
}
FightEnum.MaxBehavior = 9
FightEnum.MaxBuffIconCount = 8
FightEnum.FightReason = {
	Dungeon = 2,
	DungeonRecord = 3,
	None = 1
}
FightEnum.EffectLookDir = {
	Left = 0,
	Right = 180
}
FightEnum.Rotation = {
	Thas = 270,
	Ohae = 180,
	Ninety = 90,
	Zero = 0
}
FightEnum.RotationQuaternion = {
	Zero = Quaternion.AngleAxis(0, Vector3.up),
	Ninety = Quaternion.AngleAxis(90, Vector3.up),
	Ohae = Quaternion.AngleAxis(180, Vector3.up),
	Thas = Quaternion.AngleAxis(270, Vector3.up)
}
FightEnum.SideUid = {
	MySide = "0",
	EnemySide = "-99999"
}
FightEnum.EntitySide = {
	EnemySide = 2,
	BothSide = 3,
	MySide = 1
}
FightEnum.TeamType = {
	MySide = 1,
	EnemySide = 2
}
FightEnum.EntityGOName = {
	MySide = "Player",
	EnemySide = "Monster"
}
FightEnum.PurifyId = {
	PurifyX = 20020,
	Purify1 = 20003,
	Purify2 = 20004
}
FightEnum.PurifyName = {
	[FightEnum.PurifyId.Purify1] = "Purify1",
	[FightEnum.PurifyId.Purify2] = "Purify2",
	[FightEnum.PurifyId.PurifyX] = "PurifyX"
}
FightEnum.FloatType = {
	restrain = 5,
	crit_heal = 3,
	crit_berestrain = 2,
	buff = 9,
	shield_berestrain = 103,
	secret_key = 19,
	additional_damage = 16,
	shield_damage = 101,
	shield_restrain = 102,
	equipeffect = 0,
	crit_additional_damage = 17,
	addShield = 18,
	total_origin = 14,
	damage_origin = 12,
	crit_restrain = 1,
	berestrain = 6,
	damage = 8,
	crit_damage = 4,
	total = 11,
	stress = 15,
	crit_damage_origin = 13,
	miss = 10,
	heal = 7
}
FightEnum.UniformDefAudioId = 440000130
FightEnum.AudioSwitchGroup = "Checkpointstate"
FightEnum.AudioSwitch = {
	Fightboss = "Fightboss",
	Victory = "Victory",
	Fightend = "Fightend",
	Plotcg = "Plotcg",
	Checkpointend = "Checkpointend",
	Losing = "Losing",
	Fightnormal = "Fightnormal",
	Plotdialogue = "Plotdialogue",
	Comeshow = "Comeshow",
	Bosswarning = "Bosswarning"
}
FightEnum.WeaponHitSwitchGroup = "bigka_common_group"
FightEnum.WeaponHitSwitchNames = {
	[0] = "nothing",
	"air",
	"arrow",
	"arrow_air",
	"arrow_fire",
	"arrow_wind",
	"bite",
	"dagger",
	"electric",
	"explode",
	"fire",
	"glass",
	"grass",
	"light",
	"little",
	"metal",
	"mud",
	"punch",
	"snow",
	"star",
	"stone_heavy",
	"stone_light",
	"sword",
	"water",
	"wind"
}
FightEnum.RenderOrderType = {
	ZPos = 2,
	StandPos = 1,
	SameOrder = 3
}
FightEnum.ActType = {
	CHANGEWAVE = 5,
	EFFECT = 3,
	CHANGEHERO = 4,
	SKILL = 1,
	DEVICE = 6,
	BUFF = 2
}
FightEnum.EffectType = {
	MASTERHALO = 172,
	MAGICCIRCLEDELETE = 139,
	DELCARDANDDAMAGE = 249,
	PASSIVESKILLINVALID = 99,
	ROGUECOINCHANGE = 143,
	CURECORRECT = 259,
	EXSKILLNOCONSUMPTION = 83,
	RESISTANCESATTR = 221,
	TOUGHNESSCHANGE = 370,
	ROGUEESCAPE = 145,
	USECARDS = 159,
	DISPERSE = 14,
	ADDMAXROUND = 356,
	HALOBASE = 92,
	FREEZE = 104,
	SKILLLEVELJUDGEADD = 209,
	FIXEDHURT = 74,
	ENTERTEAMSTAGE = 200,
	ADDTOATTACKER = 42,
	SHAREHURT = 282,
	USECARDFIXEXPOINT = 254,
	TAUNT = 37,
	MASTERADDHANDCARD = 197,
	HIDELIFE = 100,
	ATTR = 26,
	BUFFADDNOEFFECT = 55,
	RESONANCELEVEL = 184,
	RESONANCEDECCARD = 180,
	INDICATORCHANGE = 117,
	CLEARUNIVERSALCARD = 96,
	BUFFTYPENUMLIMITUPDATE = 204,
	MONSTERSPLIFE = 112,
	CHANGESCENE = 364,
	POWERCANTDECR = 151,
	MOVECARD = 376,
	FIGHTSTEP = 162,
	ADDTOTARGET = 50,
	CURE2 = 43,
	SUBHEROLIFECHANGE = 235,
	ENCHANTBURNDAMAGE = 202,
	BUFFADD = 5,
	PROTECT = 22,
	MULTIHPCHANGE = 125,
	SAVEFIGHTRECORDUPDATE = 316,
	ORIGINDAMAGE = 130,
	CUREUPBYLOSTHP = 347,
	MAGICCIRCLEADD = 138,
	REGAINPOWER = 146,
	RIGID = 79,
	EMITTERNUMCHANGE = 285,
	MASTERPOWERCHANGE = 148,
	SUMMONEDADD = 134,
	CHANGEHERO = 107,
	ADDBUFFROUNDBYSKILL = 223,
	ADDCARDLIMIT = 102,
	RESONANCEADDLEVEL = 181,
	SHIELD = 25,
	ADDUSECARD = 215,
	ZXQREMOVECARD = 258,
	DIZZYRESIST = 49,
	POLARIZATIONADDLEVEL = 177,
	CURE = 27,
	TRIGGER = 999,
	ROUGESPCARDADD = 191,
	CARDSPUSH = 154,
	ASSISTBOSSSKILLCD = 252,
	POWERINFOCHANGE = 295,
	ALLOCATECARDENERGY = 276,
	BUFFDEL = 6,
	EZIOBIGSKILLDAMAGE = 1000,
	CARDLEVELADD = 65,
	INSERTHANDCARD = 378,
	ADDACT = 15,
	EZIOBIGSKILLEXIT = 1003,
	BURN = 137,
	ANANFOCUSBUFF = 366,
	COPYBUFFBYKILL = 225,
	SKILLRATEUP = 90,
	RESONANCEACTIVE = 186,
	BREAKSHIELD = 229,
	LAYERSLAVEHALO = 232,
	ENTERFIGHTDEAL = 233,
	COLD = 80,
	EMITTEREXTRADEMAGE = 367,
	IMMUNITY = 33,
	HARMSTATISTIC = 114,
	UPDATECARDDATA = 377,
	DEADLYPOISONORIGINDAMAGE = 263,
	ASSISTBOSSSKILLCHANGE = 265,
	ADDBUFFROUND = 64,
	ADDITIONALDAMAGE = 267,
	ACT174FIRST = 269,
	TRANSFERADDSTRESS = 245,
	ROUGEPOWERLIMITCHANGE = 188,
	ADDEXPOINT = 17,
	TRANSFERADDEXPOINT = 240,
	TOWERSCORECHANGE = 272,
	BLOODLUST = 12,
	DEADLYPOISONORIGINCRIT = 264,
	CARDREMOVE = 133,
	STRESSTRIGGER = 230,
	EXPOINTCARDMOVE = 72,
	EMITTERSKILLEND = 278,
	ROUGE2CHECK = 362,
	CARDREMOVE2 = 155,
	EMITTERCAREERCHANGE = 284,
	SILENCE = 24,
	USESKILLTEAMADDEMITTERENERGY = 288,
	SMALLROUNDEND = 211,
	CALLMONSTERTOSUB = 293,
	FIXATTRTEAMENERGYANDBUFF = 294,
	ATTACKALTER = 10,
	POLARIZATIONACTIVE = 185,
	EMITTERMAINTARGET = 297,
	CONDITIONSPLITEMITTERNUM = 298,
	EMITTERTAG = 286,
	RESONANCEEXSKILLADD = 182,
	MUSTCRITBUFF = 301,
	MOVEFRONT = 207,
	EMITTERFIGHTNOTIFY = 300,
	ADDSPLITEMITTERNUM = 299,
	MUSTCRIT = 302,
	POISONSETTLECANCRIT = 226,
	REDORBLUECOUNTCHANGE = 306,
	CARDDECKNUM = 310,
	EMITTERCREATE = 280,
	STORAGEDAMAGE = 312,
	MONSTERLABELBUFF = 126,
	BUFFUPDATE = 7,
	ENCHANTDEPRESSEDAMAGE = 314,
	NOTIFYUPGRADEHERO = 174,
	FIXEDDAMAGE = 98,
	SAVEFIGHTRECORDSTART = 315,
	EXPOINTCANTADD = 63,
	CHANGETOTEMPCARD = 141,
	SAVEFIGHTRECORDEND = 317,
	CONTRANCT = 242,
	CANTSELECT = 95,
	SAVEFIGHTRECORD = 319,
	ADDSPHANDCARD = 320,
	NONCAREERRESTRAINT = 321,
	CLEARMONSTERSUB = 322,
	PROGRESSMAXCHANGE = 256,
	FIGHTTASKUPDATE = 323,
	RETAINSLEEP = 324,
	KILL = 110,
	GUARDCHANGE = 236,
	LAYERMASTERHALO = 231,
	BFSGUSECARD = 157,
	REMOVEMONSTERSUB = 325,
	DIRECTUSEEXSKILL = 327,
	FIGHTPARAMCHANGE = 330,
	TWINSPOWERUPCOUNT = 1004,
	BLOODPOOLMAXCHANGE = 334,
	BLOODPOOLVALUECHANGE = 335,
	CLIENTEFFECT = 339,
	NUODIKARANDOMATTACK = 341,
	EXTRAMOVEACT = 77,
	NUODIKATEAMATTACK = 342,
	TRIGGERANALYSIS = 343,
	IGNORECOUNTER = 164,
	SURVIVALHEALTHCHANGE = 345,
	BFSGCONVERTCARD = 156,
	PROGRESSCHANGE = 251,
	RANDOMDICEUSESKILL = 353,
	MOCKTAUNT = 201,
	ORIGINCRIT = 131,
	REDORBLUECOUNTEXSKILL = 311,
	TOWERDEEPCHANGE = 354,
	ROUNDOFFSET = 318,
	TEAMENERGYCHANGE = 275,
	FIGHTHURTDETAIL = 355,
	DEVICERUNNING = 379,
	CHANGECAREER = 97,
	CRYSTALSELECT = 358,
	PURIFY = 13,
	INJURY = 34,
	CARDDECKCLEAR = 279,
	SHIELDBROCKEN = 132,
	REBOUND = 36,
	INDICATORDIFFCHANGE = 363,
	CARDLEVELCHANGE = 75,
	HEROUPGRADE = 171,
	DAMAGEEXTRA = 18,
	CANTGETEXSKILL = 129,
	UPDATEITEMPLAYERSKILL = 1002,
	EXTCAREERWEAK = 368,
	REDORBLUECHANGETRIGGER = 307,
	TOUGHNESSRECOVER = 369,
	PLAYSETGRAY = 220,
	BUFFERFLYADDHANDCARD = 371,
	DEAD = 9,
	INITDEVICE = 372,
	STORAGEINJURY = 167,
	DEVICESKILLINDEX = 373,
	EXPOINTFIX = 39,
	DEVICEPOWERCHANGE = 374,
	CARDACONVERTCARDB = 170,
	DEADLYPOISON = 255,
	ASSISTBOSSCHANGE = 260,
	ROUGECOINCHANGE = 190,
	CRITPILEUP = 51,
	ROGUEHEARTCHANGE = 142,
	EMITTERREMOVE = 287,
	ROUGEPOWERCHANGE = 189,
	PLAYAROUNDUPRANK = 218,
	SIMPLEPOLARIZATIONLEVEL = 291,
	INJURYBANKHEAL = 195,
	UNNAMEDSTRENGTHEN = 380,
	COUNTERCHANGE = 381,
	DEALCARD2 = 60,
	DEVICEPOWERCLEAR = 382,
	MISS = 1,
	DEVICESTOP = 383,
	BUFFATTR = 71,
	SHIELDDEL = 62,
	FROZEN = 23,
	CHANGESHIELD = 271,
	SIMPLEPOLARIZATIONADDLEVEL = 292,
	SUMMON = 86,
	SHIELDCHANGE = 41,
	EZIOBIGSKILLORIGINDAMAGE = 1001,
	PALSY = 81,
	DODGESPECSKILL2 = 53,
	GETSECRETKEY = 344,
	SKILLPOWERUP = 88,
	MAXHPCHANGE = 108,
	BLOODPOOLMAXCREATE = 333,
	TWINSUPCOUNTER = 1005,
	ADDCARD = 16,
	FIXATTRTEAMENERGY = 289,
	POWERCHANGE = 128,
	DEALCARD1 = 59,
	CANTCRIT = 45,
	COLDSATURDAYHURT = 336,
	ROUGE2MUSICBALLCHANGE = 361,
	BFSGSKILLEND = 158,
	SPCARDADD = 78,
	ROUGE2MUSICCARDCHANGE = 360,
	CANTSELECTEX = 105,
	REALDAMAGEKILL = 351,
	CARDEFFECTCHANGE = 85,
	SIMPLEPOLARIZATIONADDLIMIT = 296,
	ACT174MONSTERAICARD = 273,
	ADDHANDCARD = 149,
	BUFFDELNOEFFECT = 56,
	SLEEP = 31,
	CARDHEATVALUECHANGE = 309,
	AVERAGELIFE = 40,
	DAMAGESHAREHP = 253,
	LOCKBURN = 266,
	INJURYLOGBACK = 168,
	SLEEPRESIST = 47,
	UNIVERSALCARD = 58,
	REDORBLUECOUNT = 305,
	RETAINPERTRIFIED = 262,
	PLAYERFINISHERSKILLCHANGE = 283,
	RESISTANCES = 222,
	DAMAGEFROMABSORB = 192,
	IGNOREDODGESPECSKILL = 163,
	POLARIZATIONLEVEL = 183,
	NOUSECARDENERGYRECORDBYROUND = 348,
	EXSKILLPOINTCHANGE = 113,
	GUARDBREAK = 246,
	CARDAREAREDORBLUE = 303,
	PLAYCHANGERANKFAIL = 224,
	FROZENRESIST = 48,
	DAMAGEFROMLOSTHP = 193,
	MASTERCARDREMOVE = 196,
	CHANGEWAVE = 227,
	ADDITIONALDAMAGECRIT = 268,
	BECONTRANCTED = 243,
	REALHURTFIXWITHLIMIT = 203,
	CAREERRESTRAINT = 166,
	MOVE = 206,
	ABSORBHURT = 169,
	POLARIZATIONEXSKILLADD = 178,
	CHANGECARDENERGY = 338,
	POLARIZATIONDECCARD = 176,
	CONFUSION = 261,
	DEFENSEALTER = 11,
	BUFFRATEUP = 89,
	EXPOINTADD = 68,
	SPEXPOINTMAXADD = 244,
	DISARM = 29,
	AFTERREDEALCARD = 274,
	CRIT = 3,
	RESONANCEADDLIMIT = 179,
	RECORDTEAMINJURYCOUNT = 194,
	ADDCARDRECORDBYROUND = 326,
	EXPOINTCARDUPGRADE = 73,
	REMOVEENTITYCARDS = 152,
	SPLITEND = 329,
	BUFFREJECT = 19,
	SUMMONEDDELETE = 135,
	CARDDECKGENERATE = 247,
	CARDSCOMPOSE = 153,
	MOVEBACK = 208,
	DOT = 35,
	IMMUNITYEXPOINTCHANGE = 66,
	SELECTLAST = 94,
	EXPOINTMAXADD = 91,
	EXPOINTADDAFTERDELORABSORBEXPOINT = 84,
	CARDINVALID = 160,
	NONE = 0,
	PERTRIFIED = 32,
	LOCKHP = 205,
	EXPOINTOVERFLOWBANK = 214,
	TOCARDAREAREDORBLUE = 304,
	MONSTERCHANGE = 67,
	MAGICCIRCLEUPGRADE = 340,
	LAYERHALOSYNC = 234,
	NEWCHANGEWAVE = 337,
	BUFFACTINFOUPDATE = 350,
	CARDHEATINIT = 308,
	OVERFLOWPOWERADDBUFF = 150,
	POLARIZATIONADDLIMIT = 175,
	PLAYAROUNDDOWNRANK = 219,
	NUODIKARANDOMATTACKNUM = 349,
	DUDUBONECONTINUECHANNEL = 257,
	BUFFDELREASON = 352,
	TOUGHNESSRESET = 375,
	ADDTOBUFFENTITY = 147,
	CURRENTHPCHANGE = 109,
	ADDBUFFROUNDBYTYPEID = 82,
	IGNOREBEATBACK = 199,
	SKILLWEIGHTSELECT = 87,
	BFSGSKILLSTART = 161,
	FORBID = 30,
	DAMAGE = 2,
	HALOSLAVE = 93,
	HEALCRIT = 57,
	EXPOINTCHANGE = 111,
	NOTIFIYHEROCONTRACT = 241,
	ELUSIVE = 313,
	BEATBACK = 38,
	SHIELDVALUECHANGE = 228,
	MAGICCIRCLEUPDATE = 140,
	DIZZY = 20,
	ROGUESAVECOIN = 144,
	ENTITYSYNC = 238,
	CATAPULTBUFF = 217,
	ROUGEREWARD = 187,
	POWERMAXADD = 127,
	CHANGEROUND = 212,
	ACT174USECARD = 270,
	ADDONCECARD = 281,
	CHARM = 250,
	EXPOINTDEL = 69,
	REDEALCARD = 54,
	PETRIFIEDRESIST = 46,
	BUFFREPLACE = 76,
	ADDSKILLBUFFCOUNTANDDURATION = 116,
	IGNOREREBOUND = 165,
	LOCKDOT = 216,
	INVINCIBLE = 21,
	TEAMMATEINJURYCOUNT = 210,
	EMITTERENERGYCHANGE = 277,
	CRYSTALADDCARD = 359,
	ROUNDEND = 61,
	DODGESPECSKILL = 52,
	RADIANCE = 357,
	HEAL = 4,
	OVERFLOWHEALTOSHIELD = 115,
	SUMMONEDLEVELUP = 136,
	LOCKHPMAX = 346,
	FIGHTCOUNTER = 198,
	SIMPLEPOLARIZATIONACTIVE = 290,
	FORBIDSPECEFFECT = 44,
	CARDDECKDELETE = 248,
	ADDBUFFROUNDBYTYPEGROUP = 103,
	SPLITSTART = 328,
	SEAL = 28,
	PRECISIONREGION = 239,
	POISON = 213,
	LOCKBULLETCOUNTDECR = 237,
	CARDDISAPPEAR = 106,
	BUFFADDACT = 101,
	DAMAGENOTMORETHAN = 70,
	SLAVEHALO = 173,
	BUFFEFFECT = 8
}
FightEnum.BuffEffectType = {
	[FightEnum.EffectType.BUFFADD] = true,
	[FightEnum.EffectType.BUFFDEL] = true,
	[FightEnum.EffectType.BUFFUPDATE] = true,
	[FightEnum.EffectType.BUFFDELNOEFFECT] = true
}
FightEnum.EnchantedType = {
	Blockade = 10005,
	Ramona = 10011,
	Frozen = 10001,
	Chaos = 10003,
	Degradation = 10012,
	Rouge2_Treasure = 10009,
	Precision = 10006,
	Discard = 10004,
	depresse = 10007,
	Refrigerator = 10013,
	Burn = 10002,
	Lorenz = 10010,
	Rouge2_Double = 10008
}
FightEnum.EnchantNumLimit = 6
FightEnum.CardOpType = {
	Season2ChangeHero = 5,
	SimulateDissolveCard = -99,
	Rouge2Music = -100,
	AssistBoss = 4,
	PlayCard = 2,
	BloodPool = 7,
	MoveCard = 1,
	PlayerFinisherSkill = 6,
	MoveUniversal = 3
}
FightEnum.FightResult = {
	Abort = -1,
	OutOfRoundFail = 2,
	Fail = 0,
	Succ = 1
}
FightEnum.TargetLimit = {
	EnemySide = 1,
	MySide = 2,
	None = 0
}
FightEnum.ShowLogicTargetView = {
	["1"] = true
}
FightEnum.CondTargetHpMin = 109
FightEnum.LogicTargetClassify = {
	Special = {
		["0"] = 1
	},
	MySideAll = {
		["105"] = 1,
		["101"] = 1,
		["104"] = 1,
		["102"] = 1
	},
	Me = {
		["103"] = 1
	},
	Single = {
		["107"] = 1,
		["204"] = 1,
		["108"] = 1,
		["106"] = 1,
		["303"] = 1,
		["1"] = 1,
		["205"] = 1,
		["207"] = 1
	},
	SingleAndRandom = {
		["201"] = 1,
		["206"] = 1
	},
	EnemySideAll = {
		["302"] = 1,
		["202"] = 1,
		["301"] = 1
	},
	EnemySideindex = {
		["228"] = 1,
		["227"] = 1,
		["229"] = 1,
		["226"] = 1
	},
	EnemyMostHp = {
		["208"] = 1
	},
	EnemyWith101Buff = {
		["4101"] = 1
	},
	SecondaryTarget = {
		["216"] = 1
	},
	StanceAndBefore = {
		["120"] = 1
	},
	StanceAndAfter = {
		["122"] = 1
	},
	Position = {
		["224"] = 3,
		["223"] = 2,
		["225"] = 4,
		["222"] = 1
	},
	EnemyWith795Feature = {
		["307"] = 1
	}
}
FightEnum.FightBonusTag = {
	AdvencedBonus = 3,
	NormalBonus = 2,
	AdditionBonus = 4,
	EquipDailyFreeBonus = -1,
	TimeFirstBonus = 5,
	FirstBonus = 1,
	SimpleBouns = 6,
	ActBonus = 100
}
FightEnum.FightBonusTagPriority = {
	[FightEnum.FightBonusTag.TimeFirstBonus] = 1,
	[FightEnum.FightBonusTag.AdditionBonus] = 2,
	[FightEnum.FightBonusTag.NormalBonus] = 3,
	[FightEnum.FightBonusTag.FirstBonus] = 4,
	[FightEnum.FightBonusTag.AdvencedBonus] = 5
}
FightEnum.DropType = {
	Act158 = 5,
	Normal2Simple = 6,
	Act153 = 4,
	TurnBack = 1,
	Act217 = 7,
	Act155 = 3,
	Act135 = 2
}
FightEnum.MySideDefaultStanceId = 100
FightEnum.EnemySideDefaultStanceId = 3
FightEnum.StanceCount = 3
FightEnum.MaxSkillCardLv = 3
FightEnum.UniqueSkillCardLv = 4
FightEnum.TopOrderFactor = 100
FightEnum.OrderRegion = 200
FightEnum.GameSpeedRTPC = "GameSpeed"
FightEnum.HitStatusGroupName = "Hit_Status_Group"
FightEnum.HitStatusArr = {
	"General_attack",
	"Critical_strike"
}
FightEnum.HitMaterialGroupName = "Hit_Material_Group"
FightEnum.HitMaterialArr = {
	[0] = "nothing",
	"Metal",
	"Succulent",
	"Ligneous"
}
FightEnum.SkillShowTag = {
	Counter = 5,
	SpiritualDamage = 2,
	Buff = 4,
	Debuff = 3,
	Universal = 11,
	RealDamage = 1,
	HealEffect = 6
}
FightEnum.NeedShowRestrainTag = {
	[FightEnum.SkillShowTag.RealDamage] = true,
	[FightEnum.SkillShowTag.SpiritualDamage] = true,
	[FightEnum.SkillShowTag.Debuff] = true,
	[FightEnum.SkillShowTag.Universal] = true
}
FightEnum.LogicTargetDesc = {}

local logicTargetDesc2LangId = {
	["107"] = "logic_target_single",
	["103"] = "logic_target_single",
	["106"] = "logic_target_single",
	["102"] = "logic_target_area",
	["105"] = "logic_target_area",
	["206"] = "logic_target_single",
	["1"] = "logic_target_single",
	["108"] = "logic_target_single",
	["201"] = "logic_target_area",
	["104"] = "logic_target_area",
	["301"] = "logic_target_area",
	["302"] = "logic_target_area",
	["101"] = "logic_target_area",
	["202"] = "logic_target_area",
	["207"] = "logic_target_single"
}

setmetatable(FightEnum.LogicTargetDesc, {
	__index = function(tab, key)
		if logicTargetDesc2LangId[key] then
			return luaLang(logicTargetDesc2LangId[key])
		end

		return ""
	end
})

FightEnum.EffectTag = {
	SpiritAttack = 2,
	CounterSpell = 5,
	Device = 14,
	Sp = 12,
	Heal = 6,
	Buff = 4,
	Channel = 9,
	Choice = 13,
	Control = 7,
	Debuff = 3,
	RealAttack = 1
}
FightEnum.EffectTagDesc = {}

local effectTagDesc2langId = {
	[FightEnum.EffectTag.RealAttack] = "effect_tag_attack",
	[FightEnum.EffectTag.SpiritAttack] = "effect_tag_attack",
	[FightEnum.EffectTag.Debuff] = "effect_tag_debuff",
	[FightEnum.EffectTag.Buff] = "effect_tag_buff",
	[FightEnum.EffectTag.CounterSpell] = "effect_tag_counterspell",
	[FightEnum.EffectTag.Heal] = "effect_tag_heal",
	[FightEnum.EffectTag.Control] = "effect_tag_control"
}

setmetatable(FightEnum.EffectTagDesc, {
	__index = function(tab, key)
		if effectTagDesc2langId[key] then
			return luaLang(effectTagDesc2langId[key])
		end

		return ""
	end
})

FightEnum.BuffIncludeTypes = {
	Stacked15 = "15",
	Stacked12 = "12",
	Count = 9,
	Stacked14 = "14",
	Stacked = "10"
}
FightEnum.FactionToSkin = {
	430001,
	430002,
	430003,
	430004,
	430005,
	430006,
	430007,
	430008,
	430009
}
FightEnum.SpecialFaction = {
	[DungeonEnum.ChapterType.Gold] = true,
	[DungeonEnum.ChapterType.Exp] = true,
	[DungeonEnum.ChapterType.Equip] = true,
	[DungeonEnum.ChapterType.Break] = true,
	[DungeonEnum.ChapterType.SpecialEquip] = true
}
FightEnum.BuffFloatEffectType = {
	Counter = 4,
	Good = 1,
	Poisoning = 5,
	Heal = 3,
	Debuffs = 2
}
FightEnum.SkillBehaviourId = {
	UseCardCopy = 100024
}
FightEnum.BehaviourId = {
	AddDeviceExPoint = 60292,
	AddDevicePower = 60291,
	AddAdrenaline = 100004,
	BufferflyRecordSkill = 60283,
	HedoneAddDevicePower = 60334,
	AddCardRankByEffectTag = 60281,
	FakeHpToHeal = 60309
}
FightEnum.Behavior_AddExPoint = "AddExPoint"
FightEnum.Behavior_DelExPoint = "DelExPoint"
FightEnum.Behavior_LostLife = "LostLife"
FightEnum.Behavior_CatapultBuff = "CatapultBuff"
FightEnum.BuffType_Dizzy = "Dizzy"
FightEnum.BuffType_Charm = "Charm"
FightEnum.BuffType_Petrified = "Petrified"
FightEnum.BuffType_Sleep = "Sleep"
FightEnum.BuffType_Frozen = "Frozen"
FightEnum.BuffType_Disarm = "Disarm"
FightEnum.BuffType_Forbid = "Forbid"
FightEnum.BuffType_Seal = "Seal"
FightEnum.BuffType_Dot = "Dot"
FightEnum.BuffType_Immunity = "Immunity"
FightEnum.BuffType_Freeze = "Freeze"
FightEnum.BuffType_CantSelect = "CantSelect"
FightEnum.BuffType_CantSelectEx = "CantSelectEx"
FightEnum.BuffType_HideLife = "HideLife"
FightEnum.ExPointCantAdd = "ExPointCantAdd"
FightEnum.BuffType_CastChannel = "CastChannel"
FightEnum.BuffType_NoneCastChannel = "NoneCastChannel"
FightEnum.BuffType_ContractCastChannel = "ContractCastChannel"
FightEnum.BuffType_ExPointOverflowBank = "ExPointOverflowBank"
FightEnum.BuffType_SpExPointMaxAdd = "SpExPointMaxAdd"
FightEnum.BuffType_TransferAddExPoint = "TransferAddExPoint"
FightEnum.BuffType_ContractBuff = "ContractBuff"
FightEnum.BuffType_BeContractedBuff = "BeContractedBuff"
FightEnum.BuffType_CountContinueChannel = "CountContinueChannel"
FightEnum.BuffType_DuduBoneContinueChannel = "DuduBoneContinueChannel"
FightEnum.BuffType_DeadlyPoison = "DeadlyPoison"
FightEnum.BuffType_UseCardFixExPoint = "UseCardFixExPoint"
FightEnum.BuffType_ExPointCardMove = "ExPointCardMove"
FightEnum.BuffType_FixAttrTeamEnergyAndBuff = "FixAttrTeamEnergyAndBuff"
FightEnum.BuffType_FixAttrTeamEnergy = "FixAttrTeamEnergy"
FightEnum.BuffType_EmitterCareerChange = "EmitterCareerChange"
FightEnum.BuffType_ChangeEmitterSkill = "ChangeEmitterSkill"
FightEnum.BuffType_CardAreaRedOrBlue = "CardAreaRedOrBlue"
FightEnum.BuffType_RedOrBlueCount = "RedOrBlueCount"
FightEnum.BuffType_RedOrBlueChangeTrigger = "RedOrBlueChangeTrigger"
FightEnum.BuffType_SaveFightRecord = "SaveFightRecord"
FightEnum.BuffType_SubBuff = "SubBuff"
FightEnum.BuffType_AddCardRecordByRound = "AddCardRecordByRound"
FightEnum.BuffType_AddCardCastChannel = "AddCardCastChannel"
FightEnum.BuffType_BigSkillNoUseActPoint = "BigSkillNoUseActPoint"
FightEnum.BuffType_NotBigSkillNoUseActPoint = "NotBigSkillNoUseActPoint"
FightEnum.BuffType_SpecialCountCastBuff = "SpecialCountCastBuff"
FightEnum.BuffType_SpecialCountCastChannel = "SpecialCountCastChannel"
FightEnum.BuffType_SpecialCountContinueChannelBuff = "SpecialCountContinueChannelBuff"
FightEnum.BuffType_LockHpMax = "LockHpMax"
FightEnum.BuffType_NoUseCardEnergyRecordByRound = "NoUseCardEnergyRecordByRound"
FightEnum.BuffType_RealDamageKill = "RealDamageKill"
FightEnum.BuffTypeId_CoverPerson = 8398
FightEnum.BuffTypeId_CelebrityCharm = 8399
FightEnum.BuffFeature = {
	ModifyAttrByBuffLayer = "ModifyAttrByBuffLayer",
	SkillNoUseActPoint = "SkillNoUseActPoint",
	RaspberryBigSkill = "RaspberryBigSkill",
	ResistancesAttr = "ResistancesAttr",
	AttrFixFromInjuryBank = "AttrFixFromInjuryBank",
	PrecisionRegion = "PrecisionRegion",
	CountUseSelfSkillContinueChannel = "CountUseSelfSkillContinueChannel",
	AttrFromEntityNoLayer = "AttrFromEntityNoLayer",
	FoundationCounter = "FoundationCounter",
	NarcissusHealToCounter = "NarcissusHealToCounter",
	SpecialCountCastBuff = "SpecialCountCastBuff",
	InjuryBank = "InjuryBank",
	ConsumeBuffAddBuffContinueChannel = "ConsumeBuffAddBuffContinueChannel",
	BeAttackAccrualFixAttr = "BeAttackAccrualFixAttr",
	StorageDamage = "StorageDamage",
	NuoDiKaCastChannel = "NuoDiKaCastChannel",
	Dream = "Dream",
	ChangeComposeCardSkill = "ChangeComposeCardSkill",
	UseSkillHasBuffCond = "UseSkillHasBuffCond",
	Raspberry = "Raspberry",
	TeamImmunityTimes = "TeamImmunityTimes",
	None = "None",
	NarcissusCounterDamageImmune = "NarcissusCounterDamageImmune",
	FixAttrTeamEnergyAndBuff = "FixAttrTeamEnergyAndBuff",
	FixAttrTeamEnergy = "FixAttrTeamEnergy",
	AddAttrBySpecialCount = "AddAttrBySpecialCount",
	EzioBigSkill = "EzioBigSkill",
	LostHpToFakeHp = "LostHpToFakeHp",
	ConsumeBuffLayerCastChannel = "ConsumeBuffLayerCastChannel",
	AttrByHeatScale = "AttrByHeatScale",
	TeamExElectricTransConsumeValueAttr = "TeamExElectricTransConsumeValueAttr",
	HeatScaleUseSkill = "HeatScaleUseSkill",
	NarcissusAddAttrByPassionEx = "NarcissusAddAttrByPassionEx",
	FoundationShield = "FoundationShield",
	HedoneHurtCounter = "HedoneHurtCounter",
	EachChangeAttrOneWay = "EachChangeAttrOneWay",
	SpecialCountContinueChannelBuff = "SpecialCountContinueChannelBuff",
	TeamShareShield = "TeamShareShield",
	SpecialCountCastChannel = "SpecialCountCastChannel",
	SkillLevelJudgeAdd = "SkillLevelJudgeAdd"
}
FightEnum.BuffFeatureMap = {
	[FightEnum.BuffType_Dizzy] = true,
	[FightEnum.BuffType_Charm] = true,
	[FightEnum.BuffType_Petrified] = true,
	[FightEnum.BuffType_Sleep] = true,
	[FightEnum.BuffType_Frozen] = true,
	[FightEnum.BuffType_Disarm] = true,
	[FightEnum.BuffType_Forbid] = true,
	[FightEnum.BuffType_Seal] = true,
	[FightEnum.BuffType_Dot] = true,
	[FightEnum.BuffType_Immunity] = true,
	[FightEnum.BuffType_Freeze] = true,
	[FightEnum.BuffType_CastChannel] = true
}
FightEnum.BuffPriorityTypeDict = {
	[FightEnum.BuffType_Freeze] = 5,
	[FightEnum.BuffType_Immunity] = 4,
	[FightEnum.BuffType_Dizzy] = 3,
	[FightEnum.BuffType_Charm] = 3,
	[FightEnum.BuffType_Petrified] = 2,
	[FightEnum.BuffType_Sleep] = 1,
	[FightEnum.BuffType_Frozen] = 2
}
FightEnum.CardLockPriorityDict = {
	[FightEnum.BuffType_CastChannel] = 4,
	[FightEnum.BuffType_Dizzy] = 3,
	[FightEnum.BuffType_Charm] = 3,
	[FightEnum.BuffType_Petrified] = 2,
	[FightEnum.BuffType_Sleep] = 1,
	[FightEnum.BuffType_Frozen] = 2,
	[FightEnum.BuffType_Disarm] = 0,
	[FightEnum.BuffType_Forbid] = 0,
	[FightEnum.BuffType_Seal] = 0
}
FightEnum.FightSpecialTipsType = {
	Addition = 2,
	Special = 1
}
FightEnum.FightConstId = {
	TechnicCriticalRatio = 11,
	TechnicTargetLevelRatio = 14,
	TechnicCriticalDamageRatio = 12,
	TechnicCorrectConst = 13
}
FightEnum.DirectDamageType = -1
FightEnum.FightBuffType = {
	GoodBuff = 2,
	BadBuff = 1,
	NormalBuff = 3
}
FightEnum.BuffTypeList = {
	GoodBuffList = {
		1,
		3,
		5
	},
	BadBuffList = {
		2,
		4,
		6
	}
}
FightEnum.FightStatType = {
	DataView = 1,
	SkillView = 2
}
FightEnum.AtkRenderOrderIgnore = {
	[60111] = {
		[FightEnum.EntitySide.MySide] = {
			5
		}
	}
}
FightEnum.DeadEffectType = {
	NoEffect = 1,
	NormalEffect = 0,
	Abjqr4 = 3,
	ZaoWu = 2
}
FightEnum.DissolveType = {
	Player = 1,
	Abjqr4 = 4,
	Monster = 2,
	ZaoWu = 3
}
FightEnum.IndicatorId = {
	Id4140004 = 4140004,
	Progress_500M = 31,
	NewSeasonScoreOffset = 163,
	Season1_2 = 3,
	Season = 1,
	V1a4_BossRush_ig_ScoreTips = 4,
	NewSeasonScore = 162,
	Id6181 = 6181,
	PaTaScore = 165,
	Id6182 = 6182,
	Id6202 = 6202,
	Id6201 = 6201,
	TowerCompose = 167,
	BossInfiniteHPCount = 5,
	TowerDeep = 166,
	Act1_6DungeonBoss = 161,
	DoomsdayClock = 10001,
	Rouge2Boss = 168,
	FightSucc = 2,
	ZongMaoTechniqueScore = 6
}
FightEnum.AppearTimelineSkillId = -111
FightEnum.SkillTargetType = {
	All = 4,
	Single = 1,
	Side = 3,
	Multi = 2
}
FightEnum.SkillLineColor = {
	Yellow = 2,
	Red = 1
}
FightEnum.ClothSkillType = {
	AssassinBigSkill = 5,
	HeroUpgrade = 1,
	SelectCrystal = 6,
	MeiLeiErExtraRound = 9,
	BattleSelection = 8,
	TwinsSelect = 10,
	EzioBigSkill = 4,
	Rouge2 = 7,
	Contract = 3,
	ClothSkill = 0,
	Rouge = 2
}
FightEnum.CardType = {
	SUPPORT_NORMAL = 2,
	USE_ACT_POINT = 5,
	SKILL3 = 6,
	DEVICE = 7,
	ROUGE_SP = 1,
	SUPPORT_EX = 3,
	NONE = 0
}
FightEnum.PowerType = {
	PlayerFinisherSkill = 5,
	ZongMaoBossEnergy = 9,
	AssistBoss = 4,
	Atomic = 11,
	Stress = 3,
	Power = 1,
	Act191Boss = 7,
	ZongMaoYinNiZhi = 10,
	Alert = 6,
	SurvivalDot = 8,
	Energy = 2
}
FightEnum.ClothSkillPerformanceType = {
	Rouge = 1,
	ToughBattle = 2,
	Normal = 0
}
FightEnum.ExIndexForRouge = {
	Coin = 1,
	Magic = 2,
	SupportHeroSkill = 4,
	MagicLimit = 3
}
FightEnum.PerformanceTime = {
	CardLevelChange = 1.3,
	DouQuQuXianHouShou = 3.6,
	CardAConvertCardB = 1.2
}
FightEnum.CacheProtoType = {
	Fight = 1,
	Round = 2
}
FightEnum.FightActType = {
	Sp = 2,
	Season2 = 3,
	Act174 = 4,
	Normal = 1
}
FightEnum.CardInfoStatus = {
	STATUS_NONE = 0,
	STATUS_PLAYSETGRAY = 1
}
FightEnum.BuffActId = {
	ExPointCantAdd = 603,
	LockHpMax = 1013,
	Rouge2CheckCount = 1063,
	CycleToSub = 931,
	RealDamageKill = 1028,
	TwinsUpByCounter = 10030,
	FictionHp = 1059,
	LostHpToFakeHp = 1150,
	NoUseCardEnergyRecordByRound = 1016,
	EntityScale = 1144,
	ConsumeBuffAddBuffContinueChannel = 1031,
	ExSkillNoConsumption = 514,
	HeatScaleAddFix = 1070,
	ButterflyRecordSkill = 1104,
	HedoneCard = 1159,
	CrystalNotifySelect = 1049,
	DeviceExPointOverflowBank = 1149
}
FightEnum.ExPointState = {
	Server = 2,
	Client = 3,
	ServerFull = 4,
	Stored = 7,
	UsingUnique = 5,
	Lock = 6,
	Empty = 1
}
FightEnum.CardRankChangeFail = {
	DownFail = "0",
	UpFail = "1"
}
FightEnum.Resistance = {
	forbid = 406,
	sleep = 402,
	dizzy = 401,
	frozen = 404,
	petrified = 403,
	delExPointResilience = 502,
	stressUp = 410,
	charm = 411,
	controlResilience = 501,
	delExPoint = 409,
	stressUpResilience = 503,
	seal = 407,
	disarm = 405,
	cantGetExskill = 408
}
FightEnum.ToughnessToResistance = {
	[FightEnum.Resistance.controlResilience] = {
		FightEnum.Resistance.dizzy,
		FightEnum.Resistance.sleep,
		FightEnum.Resistance.petrified,
		FightEnum.Resistance.frozen,
		FightEnum.Resistance.disarm,
		FightEnum.Resistance.forbid,
		FightEnum.Resistance.seal,
		FightEnum.Resistance.cantGetExskill,
		FightEnum.Resistance.charm
	},
	[FightEnum.Resistance.delExPointResilience] = {
		FightEnum.Resistance.delExPoint
	},
	[FightEnum.Resistance.stressUpResilience] = {
		FightEnum.Resistance.stressUp
	}
}
FightEnum.ResistanceKeyToSpAttributeMoField = {
	forbid = "forbidResistances",
	sleep = "sleepResistances",
	dizzy = "dizzyResistances",
	frozen = "frozenResistances",
	petrified = "petrifiedResistances",
	delExPointResilience = "delExPointResilience",
	stressUp = "stressUpResistances",
	charm = "charmResistances",
	controlResilience = "controlResilience",
	delExPoint = "delExPointResistances",
	stressUpResilience = "stressUpResilience",
	seal = "sealResistances",
	disarm = "disarmResistances",
	cantGetExskill = "cantGetExskillResistances"
}
FightEnum.DeadPerformanceMaxNum = 8
FightEnum.StressBehaviour = {
	Resolute = 4,
	BaseResolute = 7,
	Positive = 1,
	BaseReduce = 6,
	BaseAdd = 5,
	Negative = 2,
	BaseMeltdown = 8,
	Meltdown = 3
}
FightEnum.StressBehaviourString = {
	[FightEnum.StressBehaviour.Positive] = "positive",
	[FightEnum.StressBehaviour.Negative] = "negative",
	[FightEnum.StressBehaviour.Resolute] = "resolute",
	[FightEnum.StressBehaviour.Meltdown] = "meltdown",
	[FightEnum.StressBehaviour.BaseAdd] = "baseAdd",
	[FightEnum.StressBehaviour.BaseReduce] = "baseReduce",
	[FightEnum.StressBehaviour.BaseResolute] = "baseResolute",
	[FightEnum.StressBehaviour.BaseMeltdown] = "baseMeltdown"
}
FightEnum.StressBehaviourConstId = {
	[FightEnum.StressBehaviour.Positive] = 6,
	[FightEnum.StressBehaviour.Negative] = 7,
	[FightEnum.StressBehaviour.Resolute] = 8,
	[FightEnum.StressBehaviour.Meltdown] = 9
}
FightEnum.Status = {
	Positive = 1,
	Negative = 2
}
FightEnum.StressThreshold = {
	[FightEnum.Status.Positive] = 24,
	[FightEnum.Status.Negative] = 50
}
FightEnum.MonsterId2StressThresholdDict = {
	[900042101] = {
		[FightEnum.Status.Positive] = 39,
		[FightEnum.Status.Negative] = 60
	},
	[900042102] = {
		[FightEnum.Status.Positive] = 39,
		[FightEnum.Status.Negative] = 60
	}
}
FightEnum.BuffType = {
	LayerMasterHalo = 1,
	LayerSalveHalo = 2,
	Normal = 0
}
FightEnum.IdentityType = {
	BattleTag = "battleTag",
	HeroId = "id",
	HeroType = "heroType",
	Base = "base",
	Career = "career",
	Custom = "custom"
}
FightEnum.EnemyActionStatus = {
	Lock = 3,
	NotOpen = 0,
	Select = 2,
	Normal = 1
}
FightEnum.EntityStatus = {
	Dying = 1,
	Dead = 2,
	Normal = 0
}
FightEnum.EntityType = {
	Character = 1,
	Act191Boss = 8,
	Player = 3,
	AssistBoss = 5,
	ASFDEmitter = 6,
	Vorpalith = 7,
	Monster = 2,
	Rouge2Music = 9
}
FightEnum.ConditionTarget = {
	Self = "103"
}
FightEnum.ConditionType = {
	HasBuffId = "HasBuffId"
}
FightEnum.ASFDUnit = {
	Explosion = 3,
	Emitter = 1,
	Missile = 2,
	Born = 4
}
FightEnum.ASFDFlyPath = {
	Default = 1,
	StraightLine_LSJ = 3,
	StraightLine = 2
}
FightEnum.ASFDType = {
	Normal = 1
}
FightEnum.ASFDEffect = {
	Fission = 2,
	Normal = 1
}
FightEnum.ASFDReplyRule = {
	IndexMoreThan = 3,
	HasSkin = 1,
	HasBuffActId = 2
}
FightEnum.CardShowType = {
	Default = 0,
	HandCard = 1,
	BossAction = 4,
	Deck = 5,
	PlayCard = 3,
	Operation = 2,
	LorentzCard = 6
}
FightEnum.CardColor = {
	Blue = 1,
	Both = 3,
	Red = 2,
	None = 0
}
FightEnum.LYCardAreaWidthOffset = 45
FightEnum.SkiId2LYPlayCardAreaOffsetDict = {
	[0] = 74,
	[672803] = 95,
	[672802] = 95
}
FightEnum.LYCardWaitAreaScale = 1.5
FightEnum.CardIconId = {
	PreDelete = 99999999
}
FightEnum.MagicCircleUIType = {
	Electric = 1,
	LSJ = 2,
	Normal = 0
}
FightEnum.MagicCircleUIType2Name = {
	[FightEnum.MagicCircleUIType.Normal] = "shuzhenitem",
	[FightEnum.MagicCircleUIType.Electric] = "electricmagiccircle",
	[FightEnum.MagicCircleUIType.LSJ] = "lsj"
}
FightEnum.ExPointType = {
	Common = 0,
	Belief = 1,
	DevicePower = 4,
	NoExpoint = 999,
	Synchronization = 2,
	Adrenaline = 3
}
FightEnum.ExPointTypeFeature = {
	[FightEnum.ExPointType.Common] = {
		moveAddExpoint = true,
		combineAddExpoint = true,
		playAddExpoint = true
	},
	[FightEnum.ExPointType.Belief] = {
		moveAddExpoint = false,
		combineAddExpoint = false,
		playAddExpoint = false
	},
	[FightEnum.ExPointType.Synchronization] = {
		moveAddExpoint = false,
		combineAddExpoint = false,
		playAddExpoint = false
	},
	[FightEnum.ExPointType.Adrenaline] = {
		moveAddExpoint = false,
		combineAddExpoint = false,
		playAddExpoint = false
	},
	[FightEnum.ExPointType.NoExpoint] = {
		moveAddExpoint = false,
		combineAddExpoint = false,
		playAddExpoint = false
	}
}
FightEnum.BuffDeleteReason = {
	Overflow = 1
}
FightEnum.MultiHpType = {
	Default = 1,
	Tower500M = 2
}
FightEnum.ProgressId = {
	Progress_9 = 9,
	Progress_500M = 7,
	Progress_6 = 6,
	Progress_10 = 10,
	Progress_5 = 5,
	Progress_8 = 8
}
FightEnum.HeroId = {
	LY = 3110,
	BLE = 3134,
	ALF = 3113
}
FightEnum.CrystalEnum = {
	Blue = 1,
	Green = 3,
	Purple = 2,
	None = 0
}
FightEnum.BloodPoolConfigEffect = {
	HeatScale = 1,
	BloodPool = 0
}
FightEnum.HeatScaleType = {
	BLE = 2,
	Normal = 1
}
FightEnum.EntityCreateStage = {
	Init = 1,
	None = 0
}
FightEnum.Rouge2MusicType = {
	Yellow = 1,
	Green = 2,
	Blue = 3,
	None = 0
}
FightEnum.Rouge2MusicTypeCombineDict = {
	[FightEnum.Rouge2MusicType.None] = {
		[FightEnum.Rouge2MusicType.None] = FightEnum.Rouge2MusicType.None,
		[FightEnum.Rouge2MusicType.Yellow] = FightEnum.Rouge2MusicType.Yellow,
		[FightEnum.Rouge2MusicType.Green] = FightEnum.Rouge2MusicType.Green,
		[FightEnum.Rouge2MusicType.Blue] = FightEnum.Rouge2MusicType.Blue
	},
	[FightEnum.Rouge2MusicType.Yellow] = {
		[FightEnum.Rouge2MusicType.None] = FightEnum.Rouge2MusicType.Yellow,
		[FightEnum.Rouge2MusicType.Yellow] = FightEnum.Rouge2MusicType.Yellow,
		[FightEnum.Rouge2MusicType.Green] = FightEnum.Rouge2MusicType.Blue,
		[FightEnum.Rouge2MusicType.Blue] = FightEnum.Rouge2MusicType.Green
	},
	[FightEnum.Rouge2MusicType.Green] = {
		[FightEnum.Rouge2MusicType.None] = FightEnum.Rouge2MusicType.Green,
		[FightEnum.Rouge2MusicType.Yellow] = FightEnum.Rouge2MusicType.Blue,
		[FightEnum.Rouge2MusicType.Green] = FightEnum.Rouge2MusicType.Green,
		[FightEnum.Rouge2MusicType.Blue] = FightEnum.Rouge2MusicType.Yellow
	},
	[FightEnum.Rouge2MusicType.Blue] = {
		[FightEnum.Rouge2MusicType.None] = FightEnum.Rouge2MusicType.Blue,
		[FightEnum.Rouge2MusicType.Yellow] = FightEnum.Rouge2MusicType.Green,
		[FightEnum.Rouge2MusicType.Green] = FightEnum.Rouge2MusicType.Yellow,
		[FightEnum.Rouge2MusicType.Blue] = FightEnum.Rouge2MusicType.Blue
	}
}
FightEnum.Rouge2Career = {
	Cymbal = 3,
	TubularBell = 2,
	Slapstick = 4,
	Strings = 1
}
FightEnum.Rouge2FunnyTaskLevel = {
	A = 3,
	C = 1,
	S = 4,
	B = 2
}
FightEnum.Rouge2FunnyTaskLevelName = {
	[FightEnum.Rouge2FunnyTaskLevel.C] = "C",
	[FightEnum.Rouge2FunnyTaskLevel.B] = "B",
	[FightEnum.Rouge2FunnyTaskLevel.A] = "A",
	[FightEnum.Rouge2FunnyTaskLevel.S] = "S"
}
FightEnum.Rouge2FunnyTaskLevelName2Level = {
	C = FightEnum.Rouge2FunnyTaskLevel.C,
	B = FightEnum.Rouge2FunnyTaskLevel.B,
	A = FightEnum.Rouge2FunnyTaskLevel.A,
	S = FightEnum.Rouge2FunnyTaskLevel.S
}
FightEnum.AssistBossType = {
	CombineBoss3_3 = 1,
	Rouge3_3 = 2,
	Normal = 0
}
FightEnum.Career = {
	Wood = 3,
	Wisdom = 6,
	RockAndStar = 101,
	Rock = 1,
	Spirit = 5,
	Star = 2,
	Multi = 8,
	Animal = 4,
	None = 0
}
FightEnum.MultiCareerShowCount = 3
FightEnum.CoverType = {
	Unique = 2,
	Normal = 1
}
FightEnum.UpdateCardItemFromType = {
	ActEffectUpdateCard = 1
}
FightEnum.LogicTargetType = {
	Multiple = 2,
	Single = 1,
	None = 0
}
FightEnum.DeviceDiscardSkillId = 30010701
FightEnum.GenerateOneLevelCardSkillId = 30010501
FightEnum.DevicePowerChangeType = {
	SpecialChange = 1,
	TriggerDeviceSkill = -1,
	DevicePowerCardAdd = 0
}

return FightEnum
