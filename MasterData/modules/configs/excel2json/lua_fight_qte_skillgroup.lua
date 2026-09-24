-- chunkname: @modules/configs/excel2json/lua_fight_qte_skillgroup.lua

module("modules.configs.excel2json.lua_fight_qte_skillgroup", package.seeall)

local lua_fight_qte_skillgroup = {}
local fields = {
	qteGoupId = 1,
	passiveId2 = 4,
	passiveId1 = 3,
	endId = 5,
	activeId = 2
}
local primaryKey = {
	"qteGoupId"
}
local mlStringKey = {}

function lua_fight_qte_skillgroup.onLoad(json)
	lua_fight_qte_skillgroup.configList, lua_fight_qte_skillgroup.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_fight_qte_skillgroup
