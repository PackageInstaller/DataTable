-- chunkname: @modules/configs/excel2json/lua_activity244_talent_branch.lua

module("modules.configs.excel2json.lua_activity244_talent_branch", package.seeall)

local lua_activity244_talent_branch = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3,
	nodeBg = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_activity244_talent_branch.onLoad(json)
	lua_activity244_talent_branch.configList, lua_activity244_talent_branch.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity244_talent_branch
