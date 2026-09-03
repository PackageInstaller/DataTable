-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddSurface.lua

AddSurface = class("AddSurface", DebugViewTemplate, _M)

function AddSurface:initialize()
	self._opType = 298
	self._viewConfig = {
		{
			default = -1,
			name = "surfaceId",
			title = "皮肤ID，默认所有皮肤",
			type = "Input"
		}
	}
end
