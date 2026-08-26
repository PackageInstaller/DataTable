-- chunkname: @modules/configs/excel2json/lua_version_res_split.lua

module("modules.configs.excel2json.lua_version_res_split", package.seeall)

local lua_version_res_split = {}
local fields = {
	ignore = 12,
	packName = 11,
	videoPath = 7,
	audio = 2,
	folderPath = 6,
	guide = 4,
	uiFolder = 9,
	story = 5,
	path = 8,
	chapter = 3,
	id = 1,
	uiPath = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_version_res_split.onLoad(json)
	lua_version_res_split.configList, lua_version_res_split.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_version_res_split
