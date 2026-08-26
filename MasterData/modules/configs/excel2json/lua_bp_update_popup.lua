-- chunkname: @modules/configs/excel2json/lua_bp_update_popup.lua

module("modules.configs.excel2json.lua_bp_update_popup", package.seeall)

local lua_bp_update_popup = {}
local fields = {
	startTime = 2,
	showItem = 5,
	endTime = 3,
	txt = 4,
	popupId = 1
}
local primaryKey = {
	"popupId"
}
local mlStringKey = {
	txt = 1
}

function lua_bp_update_popup.onLoad(json)
	lua_bp_update_popup.configList, lua_bp_update_popup.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_bp_update_popup
