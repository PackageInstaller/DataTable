-- chunkname: @modules/configs/excel2json/lua_partygame_findheart.lua

module("modules.configs.excel2json.lua_partygame_findheart", package.seeall)

local lua_partygame_findheart = {}
local fields = {
	id = 1,
	answergroup = 3,
	difficulty = 2
}
local primaryKey = {
	"id",
	"difficulty"
}
local mlStringKey = {}

function lua_partygame_findheart.onLoad(json)
	lua_partygame_findheart.configList, lua_partygame_findheart.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_partygame_findheart
