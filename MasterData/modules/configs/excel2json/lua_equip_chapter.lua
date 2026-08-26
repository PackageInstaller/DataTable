-- chunkname: @modules/configs/excel2json/lua_equip_chapter.lua

module("modules.configs.excel2json.lua_equip_chapter", package.seeall)

local lua_equip_chapter = {}
local fields = {
	id = 1,
	episodeList = 4,
	difficulty = 2,
	group = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_equip_chapter.onLoad(json)
	lua_equip_chapter.configList, lua_equip_chapter.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_equip_chapter
