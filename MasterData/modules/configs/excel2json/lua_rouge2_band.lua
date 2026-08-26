-- chunkname: @modules/configs/excel2json/lua_rouge2_band.lua

module("modules.configs.excel2json.lua_rouge2_band", package.seeall)

local lua_rouge2_band = {}
local fields = {
	cost = 3,
	name = 2,
	id = 1,
	icon = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_rouge2_band.onLoad(json)
	lua_rouge2_band.configList, lua_rouge2_band.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_band
