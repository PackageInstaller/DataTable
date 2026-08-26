-- chunkname: @modules/configs/excel2json/lua_rouge_shop_event.lua

module("modules.configs.excel2json.lua_rouge_shop_event", package.seeall)

local lua_rouge_shop_event = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}

function lua_rouge_shop_event.onLoad(json)
	lua_rouge_shop_event.configList, lua_rouge_shop_event.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_shop_event
