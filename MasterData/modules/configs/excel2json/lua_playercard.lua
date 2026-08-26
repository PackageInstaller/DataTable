-- chunkname: @modules/configs/excel2json/lua_playercard.lua

module("modules.configs.excel2json.lua_playercard", package.seeall)

local lua_playercard = {}
local fields = {
	name = 3,
	type = 2,
	id = 1,
	displayPriority = 5,
	nameEn = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_playercard.onLoad(json)
	lua_playercard.configList, lua_playercard.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_playercard
