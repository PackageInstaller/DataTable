-- chunkname: @modules/configs/excel2json/lua_toughnessskill.lua

module("modules.configs.excel2json.lua_toughnessskill", package.seeall)

local lua_toughnessskill = {}
local fields = {
	iconBreak = 5,
	passiveSkill = 2,
	toughnessskill = 1,
	iconNormal = 4,
	cdBuff = 3
}
local primaryKey = {
	"toughnessskill"
}
local mlStringKey = {}

function lua_toughnessskill.onLoad(json)
	lua_toughnessskill.configList, lua_toughnessskill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_toughnessskill
