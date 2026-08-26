-- chunkname: @modules/configs/excel2json/lua_hero3124_buff_talent.lua

module("modules.configs.excel2json.lua_hero3124_buff_talent", package.seeall)

local lua_hero3124_buff_talent = {}
local fields = {
	buffId = 1,
	rank = 2
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}

function lua_hero3124_buff_talent.onLoad(json)
	lua_hero3124_buff_talent.configList, lua_hero3124_buff_talent.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_hero3124_buff_talent
