-- chunkname: @modules/configs/excel2json/lua_nfc_recognize.lua

module("modules.configs.excel2json.lua_nfc_recognize", package.seeall)

local lua_nfc_recognize = {}
local fields = {
	param = 3,
	unlockId = 5,
	unclaimedId = 6,
	type = 2,
	id = 1,
	notMainTipsId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_nfc_recognize.onLoad(json)
	lua_nfc_recognize.configList, lua_nfc_recognize.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_nfc_recognize
