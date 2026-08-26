-- chunkname: @modules/configs/excel2json/lua_slow_release_gift.lua

module("modules.configs.excel2json.lua_slow_release_gift", package.seeall)

local lua_slow_release_gift = {}
local fields = {
	onceBonus = 3,
	desc2 = 6,
	dailyBonus = 4,
	days = 2,
	id = 1,
	desc1 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc2 = 2,
	desc1 = 1
}

function lua_slow_release_gift.onLoad(json)
	lua_slow_release_gift.configList, lua_slow_release_gift.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_slow_release_gift
