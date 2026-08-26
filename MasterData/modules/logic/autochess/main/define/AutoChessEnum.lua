-- chunkname: @modules/logic/autochess/main/define/AutoChessEnum.lua

module("modules.logic.autochess.main.define.AutoChessEnum", package.seeall)

local AutoChessEnum = _M

AutoChessEnum.ModuleId = {
	PVP = 1,
	Friend = 3,
	PVE = 0,
	PVP2 = 2
}
AutoChessEnum.EpisodeType = {
	PVP = 1,
	PVP2 = 2,
	PVE = 0
}
AutoChessEnum.SpecialMaster = {
	Role37 = 30020
}
AutoChessEnum.MallType = {
	Free = 2,
	Normal = 1
}
AutoChessEnum.ActionType = {
	StartBuy = 8,
	EndBuy = 7,
	ChessSkill = 3,
	RoundStart = 1,
	ChangeSide = 6,
	ChessMove = 4,
	Immediately = 9,
	ChessAct = 2,
	FightData = 10,
	NewStart = 5
}
AutoChessEnum.EffectType = {
	UdimoSkill = 24,
	NextFightStep = 1,
	FightUpdate = 20,
	RepleaceSkill = 28,
	DelBuff = 10,
	BattleChange = 16,
	LeaderChange = 23,
	ExpChange = 13,
	ChessMove = 6,
	LeaderHpFloat = 3,
	BossDrop = 25,
	ChessCd = 26,
	LeaderHp = 2,
	UpdateBuff = 9,
	Summon = 15,
	CoinChange = 11,
	StarChange = 14,
	ChessCombine = 27,
	LeaderSkillUpdate = 22,
	UpdateChessPos = 19,
	Explore = 12,
	AddBuff = 8,
	MallUpdate = 17,
	ChessDie = 7,
	ChessHp = 4,
	PlayAttack = 18,
	ChessHpFloat = 5
}
AutoChessEnum.BuildType = {
	Exchange = 1,
	Sell = 2
}
AutoChessEnum.TeamType = {
	Player = 1,
	Enemy = 2
}
AutoChessEnum.WarZone = {
	Two = 2,
	One = 1,
	Four = 4,
	Three = 3
}
AutoChessEnum.WarZoneType = {
	AutoChessStrEnum.ChessType.Support,
	AutoChessStrEnum.ChessType.Attack,
	AutoChessStrEnum.ChessType.Incubate
}
AutoChessEnum.ConstKey = {
	ChessSellPrice = 6,
	BoardSize = 1,
	DoubleScoreCnt = 16,
	DoubleScoreRank = 15,
	UnlockLeaderSlot = 12,
	UnlockLeaderRefresh = 13,
	RewardMaxStar = 3
}
AutoChessEnum.FreeZeType = {
	UnFreeze = 2,
	Freeze = 1
}
AutoChessEnum.BoardSize = {
	Row = 3,
	Column = 5
}
AutoChessEnum.ViewType = {
	All = 3,
	Player = 1,
	Enemy = 2
}
AutoChessEnum.TileSize = {
	[AutoChessEnum.ViewType.Player] = {
		Vector2(202, 160),
		Vector2(210, 166),
		(Vector2(217, 180))
	},
	[AutoChessEnum.ViewType.Enemy] = {
		Vector2(202, 160),
		Vector2(210, 166),
		(Vector2(217, 180))
	},
	[AutoChessEnum.ViewType.All] = {
		Vector2(170, 132),
		Vector2(176, 144),
		(Vector2(184, 154))
	}
}
AutoChessEnum.TileStartPos = {
	[AutoChessEnum.ViewType.Player] = {
		Vector2(-377, 256),
		Vector2(-405, 76),
		(Vector2(-432, -102))
	},
	[AutoChessEnum.ViewType.Enemy] = {
		Vector2(-436, 259),
		Vector2(-440, 78),
		(Vector2(-442, -102))
	},
	[AutoChessEnum.ViewType.All] = {
		Vector2(-791, 119),
		Vector2(-820, -40),
		(Vector2(-850, -195))
	}
}
AutoChessEnum.TileOffsetX = {
	[AutoChessEnum.ViewType.Player] = 3,
	[AutoChessEnum.ViewType.Enemy] = 3,
	[AutoChessEnum.ViewType.All] = 6
}
AutoChessEnum.LeaderPos = {
	[AutoChessEnum.ViewType.Player] = {
		[AutoChessEnum.TeamType.Player] = Vector2(-650, 200)
	},
	[AutoChessEnum.ViewType.Enemy] = {
		[AutoChessEnum.TeamType.Enemy] = Vector2(700, 200)
	},
	[AutoChessEnum.ViewType.All] = {
		[AutoChessEnum.TeamType.Player] = Vector2(-770, 316),
		[AutoChessEnum.TeamType.Enemy] = Vector2(770, 316)
	}
}
AutoChessEnum.ChessAniTime = {
	jump = 0.35,
	melee = 0.6,
	go = 0.5,
	born = 0.2,
	attack = 0.5,
	die = 0.67,
	eat = 1
}
AutoChessEnum.EffectPos = {
	Vector2(0, -60),
	Vector2(0, 0),
	(Vector2(0, 60))
}
AutoChessEnum.DamageType = {
	Ranged = 2,
	MeleeAoe = 3,
	Melee = 1,
	Skill = 4
}
AutoChessEnum.ContextType = {
	StartBuy = 2,
	EndBuy = 3,
	Fight = 4,
	Immediately = 1
}
AutoChessEnum.Tag2EffectId = {
	Die = 10002,
	Ranged = 20002,
	BattleFury = 2003,
	Damaged = 20001,
	GrowUp = 10003,
	Raw = 10001
}
AutoChessEnum.HpFloatType = {
	Poison = 2,
	Attack = 1,
	Cure = 3,
	None = 0
}
AutoChessEnum.EnergyBuffIds = {
	1004,
	1005
}
AutoChessEnum.FireBuffIds = {
	7004,
	7005
}
AutoChessEnum.DebrisIds = {
	7003
}
AutoChessEnum.PenguinChessIds = {
	21007,
	21008,
	21009,
	21010,
	21011,
	21012,
	21013
}
AutoChessEnum.RoundType = {
	PVP = 2,
	PVE = 1,
	BOSS = 3
}
AutoChessEnum.EffectPlayTarget = {
	TagOwner = 0,
	To = 2,
	From = 1
}

return AutoChessEnum
