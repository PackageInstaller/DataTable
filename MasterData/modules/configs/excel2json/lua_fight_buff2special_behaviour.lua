-- chunkname: @modules/configs/excel2json/lua_fight_buff2special_behaviour.lua

module("modules.configs.excel2json.lua_fight_buff2special_behaviour", package.seeall)

local lua_fight_buff2special_behaviour = {}
local fields = {
	behaviour = 2,
	param = 3,
	buffId = 1
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}

function lua_fight_buff2special_behaviour.onLoad(json)
	lua_fight_buff2special_behaviour.configList, lua_fight_buff2special_behaviour.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_buff2special_behaviour
