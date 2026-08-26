-- chunkname: @modules/configs/excel2json/lua_turnback_return_range.lua

module("modules.configs.excel2json.lua_turnback_return_range", package.seeall)

local lua_turnback_return_range = {}
local fields = {
	lossDays = 2,
	rangeId = 1
}
local primaryKey = {
	"rangeId"
}
local mlStringKey = {}

function lua_turnback_return_range.onLoad(json)
	lua_turnback_return_range.configList, lua_turnback_return_range.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_return_range
