-- chunkname: @modules/logic/sp01/act204/define/Activity204Enum.lua

module("modules.logic.sp01.act204.define.Activity204Enum", package.seeall)

local Activity204Enum = _M

Activity204Enum.VoiceType = {
	EnterView = 1,
	UpdateMainTask = 3,
	ClickSkin = 2
}
Activity204Enum.LocalPrefsKey = {
	MainActivityStageAnim = "MainActivityStageAnim",
	Question = "Question",
	GameMark = "GameMark",
	FirstEnterView = "Activity205FirstEnterView",
	SignMark = "SignMark",
	AvgMark = "Activity205AvgMark"
}
Activity204Enum.ConstId = {
	DailyStoneCount = 3,
	CurrencyId = 1,
	BubbleActIds = 4
}
Activity204Enum.RewardStatus = {
	Canget = 2,
	Hasget = 3,
	None = 1
}
Activity204Enum.TaskStatus = {
	None = 2,
	Hasget = 3,
	Canget = 1
}
Activity204Enum.EntranceIdList = {
	ActivityEnum.Activity.V2a9_LoginSign,
	ActivityEnum.Activity.V2a9_Act205,
	ActivityEnum.Activity.V2a9_AssassinChase,
	ActivityEnum.Activity.V2a9_Act204
}
Activity204Enum.ActId2EntranceCls = {
	[ActivityEnum.Activity.V2a9_Act204] = Activity204TaskEntranceItem,
	[ActivityEnum.Activity.V2a9_Act205] = Activity204OceanEntranceItem,
	[ActivityEnum.Activity.V2a9_LoginSign] = Activity204EntranceItemBase,
	[ActivityEnum.Activity.V2a9_AssassinChase] = Activity204ChaseEntranceItem
}
Activity204Enum.ActId2ViewList = {
	[ActivityEnum.Activity.V2a9_Act204] = {
		ViewName.Activity204TaskView
	},
	[ActivityEnum.Activity.V2a9_Act205] = {
		ViewName.Act205OceanSelectView,
		ViewName.Act205OceanShowView,
		ViewName.Act205OceanResultView,
		ViewName.Act205GameStartView,
		ViewName.Act205CardSelectView,
		ViewName.Act205CardShowView,
		ViewName.Act205CardResultView
	},
	[ActivityEnum.Activity.V2a9_LoginSign] = {},
	[ActivityEnum.Activity.V2a9_AssassinChase] = {}
}
Activity204Enum.Act205StageView = {
	{
		ViewName.Act205CardSelectView,
		ViewName.Act205CardShowView,
		ViewName.Act205CardResultView
	},
	{
		ViewName.Act205OceanSelectView,
		ViewName.Act205OceanShowView,
		ViewName.Act205OceanResultView
	}
}
Activity204Enum.LoginSignSpDayIndex = {
	nil,
	true,
	nil,
	nil,
	true,
	nil,
	true
}
Activity204Enum.RolePath = "rolesstory/rolesprefab/s01_302804_apple_p/302804_apple_p.prefab"

return Activity204Enum
