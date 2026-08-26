-- chunkname: @modules/configs/excel2json/lua_activity_decoration.lua

module("modules.configs.excel2json.lua_activity_decoration", package.seeall)

local lua_activity_decoration = {}
local fields = {
	id = 1,
	chargeRes = 2,
	chargeUIRes = 4,
	millisecond = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity_decoration.onLoad(json)
	lua_activity_decoration.configList, lua_activity_decoration.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity_decoration
