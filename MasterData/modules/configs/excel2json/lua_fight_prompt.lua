-- chunkname: @modules/configs/excel2json/lua_fight_prompt.lua

module("modules.configs.excel2json.lua_fight_prompt", package.seeall)

local lua_fight_prompt = {}
local fields = {
	id = 1,
	color = 3,
	content = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}

function lua_fight_prompt.onLoad(json)
	lua_fight_prompt.configList, lua_fight_prompt.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_prompt
