-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddPlayerContribution.lua

AddPlayerContribution = class("AddPlayerContribution", DebugViewTemplate, _M)

function AddPlayerContribution:initialize()
	self._opType = 206
	self._viewConfig = {
		{
			default = 100,
			name = "count",
			title = "贡献点数",
			type = "Input"
		}
	}
end
