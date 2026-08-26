-- chunkname: @modules/configs/excel2json/lua_assassin_career.lua

module("modules.configs.excel2json.lua_assassin_career", package.seeall)

local lua_assassin_career = {}
local fields = {
	equipName = 3,
	pic = 6,
	capacity = 4,
	attrs = 5,
	title = 2,
	careerId = 1
}
local primaryKey = {
	"careerId"
}
local mlStringKey = {
	equipName = 2,
	title = 1
}

function lua_assassin_career.onLoad(json)
	lua_assassin_career.configList, lua_assassin_career.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_career
