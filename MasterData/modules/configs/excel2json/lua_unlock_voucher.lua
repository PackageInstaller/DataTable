-- chunkname: @modules/configs/excel2json/lua_unlock_voucher.lua

module("modules.configs.excel2json.lua_unlock_voucher", package.seeall)

local lua_unlock_voucher = {}
local fields = {
	name = 2,
	id = 1,
	icon = 4,
	rare = 3,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_unlock_voucher.onLoad(json)
	lua_unlock_voucher.configList, lua_unlock_voucher.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_unlock_voucher
