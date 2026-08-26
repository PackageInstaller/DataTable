-- chunkname: @modules/configs/excel2json/lua_copost_password_paper.lua

module("modules.configs.excel2json.lua_copost_password_paper", package.seeall)

local lua_copost_password_paper = {}
local fields = {
	id = 1,
	diskText = 5,
	item = 7,
	order = 6,
	allNum = 3,
	diskIcon = 4,
	viewType = 8,
	versionId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	diskText = 1
}

function lua_copost_password_paper.onLoad(json)
	lua_copost_password_paper.configList, lua_copost_password_paper.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_copost_password_paper
