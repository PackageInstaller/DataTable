-- chunkname: @modules/configs/excel2json/lua_activity189_shortenact.lua

module("modules.configs.excel2json.lua_activity189_shortenact", package.seeall)

local lua_activity189_shortenact = {}
local fields = {
	id = 1,
	version = 2,
	style = 4,
	settingId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_activity189_shortenact.onLoad(json)
	lua_activity189_shortenact.configList, lua_activity189_shortenact.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity189_shortenact
