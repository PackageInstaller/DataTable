-- chunkname: @modules/configs/excel2json/lua_fight_hnj_helmet_spine.lua

module("modules.configs.excel2json.lua_fight_hnj_helmet_spine", package.seeall)

local lua_fight_hnj_helmet_spine = {}
local fields = {
	pos = 3,
	effect = 4,
	hangPoint = 5,
	skinId = 1,
	resPath = 2
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}

function lua_fight_hnj_helmet_spine.onLoad(json)
	lua_fight_hnj_helmet_spine.configList, lua_fight_hnj_helmet_spine.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_hnj_helmet_spine
