-- chunkname: @modules/configs/excel2json/lua_activity129_goods.lua

module("modules.configs.excel2json.lua_activity129_goods", package.seeall)

local lua_activity129_goods = {}
local fields = {
	id = 1,
	goodsId = 3,
	rare = 2
}
local primaryKey = {
	"id",
	"rare"
}
local mlStringKey = {}

function lua_activity129_goods.onLoad(json)
	lua_activity129_goods.configList, lua_activity129_goods.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity129_goods
