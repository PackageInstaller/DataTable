-- chunkname: @modules/logic/versionactivity1_6/quniang/define/ActQuNiangEnum.lua

module("modules.logic.versionactivity1_6.quniang.define.ActQuNiangEnum", package.seeall)

local ActQuNiangEnum = _M

ActQuNiangEnum.ActivityId = VersionActivity1_6Enum.ActivityId.Role1
ActQuNiangEnum.TaskMOAllFinishId = -100
ActQuNiangEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
ActQuNiangEnum.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}

return ActQuNiangEnum
