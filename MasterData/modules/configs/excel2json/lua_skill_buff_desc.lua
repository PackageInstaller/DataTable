-- chunkname: @modules/configs/excel2json/lua_skill_buff_desc.lua

module("modules.configs.excel2json.lua_skill_buff_desc", package.seeall)

local lua_skill_buff_desc = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}

function lua_skill_buff_desc.onLoad(json)
	lua_skill_buff_desc.configList, lua_skill_buff_desc.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_skill_buff_desc
