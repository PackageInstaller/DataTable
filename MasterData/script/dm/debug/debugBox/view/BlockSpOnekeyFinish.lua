-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/BlockSpOnekeyFinish.lua

BlockSpOnekeyFinish = class("BlockSpOnekeyFinish", DebugViewTemplate, _M)

function BlockSpOnekeyFinish:initialize()
	self._opType = 232
	self._viewConfig = {
		{
			default = 1,
			name = "spType",
			title = "1金币,2经验,3水晶",
			type = "Input"
		},
		{
			default = 5,
			name = "point",
			title = "通关的关卡数",
			type = "Input"
		}
	}
end
