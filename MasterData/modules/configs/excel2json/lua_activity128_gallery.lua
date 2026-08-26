-- chunkname: @modules/configs/excel2json/lua_activity128_gallery.lua

module("modules.configs.excel2json.lua_activity128_gallery", package.seeall)

local lua_activity128_gallery = {}
local fields = {
	lurkNumber = 9,
	point = 6,
	typeName = 3,
	type = 1,
	pointExp = 7,
	galleryBg = 5,
	offline = 11,
	minType = 4,
	recommendStrategy = 8,
	id = 2,
	sort = 10
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	typeName = 1
}

function lua_activity128_gallery.onLoad(json)
	lua_activity128_gallery.configList, lua_activity128_gallery.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity128_gallery
