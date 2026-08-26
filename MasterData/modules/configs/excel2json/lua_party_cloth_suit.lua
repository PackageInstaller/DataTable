-- chunkname: @modules/configs/excel2json/lua_party_cloth_suit.lua

module("modules.configs.excel2json.lua_party_cloth_suit", package.seeall)

local lua_party_cloth_suit = {}
local fields = {
	id = 1,
	name = 2,
	rare = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_party_cloth_suit.onLoad(json)
	lua_party_cloth_suit.configList, lua_party_cloth_suit.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_party_cloth_suit
