-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ClearAllClub.lua

ClearAllClub = class("ClearAllClub", DebugViewTemplate, _M)

function ClearAllClub:initialize()
	self._opType = 202
	self._viewConfig = {
		{
			title = "清理所有社团",
			name = "",
			type = ""
		}
	}
end
