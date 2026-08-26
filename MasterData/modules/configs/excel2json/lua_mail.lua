-- chunkname: @modules/configs/excel2json/lua_mail.lua

module("modules.configs.excel2json.lua_mail", package.seeall)

local lua_mail = {}
local fields = {
	jump = 13,
	locked = 16,
	sender = 3,
	type = 2,
	attachment = 6,
	title = 4,
	addressee = 8,
	copy = 9,
	specialTag = 11,
	content = 5,
	image = 14,
	jumpTitle = 12,
	id = 1,
	icon = 10,
	senderType = 15,
	needShowToast = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 3,
	title = 2,
	jumpTitle = 6,
	copy = 5,
	sender = 1,
	addressee = 4
}

function lua_mail.onLoad(json)
	lua_mail.configList, lua_mail.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_mail
