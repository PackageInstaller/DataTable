-- chunkname: @modules/configs/excel2json/lua_toast.lua

module("modules.configs.excel2json.lua_toast", package.seeall)

local lua_toast = {}
local fields = {
	audioId = 4,
	tips = 2,
	notMerge = 5,
	notShow = 6,
	id = 1,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 1
}

function lua_toast.onLoad(json)
	lua_toast.configList, lua_toast.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_toast
