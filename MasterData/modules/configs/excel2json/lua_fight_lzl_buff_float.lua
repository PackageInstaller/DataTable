-- chunkname: @modules/configs/excel2json/lua_fight_lzl_buff_float.lua

module("modules.configs.excel2json.lua_fight_lzl_buff_float", package.seeall)

local lua_fight_lzl_buff_float = {}
local fields = {
	effectRoot = 5,
	effect = 4,
	effectAudio = 6,
	skinId = 3,
	id = 1,
	duration = 7,
	layer = 2
}
local primaryKey = {
	"id",
	"layer",
	"skinId"
}
local mlStringKey = {}

function lua_fight_lzl_buff_float.onLoad(json)
	lua_fight_lzl_buff_float.configList, lua_fight_lzl_buff_float.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_lzl_buff_float
