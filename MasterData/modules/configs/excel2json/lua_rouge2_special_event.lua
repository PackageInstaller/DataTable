-- chunkname: @modules/configs/excel2json/lua_rouge2_special_event.lua

module("modules.configs.excel2json.lua_rouge2_special_event", package.seeall)

local lua_rouge2_special_event = {}
local fields = {
	id = 1,
	param = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_special_event.onLoad(json)
	lua_rouge2_special_event.configList, lua_rouge2_special_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_special_event
