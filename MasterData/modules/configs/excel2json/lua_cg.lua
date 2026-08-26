-- chunkname: @modules/configs/excel2json/lua_cg.lua

module("modules.configs.excel2json.lua_cg", package.seeall)

local lua_cg = {}
local fields = {
	preCgId = 9,
	name = 4,
	nameEn = 5,
	storyChapterId = 3,
	desc = 6,
	image = 8,
	episodeId = 7,
	herostoryId = 10,
	id = 1,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_cg.onLoad(json)
	lua_cg.configList, lua_cg.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_cg
