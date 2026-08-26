-- chunkname: @modules/configs/excel2json/lua_survival_message.lua

module("modules.configs.excel2json.lua_survival_message", package.seeall)

local lua_survival_message = {}
local fields = {
	id = 1,
	type = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_survival_message.onLoad(json)
	lua_survival_message.configList, lua_survival_message.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_message
