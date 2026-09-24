-- chunkname: @modules/configs/excel2json/lua_activity220_deleike.lua

module("modules.configs.excel2json.lua_activity220_deleike", package.seeall)

local lua_activity220_deleike = {}
local fields = {
	mapJson = 4,
	mapBg = 3,
	targetDesc = 2,
	gameId = 1
}
local primaryKey = {
	"gameId"
}
local mlStringKey = {
	targetDesc = 1
}

function lua_activity220_deleike.onLoad(json)
	lua_activity220_deleike.configList, lua_activity220_deleike.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity220_deleike
