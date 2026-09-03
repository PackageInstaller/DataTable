-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/redpoint/RedPointRefreshCommond.lua

EVT_REDPOINT_REFRESH = "EVT_REDPOINT_REFRESH"
RedPointRefreshCommond = class("RedPointRefreshCommond", legs.Command, _M)

function RedPointRefreshCommond:execute(event)
	local redPointManager = RedPointManager:getInstance()

	redPointManager:refresh()
end
