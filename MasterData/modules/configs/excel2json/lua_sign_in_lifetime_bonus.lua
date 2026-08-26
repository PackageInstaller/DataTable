-- chunkname: @modules/configs/excel2json/lua_sign_in_lifetime_bonus.lua

module("modules.configs.excel2json.lua_sign_in_lifetime_bonus", package.seeall)

local lua_sign_in_lifetime_bonus = {}
local fields = {
	logindaysid = 2,
	stagetitle = 3,
	bonus = 4,
	stageid = 1
}
local primaryKey = {
	"stageid"
}
local mlStringKey = {
	stagetitle = 1
}

function lua_sign_in_lifetime_bonus.onLoad(json)
	lua_sign_in_lifetime_bonus.configList, lua_sign_in_lifetime_bonus.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sign_in_lifetime_bonus
