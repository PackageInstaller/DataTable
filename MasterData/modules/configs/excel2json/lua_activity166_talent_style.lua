-- chunkname: @modules/configs/excel2json/lua_activity166_talent_style.lua

module("modules.configs.excel2json.lua_activity166_talent_style", package.seeall)

local lua_activity166_talent_style = {}
local fields = {
	needStar = 3,
	slot = 6,
	skillId2 = 5,
	skillId = 4,
	talentId = 1,
	level = 2
}
local primaryKey = {
	"talentId",
	"level"
}
local mlStringKey = {}

function lua_activity166_talent_style.onLoad(json)
	lua_activity166_talent_style.configList, lua_activity166_talent_style.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_talent_style
