-- chunkname: @modules/configs/excel2json/lua_college_stage.lua

module("modules.configs.excel2json.lua_college_stage", package.seeall)

local lua_college_stage = {}
local fields = {
	id = 1,
	title = 2,
	nextStageId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}

function lua_college_stage.onLoad(json)
	lua_college_stage.configList, lua_college_stage.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_college_stage
