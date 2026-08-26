-- chunkname: @modules/configs/excel2json/lua_rouge_dlc3_const.lua

module("modules.configs.excel2json.lua_rouge_dlc3_const", package.seeall)

local lua_rouge_dlc3_const = {}
local fields = {
	value = 2,
	id = 1,
	value2 = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value2 = 1
}

function lua_rouge_dlc3_const.onLoad(json)
	lua_rouge_dlc3_const.configList, lua_rouge_dlc3_const.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_dlc3_const
