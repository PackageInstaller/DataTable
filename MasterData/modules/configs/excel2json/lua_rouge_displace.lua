-- chunkname: @modules/configs/excel2json/lua_rouge_displace.lua

module("modules.configs.excel2json.lua_rouge_displace", package.seeall)

local lua_rouge_displace = {}
local fields = {
	season = 1,
	quality = 3,
	id = 2,
	upDropGroup = 5,
	dropGroup = 4
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {}

function lua_rouge_displace.onLoad(json)
	lua_rouge_displace.configList, lua_rouge_displace.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge_displace
