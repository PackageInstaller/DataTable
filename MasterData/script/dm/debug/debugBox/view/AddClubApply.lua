-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddClubApply.lua

AddClubApply = class("AddClubApply", DebugViewTemplate, _M)

function AddClubApply:initialize()
	self._opType = 204
	self._viewConfig = {
		{
			default = 10,
			name = "count",
			title = "社团申请数量",
			type = "Input"
		}
	}
end
