-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddKernel.lua

AddKernel = class("AddKernel", DebugViewTemplate, _M)

function AddKernel:initialize()
	self._opType = 122
	self._viewConfig = {
		{
			default = "Suite_Test01_01",
			name = "code",
			title = "核心ID",
			type = "Input"
		},
		{
			default = 1,
			name = "count",
			title = "核心数量",
			type = "Input"
		}
	}
end
