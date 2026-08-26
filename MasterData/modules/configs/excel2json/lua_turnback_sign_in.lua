-- chunkname: @modules/configs/excel2json/lua_turnback_sign_in.lua

module("modules.configs.excel2json.lua_turnback_sign_in", package.seeall)

local lua_turnback_sign_in = {}
local fields = {
	bonus = 3,
	name = 5,
	characterId = 4,
	turnbackId = 1,
	content = 6,
	day = 2
}
local primaryKey = {
	"turnbackId",
	"day"
}
local mlStringKey = {}

function lua_turnback_sign_in.onLoad(json)
	lua_turnback_sign_in.configList, lua_turnback_sign_in.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_turnback_sign_in
