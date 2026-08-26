-- chunkname: @modules/configs/excel2json/lua_buff_act.lua

module("modules.configs.excel2json.lua_buff_act", package.seeall)

local lua_buff_act = {}
local fields = {
	audioId = 7,
	effect = 5,
	effectHangPoint = 6,
	type = 2,
	id = 1,
	effectCondition = 4,
	effectTime = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_buff_act.onLoad(json)
	lua_buff_act.configList, lua_buff_act.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_buff_act
