-- chunkname: @modules/configs/excel2json/lua_auto_chess_skill_eff_desc.lua

module("modules.configs.excel2json.lua_auto_chess_skill_eff_desc", package.seeall)

local lua_auto_chess_skill_eff_desc = {}
local fields = {
	id = 1,
	name = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_auto_chess_skill_eff_desc.onLoad(json)
	lua_auto_chess_skill_eff_desc.configList, lua_auto_chess_skill_eff_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_auto_chess_skill_eff_desc
