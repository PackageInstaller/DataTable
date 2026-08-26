-- chunkname: @modules/configs/excel2json/lua_survival_talk.lua

module("modules.configs.excel2json.lua_survival_talk", package.seeall)

local lua_survival_talk = {}
local fields = {
	id = 1,
	animType = 4,
	content = 3,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	content = 1
}

function lua_survival_talk.onLoad(json)
	lua_survival_talk.configList, lua_survival_talk.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_talk
