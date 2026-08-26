-- chunkname: @modules/configs/excel2json/lua_fight_stacked_buff_combine.lua

module("modules.configs.excel2json.lua_fight_stacked_buff_combine", package.seeall)

local lua_fight_stacked_buff_combine = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_fight_stacked_buff_combine.onLoad(json)
	lua_fight_stacked_buff_combine.configList, lua_fight_stacked_buff_combine.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_stacked_buff_combine
