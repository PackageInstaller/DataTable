-- chunkname: @modules/logic/versionactivity1_8/weila/define/ActWeilaEnum.lua

module("modules.logic.versionactivity1_8.weila.define.ActWeilaEnum", package.seeall)

local ActWeilaEnum = _M

ActWeilaEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
ActWeilaEnum.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}

return ActWeilaEnum
