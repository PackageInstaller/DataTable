-- chunkname: @modules/configs/excel2json/lua_copost_version.lua

module("modules.configs.excel2json.lua_copost_version", package.seeall)

local lua_copost_version = {}
local fields = {
	id = 2,
	timeId = 3,
	versionId = 1
}
local primaryKey = {
	"versionId"
}
local mlStringKey = {
	timeId = 1
}

function lua_copost_version.onLoad(json)
	lua_copost_version.configList, lua_copost_version.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_version
