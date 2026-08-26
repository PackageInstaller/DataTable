-- chunkname: @modules/configs/excel2json/lua_challenge_const.lua

module("modules.configs.excel2json.lua_challenge_const", package.seeall)

local lua_challenge_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_challenge_const.onLoad(json)
	lua_challenge_const.configList, lua_challenge_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_challenge_const
