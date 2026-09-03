-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/ChangeLevelDV.lua

ChangeLevelDV = class("ChangeLevelDV", DebugViewTemplate, _M)

function ChangeLevelDV:initialize()
	self._opType = 105
	self._viewConfig = {
		{
			default = 50,
			name = "level",
			title = "level",
			type = "Input"
		}
	}
end

AddHeadFrame = class("AddHeadFrame", DebugViewTemplate, _M)

function AddHeadFrame:initialize()
	self._opType = 142
	self._viewConfig = {
		{
			default = "",
			name = "headId",
			title = "头像框Id",
			type = "Input"
		}
	}
end
