-- chunkname: @modules/configs/excel2json/lua_rouge_limit_buff.lua

module("modules.configs.excel2json.lua_rouge_limit_buff", package.seeall)

local lua_rouge_limit_buff = {}
local fields = {
	needEmblem = 8,
	buffType = 5,
	cd = 9,
	startView = 6,
	blank = 10,
	title = 3,
	icon = 11,
	desc = 4,
	initCollections = 7,
	id = 1,
	version = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_rouge_limit_buff.onLoad(json)
	lua_rouge_limit_buff.configList, lua_rouge_limit_buff.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_limit_buff
