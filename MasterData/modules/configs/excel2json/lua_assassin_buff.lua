-- chunkname: @modules/configs/excel2json/lua_assassin_buff.lua

module("modules.configs.excel2json.lua_assassin_buff", package.seeall)

local lua_assassin_buff = {}
local fields = {
	buffEffect = 4,
	effectId = 5,
	buffId = 1,
	type = 2,
	duration = 3
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}

function lua_assassin_buff.onLoad(json)
	lua_assassin_buff.configList, lua_assassin_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_buff
