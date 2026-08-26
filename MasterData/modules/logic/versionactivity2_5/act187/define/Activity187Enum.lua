-- chunkname: @modules/logic/versionactivity2_5/act187/define/Activity187Enum.lua

module("modules.logic.versionactivity2_5.act187.define.Activity187Enum", package.seeall)

local Activity187Enum = _M

Activity187Enum.ConstId = {
	MaxLanternCount = 1
}
Activity187Enum.PaintStatus = {
	Ready = 1,
	Finish = 3,
	Painting = 2
}
Activity187Enum.BlockKey = {
	GetPaintingReward = "v2a5_lantern_festival_get_painting_reward_block",
	GetAccrueReward = "v2a5_lantern_festival_get_accrue_reward_block",
	SwitchView = "v2a5_lantern_festival_switch_view"
}
Activity187Enum.EmptyLantern = "v2a5_lanternfestival_lantern1"

return Activity187Enum
