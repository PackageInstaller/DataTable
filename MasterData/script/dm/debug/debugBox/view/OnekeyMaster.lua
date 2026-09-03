-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/OnekeyMaster.lua

OnekeyMaster = class("OnekeyMaster", DebugViewTemplate, _M)

function OnekeyMaster:initialize()
	self._opType = 118
	self._viewConfig = {
		{
			default = "Master_LieSha",
			name = "masterId",
			title = "主角ID",
			type = "Input"
		}
	}
end
