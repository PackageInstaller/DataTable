-- chunkname: @modules/configs/excel2json/lua_copost_time_axis.lua

module("modules.configs.excel2json.lua_copost_time_axis", package.seeall)

local lua_copost_time_axis = {}
local fields = {
	id = 2,
	timeId = 3,
	sceneId = 4,
	versionId = 1
}
local primaryKey = {
	"versionId",
	"id"
}
local mlStringKey = {}

function lua_copost_time_axis.onLoad(json)
	lua_copost_time_axis.configList, lua_copost_time_axis.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_time_axis
