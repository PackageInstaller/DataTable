-- chunkname: @modules/configs/excel2json/lua_activity224_title.lua

module("modules.configs.excel2json.lua_activity224_title", package.seeall)

local lua_activity224_title = {}
local fields = {
	titleId = 1,
	titleBackground = 4,
	titleType = 2,
	titleName = 3
}
local primaryKey = {
	"titleId"
}
local mlStringKey = {
	titleName = 1
}

function lua_activity224_title.onLoad(json)
	lua_activity224_title.configList, lua_activity224_title.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity224_title
