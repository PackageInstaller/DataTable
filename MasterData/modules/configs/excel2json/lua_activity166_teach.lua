-- chunkname: @modules/configs/excel2json/lua_activity166_teach.lua

module("modules.configs.excel2json.lua_activity166_teach", package.seeall)

local lua_activity166_teach = {}
local fields = {
	episodeId = 3,
	name = 5,
	desc = 6,
	strategy = 7,
	teachId = 1,
	firstBonus = 4,
	preTeachId = 2
}
local primaryKey = {
	"teachId"
}
local mlStringKey = {
	strategy = 3,
	name = 1,
	desc = 2
}

function lua_activity166_teach.onLoad(json)
	lua_activity166_teach.configList, lua_activity166_teach.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity166_teach
