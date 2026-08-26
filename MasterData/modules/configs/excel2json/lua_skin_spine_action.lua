-- chunkname: @modules/configs/excel2json/lua_skin_spine_action.lua

module("modules.configs.excel2json.lua_skin_spine_action", package.seeall)

local lua_skin_spine_action = {}
local fields = {
	audioId = 6,
	effect = 3,
	effectRemoveTime = 5,
	skinId = 1,
	effectHangPoint = 4,
	dieAnim = 7,
	actionName = 2
}
local primaryKey = {
	"skinId",
	"actionName"
}
local mlStringKey = {}

function lua_skin_spine_action.onLoad(json)
	lua_skin_spine_action.configList, lua_skin_spine_action.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_spine_action
