-- chunkname: @modules/configs/excel2json/lua_atomic_drag_element_toast.lua

module("modules.configs.excel2json.lua_atomic_drag_element_toast", package.seeall)

local lua_atomic_drag_element_toast = {}
local fields = {
	id = 1,
	toast = 3,
	targetId = 2
}
local primaryKey = {
	"id",
	"targetId"
}
local mlStringKey = {
	toast = 1
}

function lua_atomic_drag_element_toast.onLoad(json)
	lua_atomic_drag_element_toast.configList, lua_atomic_drag_element_toast.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_atomic_drag_element_toast
