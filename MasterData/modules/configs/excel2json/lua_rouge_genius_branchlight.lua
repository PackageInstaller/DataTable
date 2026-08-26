-- chunkname: @modules/configs/excel2json/lua_rouge_genius_branchlight.lua

module("modules.configs.excel2json.lua_rouge_genius_branchlight", package.seeall)

local lua_rouge_genius_branchlight = {}
local fields = {
	lightname = 3,
	talent = 2,
	id = 1,
	pos = 4,
	order = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge_genius_branchlight.onLoad(json)
	lua_rouge_genius_branchlight.configList, lua_rouge_genius_branchlight.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_genius_branchlight
