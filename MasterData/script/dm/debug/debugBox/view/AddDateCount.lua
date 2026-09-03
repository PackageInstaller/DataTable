-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddDateCount.lua

AddDateCount = class("AddDateCount", DebugViewTemplate, _M)

function AddDateCount:initialize()
	self._opType = 261
	self._viewConfig = {
		{
			default = "5",
			name = "count",
			title = "增加约会次数",
			type = "Input"
		}
	}
end
