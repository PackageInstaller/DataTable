-- chunkname: @modules/configs/excel2json/lua_rouge2_drop_group.lua

module("modules.configs.excel2json.lua_rouge2_drop_group", package.seeall)

local lua_rouge2_drop_group = {}
local fields = {
	dropParm = 2,
	dropType = 1
}
local primaryKey = {}
local mlStringKey = {}

function lua_rouge2_drop_group.onLoad(json)
	lua_rouge2_drop_group.configList, lua_rouge2_drop_group.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_rouge2_drop_group
