-- chunkname: @modules/configs/excel2json/lua_paper_trail.lua

module("modules.configs.excel2json.lua_paper_trail", package.seeall)

local lua_paper_trail = {}
local fields = {
	notShow = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}

function lua_paper_trail.onLoad(json)
	lua_paper_trail.configList, lua_paper_trail.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_paper_trail
