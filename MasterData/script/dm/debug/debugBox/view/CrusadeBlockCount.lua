-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/CrusadeBlockCount.lua

CrusadeBlockCount = class("CrusadeBlockCount", DebugViewTemplate, _M)

function CrusadeBlockCount:initialize()
	self._opType = 291
	self._viewConfig = {
		{
			default = 3,
			name = "count",
			title = "通关指定数量的关卡",
			type = "Input"
		}
	}
end
