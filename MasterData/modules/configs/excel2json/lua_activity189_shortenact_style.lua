-- chunkname: @modules/configs/excel2json/lua_activity189_shortenact_style.lua

module("modules.configs.excel2json.lua_activity189_shortenact_style", package.seeall)

local lua_activity189_shortenact_style = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity189_shortenact_style.onLoad(json)
	lua_activity189_shortenact_style.configList, lua_activity189_shortenact_style.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity189_shortenact_style
