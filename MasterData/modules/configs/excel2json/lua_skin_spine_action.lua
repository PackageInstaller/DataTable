-- chunkname: @modules/configs/excel2json/lua_skin_spine_action.lua

module("modules.configs.excel2json.lua_skin_spine_action", package.seeall)

local lua_skin_spine_action = {}
local fields = {
	effectForSub = 8,
	effect = 3,
	effectRemoveTime = 5,
	dieAnim = 7,
	skinId = 1,
	effectHandPointForSub = 9,
	effectRemoveTimeForSub = 10,
	audioId = 6,
	audioIdForSub = 11,
	effectHangPoint = 4,
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
