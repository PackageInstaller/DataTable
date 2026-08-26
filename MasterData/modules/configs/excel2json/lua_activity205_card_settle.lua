-- chunkname: @modules/configs/excel2json/lua_activity205_card_settle.lua

module("modules.configs.excel2json.lua_activity205_card_settle", package.seeall)

local lua_activity205_card_settle = {}
local fields = {
	desc = 3,
	point = 1,
	rewardId = 2
}
local primaryKey = {
	"point"
}
local mlStringKey = {
	desc = 1
}

function lua_activity205_card_settle.onLoad(json)
	lua_activity205_card_settle.configList, lua_activity205_card_settle.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity205_card_settle
