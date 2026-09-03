-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddRewards.lua

AddRewards = class("AddRewards", DebugViewTemplate, _M)

function AddRewards:initialize()
	self._opType = 126
	self._viewConfig = {
		{
			default = "Else_E01S01",
			name = "rewardId",
			title = "奖励ID",
			type = "Input"
		},
		{
			default = "3",
			name = "times",
			title = "奖励次数",
			type = "Input"
		}
	}
end
