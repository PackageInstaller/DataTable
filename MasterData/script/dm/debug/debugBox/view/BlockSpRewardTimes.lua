-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/BlockSpRewardTimes.lua

BlockSpRewardTimes = class("BlockSpRewardTimes", DebugViewTemplate, _M)

function BlockSpRewardTimes:initialize()
	self._opType = 128
	self._viewConfig = {
		{
			default = "exp",
			name = "spType",
			title = "exp、gold、crystal",
			type = "Input"
		}
	}
end
