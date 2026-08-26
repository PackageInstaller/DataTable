-- chunkname: @modules/configs/excel2json/lua_magic_wqsz.lua

module("modules.configs.excel2json.lua_magic_wqsz", package.seeall)

local lua_magic_wqsz = {}
local fields = {
	id = 1,
	group = 3,
	returnLevel = 4,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_magic_wqsz.onLoad(json)
	lua_magic_wqsz.configList, lua_magic_wqsz.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_magic_wqsz
