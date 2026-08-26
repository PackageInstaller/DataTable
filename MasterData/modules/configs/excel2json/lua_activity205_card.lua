-- chunkname: @modules/configs/excel2json/lua_activity205_card.lua

module("modules.configs.excel2json.lua_activity205_card", package.seeall)

local lua_activity205_card = {}
local fields = {
	restrain = 6,
	name = 3,
	type = 2,
	subWeight = 9,
	desc = 4,
	img = 5,
	id = 1,
	spEff = 7,
	weight = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity205_card.onLoad(json)
	lua_activity205_card.configList, lua_activity205_card.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity205_card
