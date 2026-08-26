-- chunkname: @modules/configs/excel2json/lua_fight_technique.lua

module("modules.configs.excel2json.lua_fight_technique", package.seeall)

local lua_fight_technique = {}
local fields = {
	title_cn = 7,
	iconShow = 9,
	picture1 = 10,
	picture2 = 11,
	mainTitleId = 2,
	noDisplayType = 15,
	condition = 4,
	displayType = 14,
	isCn = 13,
	title_en = 8,
	mainTitle_en = 6,
	mainTitle_cn = 5,
	id = 1,
	content1 = 12,
	group = 16,
	subTitleId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title_cn = 3,
	content1 = 4,
	mainTitle_en = 2,
	mainTitle_cn = 1
}

function lua_fight_technique.onLoad(json)
	lua_fight_technique.configList, lua_fight_technique.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_technique
