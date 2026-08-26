-- chunkname: @modules/configs/excel2json/lua_sign_in_word.lua

module("modules.configs.excel2json.lua_sign_in_word", package.seeall)

local lua_sign_in_word = {}
local fields = {
	id = 1,
	signindate = 2,
	signinword = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	signinword = 1
}

function lua_sign_in_word.onLoad(json)
	lua_sign_in_word.configList, lua_sign_in_word.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_sign_in_word
