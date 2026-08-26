-- chunkname: @modules/configs/excel2json/lua_activity174_test_enhance.lua

module("modules.configs.excel2json.lua_activity174_test_enhance", package.seeall)

local lua_activity174_test_enhance = {}
local fields = {
	icon = 5,
	costCoin = 6,
	id = 1,
	title = 3,
	rare = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}

function lua_activity174_test_enhance.onLoad(json)
	lua_activity174_test_enhance.configList, lua_activity174_test_enhance.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity174_test_enhance
