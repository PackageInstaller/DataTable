-- chunkname: @modules/configs/excel2json/lua_actvity186_like.lua

module("modules.configs.excel2json.lua_actvity186_like", package.seeall)

local lua_actvity186_like = {}
local fields = {
	nameen = 4,
	name = 3,
	basevalueornot = 6,
	type = 1,
	icon = 5,
	activityId = 2
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	name = 1
}

function lua_actvity186_like.onLoad(json)
	lua_actvity186_like.configList, lua_actvity186_like.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_actvity186_like
