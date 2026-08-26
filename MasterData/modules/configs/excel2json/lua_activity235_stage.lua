-- chunkname: @modules/configs/excel2json/lua_activity235_stage.lua

module("modules.configs.excel2json.lua_activity235_stage", package.seeall)

local lua_activity235_stage = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity235_stage.onLoad(json)
	lua_activity235_stage.configList, lua_activity235_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity235_stage
