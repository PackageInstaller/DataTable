-- chunkname: @modules/configs/excel2json/lua_activity114_photo.lua

module("modules.configs.excel2json.lua_activity114_photo", package.seeall)

local lua_activity114_photo = {}
local fields = {
	name = 4,
	bigCg = 7,
	condition = 3,
	desc = 9,
	smallCg = 6,
	id = 2,
	features = 8,
	activityId = 1,
	nameEn = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}

function lua_activity114_photo.onLoad(json)
	lua_activity114_photo.configList, lua_activity114_photo.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity114_photo
