-- chunkname: @modules/configs/excel2json/lua_rouge_path_select.lua

module("modules.configs.excel2json.lua_rouge_path_select", package.seeall)

local lua_rouge_path_select = {}
local fields = {
	startPos = 7,
	name = 3,
	focusMapPos = 5,
	endPos = 8,
	id = 1,
	version = 2,
	focusCameraSize = 6,
	mapRes = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_rouge_path_select.onLoad(json)
	lua_rouge_path_select.configList, lua_rouge_path_select.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_path_select
