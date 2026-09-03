-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddFakePlayerToClub.lua

AddFakePlayerToClub = class("AddFakePlayerToClub", DebugViewTemplate, _M)

function AddFakePlayerToClub:initialize()
	self._opType = 205
	self._viewConfig = {
		{
			default = 10,
			name = "count",
			title = "社团成员",
			type = "Input"
		}
	}
end
