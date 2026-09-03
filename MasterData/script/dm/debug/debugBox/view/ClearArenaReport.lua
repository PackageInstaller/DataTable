-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ClearArenaReport.lua

ClearArenaReport = class("ClearArenaReport", DebugViewTemplate, _M)

function ClearArenaReport:initialize()
	self._opType = 116
	self._viewConfig = {
		{
			title = "清理战报",
			name = "ClearArenaReport",
			type = "Label"
		}
	}
end
