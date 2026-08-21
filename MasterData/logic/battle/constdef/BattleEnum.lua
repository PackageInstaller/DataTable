-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/constdef/BattleEnum.lua

module("logic.battle.constdef.BattleEnum", package.seeall)

local BattleEnum = {}

BattleEnum.Mode = {
	RECORD = 2,
	RECONNECT = 3,
	NORMAL = 1,
	NONE = 0
}
BattleEnum.Phase = {
	READY = 1,
	PLOT = 3,
	NORMAL = 2,
	NONE = 0
}
BattleEnum.Shape = {
	ParallelRectangle = 10,
	Point = 4,
	Line = 12,
	Rhombus = 2,
	LinkLine = 13,
	WholeBattleBoard = 5,
	ModelRectangle = 11,
	Rectangle = 3,
	MultipleShape = 7,
	CrossLine = 9,
	Circle = 1,
	Sector = 6
}
BattleEnum.AttackType = {
	PHYSICS = 1,
	MAGIC = 2
}
BattleEnum.CellColor = {
	CURABLE = 3,
	STOPABLE = 1,
	NORMAL = 0,
	ATTACKABLE = 2
}
BattleEnum.CellLayer = {
	STOPABLE = 1,
	NORMAL = 0,
	ATTACKABLE = 2
}
BattleEnum.CellUV = {
	NORMAL = 0,
	BORN_PLACED = 2,
	BORN_EMPTY = 1
}
BattleEnum.CellType = {
	TERRAIN105 = 105,
	TERRAIN104 = 104,
	TERRAIN103 = 103,
	TERRAIN102 = 102,
	TERRAIN106 = 106,
	TERRAIN101 = 101
}
BattleEnum.BubbleType = {
	BUFF_TRIGGER_HINT = 5,
	STATUS_HINT = 6,
	BUFF_ADD_HINT = 7,
	CRIT_DAMAGE = 1,
	NORMAL_RECOVERY = 3,
	SKILL_TRIGGER_HINT = 4,
	BUFF_REMOVE_HINT = 8,
	NORMAL_DAMAGE = 2
}
BattleEnum.AttackingDirection = BattleExtension_pb.AttackingDirection
BattleEnum.AttackingDirection.ATTACKING_DIRECTION_PRIORITY_COUNTER = -1
BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DISTANCE_COUNTER = -2
BattleEnum.AttackingDirection.WEAK_POINT_BROKEN = -3
BattleEnum.EntityType = {
	Monster = BattleExtension_pb.EntityType.ENTITY_MONSTER,
	Hero = BattleExtension_pb.EntityType.ENTITY_HERO,
	HaloTerrain = BattleExtension_pb.EntityType.ENTITY_HALO_TERRAIN,
	Npc = BattleExtension_pb.EntityType.ENTITY_SYSTEM_NPC,
	Intangible = BattleExtension_pb.EntityType.ENTITY_INTANGIBLE,
	Summon = BattleExtension_pb.EntityType.ENTITY_SUMMON
}
BattleEnum.CommandType = {
	ATTACK = 2,
	MOVE = 1,
	TRIGGER = 3,
	NONE = 0
}
BattleEnum.CampRelation = {
	SAME = 3,
	FRIEND = 2,
	NORMAL = 0,
	ENEMY = 1
}
BattleEnum.SkillCategory = {
	EQUIPMENT = 7,
	PASSIVE = 10,
	TALENT = 4,
	SPECIAL = 2,
	EXTRA = 8,
	NORMAL = 1,
	ECHO = 5,
	DEPUTY = 6,
	TRUMP = 3,
	GLOBAL = 9
}
BattleEnum.SkillType = {
	NORMAL = 1,
	PASSIVE = 3,
	CARRY = 2
}
BattleEnum.SkillDisplayCategory = {
	ATK_PHY = 1,
	PASSIVE = 7,
	TRANSPORT = 5,
	HALO = 6,
	ATK_MAG = 2,
	CURE = 4,
	ASSISTANT = 3
}
BattleEnum.SkillPurpose = {
	HALOPASSIVE = 7,
	PASSIVE = 4,
	DAMAGE = 1,
	CURE = 2,
	FRIENDLYHALO = 5,
	SUMMON = 9,
	WEAK_POINT = 8,
	MARK = 11,
	ENEMYHALO = 6,
	TRANSPORT = 3,
	MULTI_ROUND_AOE = 10
}
BattleEnum.Restrain = {
	BE_RESTRAIN = 2,
	RESTRAIN = 1,
	NONE = 0
}
BattleEnum.SkillSelectableTarget = {
	MEMBER_STEPPED = 5,
	ENEMY = 1,
	POSITION = 4,
	SELF = 3,
	MEMBER = 2,
	UNKNOWN = 0
}
BattleEnum.SkillReleaseType = {
	SNIPING = 2,
	NORMAL = 1,
	UNKNOWN = 0
}
BattleEnum.SkillResultID = {
	STRIKE_BACK = 2,
	MAIN = 1
}
BattleEnum.ParticleType = {
	NormalUI = 1,
	Skill = 2,
	Buff = 4,
	Scene = 3
}
BattleEnum.Tag = {
	Chase = 2,
	MoonRing = 1,
	Assist = 3,
	Snipe = 6,
	ArcLight = 5,
	Suppress = 7,
	BoreSpine = 4,
	Bomb = 8
}
BattleEnum.State = BattleExtension_pb.State
BattleEnum.State.MANUAL = -101
BattleEnum.State.STEPPED = -102
BattleEnum.State.HAS_WEAK_POINT = -103
BattleEnum.State.DEAD = -104
BattleEnum.State.SKIPPED_STEP = -105
BattleEnum.State.SKIPPED_PERFORMANCE_FOR_VICITM = -106
BattleEnum.State.DIZZY_OR_SLEEP = -201
BattleEnum.State.WEAKPOINT_FROZEN = -202
BattleEnum.State.DEAD_FROZEN = -203
BattleEnum.State.DEAD_PERFORMANCED = -205
BattleEnum.State.SANITY_STRENGTHEN = -206
BattleEnum.State.WEAK_POINT_PERFORMANCED = -207
BattleEnum.State.SANITY_BROKEN = -208
BattleEnum.State.PLAYING_DEAD_ANIMATION = -209
BattleEnum.State.UNDO_PREVIEW = -210
BattleEnum.Attribute = BattleExtension_pb.Attribute
BattleEnum.Attribute.CURRENT_WEAKPOINT_HP = -101
BattleEnum.Attribute.MAX_WEAKPOINT_HP = -102
BattleEnum.Attribute.WEAKPOINT_TYPE = -103
BattleEnum.SkillEffectAction = {
	MODIFY_ATTRIBUTE = 60001
}
BattleEnum.DungeonLockedHeroRefreshType = {
	DATA = 1,
	CONFIG = 2
}
BattleEnum.MonsterCampType = {
	ASSISTANT = 3,
	PLAYER = 2,
	SYSTEM = 5,
	FRIEND = 4,
	NORMAL = 1,
	NONE = 0
}
BattleEnum.CellState = {
	BLOCKED = 1
}
BattleEnum.RestartType = {
	CONSECUTIVE = 3,
	TONEXT = 4,
	CALCULATE = 2,
	NORMAL = 1,
	UNKNOWN = 0
}
BattleEnum.MonsterType = {
	BOSS = 2,
	NORMAL = 0,
	ELITE = 1
}
BattleEnum.SkillStatus = {
	Strenthening = 2,
	Normal = 1
}
BattleEnum.AnimStateType = {
	GroupHitEffectCode = 3,
	HitEfectCode = 2,
	SpecialAnimName = 1
}
BattleEnum.PerformanceDeadType = {
	EffectOnly = 2,
	FrozenDeath = 3,
	Animation = 1
}
BattleEnum.AdditionalTerrainGroup = {
	PointAdd = 2,
	Scaled = 1,
	None = 0
}
BattleEnum.UnitType = {
	Unknown = 3,
	Person = 1,
	Terrain = 2
}
BattleEnum.UpdateMethod = {
	UpdateChanged = 2,
	ClearAndUpdate = 1
}
BattleEnum.EndReason = {
	CANNOT_RELEASE_NORMAL_SKILL = "CANNOT_RELEASE_NORMAL_SKILL",
	NORMAL = "NORMAL",
	CANNOT_RELEASE_SPECIAL_OR_TRUMP_SKILL = "CANNOT_RELEASE_SPECIAL_OR_TRUMP_SKILL"
}
BattleEnum.HotAreaType = {
	Middle = 2,
	Small = 1
}
BattleEnum.ForbidAction = {
	AutoPlay = 5,
	SkillByType = 3,
	SkillByPurpose = 4,
	SkillStrengthen = 2,
	Move = 1
}
BattleEnum.FocusSignType = {
	Target = 3,
	Focus = 2,
	Operatable = 1
}
BattleEnum.AnimationState = {
	Default = 0,
	Close = 2,
	Open = 1
}
BattleEnum.ModelWearKeyRes = {
	xiangzi = BattleResourceName.BoxWear
}
BattleEnum.AOEType = {
	BUFF = 1,
	DEBUFF = 2,
	NONE = 0
}
BattleEnum.ForecastUnitType = {
	Transport = 2,
	Move = 1
}
BattleEnum.kMappingLayers = {
	SYSTEM = 2,
	BUSINESS = 3,
	BASE = 1
}
BattleEnum.GamePlayType = {
	NORMAL = BattleExtension_pb.Gameplay.GAME_NORMAL,
	RECORD = BattleExtension_pb.Gameplay.GAME_RECORD,
	CONSECUTIVE = BattleExtension_pb.Gameplay.GAME_CONSECUTIVE
}
BattleEnum.SkillContinuousType = {
	MUTI_TIMELINE = 1,
	LOOP_TIMELINE = 2,
	NORMAL = 0
}
BattleEnum.Direction = {
	Down = 3,
	Up = 1,
	Right = 2,
	Left = 4
}

return BattleEnum
