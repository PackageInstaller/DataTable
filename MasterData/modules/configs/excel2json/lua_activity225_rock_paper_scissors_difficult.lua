-- chunkname: @modules/configs/excel2json/lua_activity225_rock_paper_scissors_difficult.lua

module("modules.configs.excel2json.lua_activity225_rock_paper_scissors_difficult", package.seeall)

local lua_activity225_rock_paper_scissors_difficult = {}
local fields = {
	difficulty = 2,
	day = 1
}
local primaryKey = {
	"day"
}
local mlStringKey = {}

function lua_activity225_rock_paper_scissors_difficult.onLoad(json)
	lua_activity225_rock_paper_scissors_difficult.configList, lua_activity225_rock_paper_scissors_difficult.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_activity225_rock_paper_scissors_difficult
