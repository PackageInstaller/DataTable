-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_photo_item_list.lua

module("modules.configs.excel2json.lua_v2a4_warmup_photo_item_list", package.seeall)

local lua_v2a4_warmup_photo_item_list = {}
local fields = {
	imgName = 3,
	yes3 = 12,
	yes1 = 8,
	passTalkAllYes = 5,
	yes2 = 10,
	no2 = 11,
	preTalk = 4,
	passTalk = 6,
	failTalk = 7,
	no3 = 13,
	id = 1,
	no1 = 9,
	level = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_v2a4_warmup_photo_item_list.onLoad(json)
	lua_v2a4_warmup_photo_item_list.configList, lua_v2a4_warmup_photo_item_list.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_v2a4_warmup_photo_item_list
