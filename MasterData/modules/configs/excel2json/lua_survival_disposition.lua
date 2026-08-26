-- chunkname: @modules/configs/excel2json/lua_survival_disposition.lua

module("modules.configs.excel2json.lua_survival_disposition", package.seeall)

local lua_survival_disposition = {}
local fields = {
	attribute4 = 7,
	attribute3 = 6,
	attribute1 = 4,
	type = 2,
	id = 1,
	attribute2 = 5,
	attribute5 = 8,
	level = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_survival_disposition.onLoad(json)
	lua_survival_disposition.configList, lua_survival_disposition.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_survival_disposition
