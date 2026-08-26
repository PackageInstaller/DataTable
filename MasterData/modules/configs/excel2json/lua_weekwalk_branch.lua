-- chunkname: @modules/configs/excel2json/lua_weekwalk_branch.lua

module("modules.configs.excel2json.lua_weekwalk_branch", package.seeall)

local lua_weekwalk_branch = {}
local fields = {
	mapId = 2,
	name = 4,
	nodePath = 6,
	id = 1,
	finishNodeId = 3,
	handbookPath = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_weekwalk_branch.onLoad(json)
	lua_weekwalk_branch.configList, lua_weekwalk_branch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_weekwalk_branch
