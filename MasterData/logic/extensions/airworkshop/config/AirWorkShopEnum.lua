-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/config/AirWorkShopEnum.lua

module("logic.extensions.airworkshop.config.AirWorkShopEnum", package.seeall)

local AirWorkShopEnum = {}

AirWorkShopEnum.DefaultMaxRankShow = 100
AirWorkShopEnum.DefaultRankReqTimeInterval = 300
AirWorkShopEnum.FreeEndlessRankId = 10010
AirWorkShopEnum.UnitType = {
	Ground = 4,
	MountainBuilding = 6,
	ConditionMovePosition = 8,
	Message = 9,
	GroundBuilding = 5,
	BornPoint = 12,
	ExitPoint = 11,
	Building = 3,
	KillData = 10,
	Hero = 1,
	SpecialBuilding = 7,
	Ambush = 2
}
AirWorkShopEnum.ConditionType = {
	Kill = 1,
	Move = 2
}
AirWorkShopEnum.ConditionChange = {
	Reset = 2,
	Save = 1
}
AirWorkShopEnum.TabEnum = {
	ExitPoint = 5,
	Message = 4,
	Building = 3,
	BornPoint = 6,
	Hero = 1,
	Highland = 2
}
AirWorkShopEnum.MessageConditionType = {
	Message = 2,
	Hero = 1
}
AirWorkShopEnum.CalculateStyle = {
	Free = 3,
	Competitive = 2,
	Test = 1
}
AirWorkShopEnum.LvState = AirAtkExtension_pb.LvState
AirWorkShopEnum.LvStateNum = {
	[AirWorkShopEnum.LvState.UP3] = 3,
	[AirWorkShopEnum.LvState.UP2] = 2,
	[AirWorkShopEnum.LvState.UP1] = 1,
	[AirWorkShopEnum.LvState.KEEP] = 0,
	[AirWorkShopEnum.LvState.DOWN] = -1
}
AirWorkShopEnum.RodeoScoreSuffix = ""
AirWorkShopEnum.RodeoMaxRound = 5
AirWorkShopEnum.BtnStatus = {
	ContinueCheck = 2,
	ReviveCheck = 3,
	Check = 1
}
AirWorkShopEnum.Id2AirPlayType = {
	[101] = AirAtkExtension_pb.AirPlayType.FREE1,
	[102] = AirAtkExtension_pb.AirPlayType.FREE2,
	[103] = AirAtkExtension_pb.AirPlayType.FREE3,
	[104] = AirAtkExtension_pb.AirPlayType.FREE4,
	[105] = AirAtkExtension_pb.AirPlayType.ENDLESS,
	[201] = AirAtkExtension_pb.AirPlayType.RODEO,
	[301] = AirAtkExtension_pb.AirPlayType.HOT,
	[302] = AirAtkExtension_pb.AirPlayType.ID,
	[303] = AirAtkExtension_pb.AirPlayType.RECORD
}
AirWorkShopEnum.AirPlayType = AirAtkExtension_pb.AirPlayType
AirWorkShopEnum.PersonalPageType = {
	LevelLike = 4,
	LevelPublish = 3,
	LevelHistory = 5,
	Main = 1,
	Trophy = 2
}
AirWorkShopEnum.TaskPageType = {
	Challenge = 2,
	Create = 1,
	Entertainment = 3
}
AirWorkShopEnum.MessageTriggerType = {
	NormalSkillCount = 1007,
	CuredCount = 1010,
	FriendNear = 1004,
	RoundStart = 1001,
	SanityNegativeCount = 1013,
	UniqueSkillCount = 1009,
	EnemyNear = 1003,
	RoundEnd = 1002,
	NearEnemyCount = 1018,
	EnemyNearDead = 1005,
	NearFriendCount = 1019,
	SanityPositiveCount = 1012,
	FriendNearDead = 1006,
	NearAttackCount = 1015,
	TransportedCount = 1011,
	FarAttackCount = 1016,
	SpecialSkillCount = 1008,
	CriticalCount = 1017,
	SelfDead = 1014
}
AirWorkShopEnum.RodeoLv2ImgColor = {
	a = "#f4d362",
	c = "#aab9bc",
	d = "#be8970",
	s = "#e8f4ff",
	b = "#9b9ec3"
}
AirWorkShopEnum.DefState = {
	Clear = 2,
	BornPosSet = 3,
	LeavePosSet = 4,
	Edit = 1
}
AirWorkShopEnum.DragState = {
	Clear = 4,
	Normal = 1,
	Highland = 3,
	DragUnit = 2,
	None = 0
}
AirWorkShopEnum.CallBackState = {
	Continue = 2,
	Stop = 1,
	Fail = 4,
	Success = 3,
	None = 0
}
AirWorkShopEnum.TabName = {
	[AirWorkShopEnum.TabEnum.Hero] = "角色",
	[AirWorkShopEnum.TabEnum.Highland] = "普通部件",
	[AirWorkShopEnum.TabEnum.Building] = "探险部件",
	[AirWorkShopEnum.TabEnum.Message] = "留言"
}
AirWorkShopEnum.BuildingType = {
	DoubleD = 1,
	TripleD = 2
}

return AirWorkShopEnum
