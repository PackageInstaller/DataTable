-- chunkname: @modules/configs/excel2json/lua_rouge2_buff_icon.lua

module("modules.configs.excel2json.lua_rouge2_buff_icon", package.seeall)

local lua_rouge2_buff_icon = {}
local fields = {
	id = 1,
	icon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}

function lua_rouge2_buff_icon.onLoad(json)
	lua_rouge2_buff_icon.configList, lua_rouge2_buff_icon.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_buff_icon
