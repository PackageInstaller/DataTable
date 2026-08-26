-- chunkname: @modules/configs/excel2json/lua_activity163_clue.lua

module("modules.configs.excel2json.lua_activity163_clue", package.seeall)

local lua_activity163_clue = {}
local fields = {
	clueName = 3,
	materialId = 6,
	clueIcon = 2,
	clueId = 1,
	clueDesc = 4,
	replaceId = 7,
	episodeId = 5
}
local primaryKey = {
	"clueId"
}
local mlStringKey = {
	clueName = 1,
	clueDesc = 2
}

function lua_activity163_clue.onLoad(json)
	lua_activity163_clue.configList, lua_activity163_clue.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity163_clue
