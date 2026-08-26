-- chunkname: @modules/configs/excel2json/lua_activity179_combo.lua

module("modules.configs.excel2json.lua_activity179_combo", package.seeall)

local lua_activity179_combo = {}
local fields = {
	score = 4,
	combo = 3,
	resource = 5,
	id = 1,
	episodeId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity179_combo.onLoad(json)
	lua_activity179_combo.configList, lua_activity179_combo.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity179_combo
