-- chunkname: @modules/logic/weekwalk_2/define/WeekWalk_2Enum.lua

module("modules.logic.weekwalk_2.define.WeekWalk_2Enum", package.seeall)

local WeekWalk_2Enum = _M

WeekWalk_2Enum.episodeId = 2600101
WeekWalk_2Enum.MaxLayer = 4
WeekWalk_2Enum.MaxStar = 3
WeekWalk_2Enum.FirstDeepLayer = 1
WeekWalk_2Enum.LayerStatus = {
	Pass = 2,
	UnLock = 0,
	Lock = 1
}
WeekWalk_2Enum.BattleIndex = {
	Second = 2,
	First = 1
}
WeekWalk_2Enum.TaskType = {
	Season = 6,
	Month = 5,
	Once = 3
}
WeekWalk_2Enum.BattleStatus = {
	Finished = 1,
	UnFinished = 0
}
WeekWalk_2Enum.CupType = {
	None2 = 5,
	Platinum = 4,
	Copper = 1,
	Gold = 3,
	Silver = 2,
	None = 0
}
WeekWalk_2Enum.LineValue = {
	1,
	0.7,
	0.3,
	0
}
WeekWalk_2Enum.OnceAnimType = {
	FightBuffNew = 5,
	RuleNew = 2,
	BuffNew = 3,
	ResultReview = 4,
	UnlockEpisode = 1
}
WeekWalk_2Enum.ResultAnimIndex = {
	Defence = 3,
	Attack = 1,
	Health = 2,
	CupData = 5,
	RoleData = 4
}

return WeekWalk_2Enum
