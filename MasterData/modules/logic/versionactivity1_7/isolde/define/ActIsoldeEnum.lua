-- chunkname: @modules/logic/versionactivity1_7/isolde/define/ActIsoldeEnum.lua

module("modules.logic.versionactivity1_7.isolde.define.ActIsoldeEnum", package.seeall)

local ActIsoldeEnum = _M

ActIsoldeEnum.TaskMOAllFinishId = -100
ActIsoldeEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
ActIsoldeEnum.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}

return ActIsoldeEnum
