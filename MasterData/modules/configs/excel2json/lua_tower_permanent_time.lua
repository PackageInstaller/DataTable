-- chunkname: @modules/configs/excel2json/lua_tower_permanent_time.lua

module("modules.configs.excel2json.lua_tower_permanent_time", package.seeall)

local lua_tower_permanent_time = {}
local fields = {
	stageId = 1,
	name = 3,
	time = 2,
	nameEn = 4
}
local primaryKey = {
	"stageId"
}
local mlStringKey = {
	name = 1
}

function lua_tower_permanent_time.onLoad(json)
	lua_tower_permanent_time.configList, lua_tower_permanent_time.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_tower_permanent_time
