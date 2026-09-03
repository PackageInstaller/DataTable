-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/RebootLua.lua

RebootLua = class("RebootLua", DebugViewTemplate, _M)

function RebootLua:initialize()
	self._viewConfig = {
		{
			title = "重启刷新",
			name = "result",
			type = "Label"
		}
	}
end

function RebootLua:onClick(data)
	REBOOT()
end
