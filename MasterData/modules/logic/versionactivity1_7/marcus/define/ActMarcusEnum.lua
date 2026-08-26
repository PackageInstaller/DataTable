-- chunkname: @modules/logic/versionactivity1_7/marcus/define/ActMarcusEnum.lua

module("modules.logic.versionactivity1_7.marcus.define.ActMarcusEnum", package.seeall)

local ActMarcusEnum = _M

ActMarcusEnum.TaskMOAllFinishId = -100
ActMarcusEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
ActMarcusEnum.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}

return ActMarcusEnum
