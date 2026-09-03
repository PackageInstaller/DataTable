-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/SetMeToPresident.lua

SetMeToPresident = class("SetMeToPresident", DebugViewTemplate, _M)

function SetMeToPresident:initialize()
	self._opType = 208
	self._viewConfig = {
		{
			default = 100,
			name = "",
			title = "设置自己为社长",
			type = ""
		}
	}
end
