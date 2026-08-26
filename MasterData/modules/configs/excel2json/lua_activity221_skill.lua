-- chunkname: @modules/configs/excel2json/lua_activity221_skill.lua

module("modules.configs.excel2json.lua_activity221_skill", package.seeall)

local lua_activity221_skill = {}
local fields = {
	effects = 5,
	skillID = 1,
	skilldesc = 4,
	cd = 6,
	skillType = 2,
	condition = 3
}
local primaryKey = {
	"skillID"
}
local mlStringKey = {
	skilldesc = 1
}

function lua_activity221_skill.onLoad(json)
	lua_activity221_skill.configList, lua_activity221_skill.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity221_skill
