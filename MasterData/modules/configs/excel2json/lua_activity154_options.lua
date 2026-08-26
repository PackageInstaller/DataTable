-- chunkname: @modules/configs/excel2json/lua_activity154_options.lua

module("modules.configs.excel2json.lua_activity154_options", package.seeall)

local lua_activity154_options = {}
local fields = {
	optionText = 3,
	optionId = 2,
	puzzleId = 1
}
local primaryKey = {
	"puzzleId",
	"optionId"
}
local mlStringKey = {
	optionText = 1
}

function lua_activity154_options.onLoad(json)
	lua_activity154_options.configList, lua_activity154_options.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity154_options
