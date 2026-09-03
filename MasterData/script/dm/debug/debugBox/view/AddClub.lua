-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddClub.lua

AddClub = class("AddClub", DebugViewTemplate, _M)

function AddClub:initialize()
	self._opType = 201
	self._viewConfig = {
		{
			default = 10,
			name = "count",
			title = "社团数量",
			type = "Input"
		}
	}
end
