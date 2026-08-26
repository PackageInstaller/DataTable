-- chunkname: @modules/configs/excel2json/lua_assassin_hero_trial.lua

module("modules.configs.excel2json.lua_assassin_hero_trial", package.seeall)

local lua_assassin_hero_trial = {}
local fields = {
	heroImg = 5,
	heroIcon = 4,
	secondCareer = 3,
	entityIcon = 6,
	assassinHeroId = 1,
	model = 8,
	career = 2,
	unlock = 7
}
local primaryKey = {
	"assassinHeroId"
}
local mlStringKey = {}

function lua_assassin_hero_trial.onLoad(json)
	lua_assassin_hero_trial.configList, lua_assassin_hero_trial.configDict = JsonToLuaParser.parse(json, fields, primaryKey, mlStringKey)
end

return lua_assassin_hero_trial
