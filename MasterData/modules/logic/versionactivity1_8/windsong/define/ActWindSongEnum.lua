-- chunkname: @modules/logic/versionactivity1_8/windsong/define/ActWindSongEnum.lua

module("modules.logic.versionactivity1_8.windsong.define.ActWindSongEnum", package.seeall)

local ActWindSongEnum = _M

ActWindSongEnum.AnimatorTime = {
	TaskReward = 0.5,
	TaskRewardMoveUp = 0.15
}
ActWindSongEnum.AnimEvt = {
	OnGoStoryEnd = "goStoryEnd",
	OnStoryOpenEnd = "storyOpenEnd",
	OnFightOpenEnd = "fightOpenEnd"
}

return ActWindSongEnum
