-- chunkname: @modules/configs/excel2json/lua_sign_in_addup_bonus.lua

module("modules.configs.excel2json.lua_sign_in_addup_bonus", package.seeall)

local lua_sign_in_addup_bonus = {}
local fields = {
	id = 1,
	signinaddup = 3,
	signinBonus = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_sign_in_addup_bonus.onLoad(json)
	lua_sign_in_addup_bonus.configList, lua_sign_in_addup_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sign_in_addup_bonus
