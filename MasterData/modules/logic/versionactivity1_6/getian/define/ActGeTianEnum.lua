-- chunkname: @modules/logic/versionactivity1_6/getian/define/ActGeTianEnum.lua

module("modules.logic.versionactivity1_6.getian.define.ActGeTianEnum", package.seeall)

local ActGeTianEnum = _M

ActGeTianEnum.ActivityId = VersionActivity1_6Enum.ActivityId.Role2
ActGeTianEnum.TaskMOAllFinishId = -100
ActGeTianEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
ActGeTianEnum.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}

return ActGeTianEnum
