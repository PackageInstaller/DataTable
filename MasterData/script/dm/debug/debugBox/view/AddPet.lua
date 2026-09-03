-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddPet.lua

AddPet = class("AddPet", DebugViewTemplate, _M)

function AddPet:initialize()
	self._opType = 108
	self._viewConfig = {
		{
			default = "YFZZhu",
			name = "heroId",
			title = "宠物ID",
			type = "Input"
		}
	}
end
