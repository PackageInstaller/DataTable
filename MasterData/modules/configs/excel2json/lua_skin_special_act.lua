-- chunkname: @modules/configs/excel2json/lua_skin_special_act.lua

module("modules.configs.excel2json.lua_skin_special_act", package.seeall)

local lua_skin_special_act = {}
local fields = {
	loop = 2,
	probability = 4,
	condition = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_skin_special_act.onLoad(json)
	lua_skin_special_act.configList, lua_skin_special_act.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skin_special_act
