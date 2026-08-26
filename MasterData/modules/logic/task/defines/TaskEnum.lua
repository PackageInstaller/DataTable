-- chunkname: @modules/logic/task/defines/TaskEnum.lua

module("modules.logic.task.defines.TaskEnum", package.seeall)

local TaskEnum = _M

TaskEnum.TaskType = {
	CommandStationCatch = 64,
	BpOperAct = 70,
	Activity194 = 58,
	BattlePass = 10,
	Activity184 = 48,
	Activity185 = 49,
	Activity180 = 44,
	WeekWalk = 7,
	ActBp = 79,
	Activity168 = 36,
	Activity120 = 15,
	WeekWalk_2 = 54,
	RoleAiZiLa = 26,
	Daily = 1,
	Activity220 = 71,
	Activity190 = 55,
	ObserverBox = 74,
	Abyss = 76,
	Room = 6,
	RoleActivity = 30,
	Explore = 21,
	NecrologistStory = 65,
	Act231 = 77,
	Activity178 = 41,
	Activity106 = 8,
	Activity142 = 27,
	Activity134 = 25,
	Activity211 = 68,
	HideAchievement = 5,
	Activity128 = 22,
	Season = 9,
	Activity210 = 67,
	Activity173 = 39,
	Investigate = 38,
	TestTask = 13,
	TowerPermanentDeep = 69,
	Activity172 = 37,
	TowerCompose = 72,
	Activity131 = 20,
	TowerDeep = 66,
	Activity125 = 45,
	Activity163 = 32,
	Activity130 = 19,
	Activity192 = 56,
	DiceHero = 51,
	AutoChess = 47,
	CommandStationNormal = 62,
	Activity183 = 46,
	SchoolStart = 75,
	Tower = 40,
	Activity179 = 42,
	ActivityShow = 16,
	Activity145 = 28,
	Activity203 = 61,
	Activity133 = 23,
	StoreLinkPackage = 63,
	MiniParty = 73,
	Activity119 = 14,
	Novice = 4,
	Activity189 = 53,
	ActivityDungeon = 11,
	Season123 = 31,
	Activity188 = 52,
	Odyssey = 60,
	Activity109 = 12,
	V3A8FreeMonthCard = 80,
	AtomicDungeon = 78,
	Turnback = 18,
	AssassinOutside = 59,
	Activity164 = 33,
	Achievement = 3,
	Activity167 = 35,
	Activity122 = 17,
	Weekly = 2
}
TaskEnum.TaskMinType = {
	Novice = 1,
	Stationary = 2,
	GrowBack = 3
}
TaskEnum.TaskLoopType = {
	HalfMonth = 4,
	Daily = 1,
	Appoint = 5,
	Permanent = 3,
	Weekly = 2
}
TaskEnum.ListenerType = {
	Act209GlobalTowerLayer = "Act209GlobalTowerLayer"
}

return TaskEnum
