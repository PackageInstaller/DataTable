-- chunkname: @modules/logic/activity/define/ActivityWarmUpEnum.lua

module("modules.logic.activity.define.ActivityWarmUpEnum", package.seeall)

local ActivityWarmUpEnum = _M

ActivityWarmUpEnum.OrderStatus = {
	Accepted = 2,
	Finished = 4,
	Collected = 3,
	WaitForAccept = 1,
	None = 0
}
ActivityWarmUpEnum.Quality2FramePath = {
	"bg_ka3",
	"bg_ka2",
	"bg_ka1"
}
ActivityWarmUpEnum.Activity125TaskTag = {
	sum_help_npc = 1,
	perfect_win = 3,
	help_npc = 2
}

return ActivityWarmUpEnum
