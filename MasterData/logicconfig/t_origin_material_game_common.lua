-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_material_game_common.lua

module("logicconfig.config.t_origin_material_game_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RULE_KEY",
		"originmaterialgamerule"
	},
	{
		"MAX_BLESSING_ENERGY",
		"300"
	},
	{
		"MAX_BLESSING_COUNT",
		"4"
	},
	{
		"RULEKEY_MAIN",
		"orimatgamestageview_rule"
	},
	{
		"RULEKEY_TALENT",
		"orimatgameskilltreeview_rule"
	},
	{
		"RULEKEY_WEAPON",
		"orimatgameweaponview_rule"
	},
	{
		"IMAGE_RULEKEY_GAME",
		"originmaterialgamerule"
	},
	{
		"SHOP_JUMP",
		"func#470#ExchangeOrimatGame"
	}
}
local t_origin_material_game_common = {
	RULE_KEY = dataList[1],
	MAX_BLESSING_ENERGY = dataList[2],
	MAX_BLESSING_COUNT = dataList[3],
	RULEKEY_MAIN = dataList[4],
	RULEKEY_TALENT = dataList[5],
	RULEKEY_WEAPON = dataList[6],
	IMAGE_RULEKEY_GAME = dataList[7],
	SHOP_JUMP = dataList[8]
}

t_origin_material_game_common.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_origin_material_game_common
