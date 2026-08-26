-- chunkname: @modules/configs/excel2json/lua_skill_target_type_define.lua

module("modules.configs.excel2json.lua_skill_target_type_define", package.seeall)

local lua_skill_target_type_define = {}
local fields = {
	logicTarget = 1,
	define = 2
}
local primaryKey = {
	"logicTarget"
}
local mlStringKey = {}

function lua_skill_target_type_define.onLoad(json)
	lua_skill_target_type_define.configList, lua_skill_target_type_define.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_target_type_define
