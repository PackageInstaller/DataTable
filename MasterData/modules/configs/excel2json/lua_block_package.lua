-- chunkname: @modules/configs/excel2json/lua_block_package.lua

module("modules.configs.excel2json.lua_block_package", package.seeall)

local lua_block_package = {}
local fields = {
	blockBuildDegree = 12,
	name = 2,
	useDesc = 3,
	free = 11,
	sources = 10,
	canExchange = 14,
	rare = 7,
	desc = 4,
	showOnly = 13,
	sourcesType = 9,
	id = 1,
	icon = 5,
	rewardIcon = 6,
	nameEn = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	useDesc = 2,
	desc = 3
}

function lua_block_package.onLoad(json)
	lua_block_package.configList, lua_block_package.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_block_package
