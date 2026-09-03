-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/BlockSpAddTimes.lua

BlockSpAddTimes = class("BlockSpAddTimes", DebugViewTemplate, _M)

function BlockSpAddTimes:initialize()
	self._opType = 231
	self._viewConfig = {
		{
			default = 5,
			name = "time",
			title = "增加挑战次数",
			type = "Input"
		}
	}
end
