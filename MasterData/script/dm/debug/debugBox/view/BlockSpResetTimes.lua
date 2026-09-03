-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/BlockSpResetTimes.lua

BlockSpResetTimes = class("BlockSpResetTimes", DebugViewTemplate, _M)

function BlockSpResetTimes:initialize()
	self._opType = 230
	self._viewConfig = {
		{
			title = "重置挑战次数",
			name = "BlockSpResetTimes",
			type = "Label"
		}
	}
end
