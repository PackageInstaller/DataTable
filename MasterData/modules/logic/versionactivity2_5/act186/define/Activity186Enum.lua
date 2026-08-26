-- chunkname: @modules/logic/versionactivity2_5/act186/define/Activity186Enum.lua

module("modules.logic.versionactivity2_5.act186.define.Activity186Enum", package.seeall)

local Activity186Enum = _M

Activity186Enum.VoiceType = {
	EnterView = 1,
	ClickSkin = 2
}
Activity186Enum.ViewEffect = {
	Yanhua = 2,
	Xiangyun = 4,
	Jinsha = 3,
	Caidai = 1
}
Activity186Enum.LocalPrefsKey = {
	MainActivityStageAnim = "MainActivityStageAnim",
	Question = "Question",
	GameMark = "GameMark",
	FirstEnterView = "Activity186FirstEnterView",
	SignMark = "SignMark",
	AvgMark = "Activity186AvgMark"
}
Activity186Enum.ConstId = {
	CurrencyId = 1,
	AvgOpenTime = 6,
	AvgReward = 3,
	Act101Reward = 4,
	DailyStoneCount = 2,
	AvgStoryId = 7,
	BaseLikeValue = 8
}
Activity186Enum.RewardStatus = {
	Canget = 2,
	Hasget = 3,
	None = 1
}
Activity186Enum.TaskStatus = {
	None = 2,
	Hasget = 3,
	Canget = 1
}
Activity186Enum.SignStatus = {
	Canget = 3,
	Hasget = 4,
	Canplay = 2,
	None = 1
}
Activity186Enum.GameStatus = {
	Result = 3,
	Start = 1,
	Playing = 2
}
Activity186Enum.ReadTaskId = {
	Task2 = 500022,
	Task4 = 500024,
	Task1 = 500021,
	Task3 = 500023
}
Activity186Enum.LoopType = {
	Week = 2,
	Activity = 3,
	Day = 1
}
Activity186Enum.RolePath = "rolesstory/rolesprefab/v1a6_623801_hzd_p/623801_hzd_p.prefab"

return Activity186Enum
