-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_light.lua

module("logic.config.t_light", package.seeall)

local title = {
	resPath = 2,
	code = 1
}
local dataList = {
	{
		1,
		"directional_light_character_flag"
	},
	{
		2,
		"directional_light_character_fight"
	},
	{
		3,
		"team_view_light"
	},
	{
		4,
		"spine_shadow_light"
	},
	{
		5,
		"spine_shadow_character_system_light"
	},
	{
		6,
		"directional_light_character_paotuan"
	},
	{
		7,
		"directional_light_equip_model"
	},
	{
		8,
		"handbook_monster_light"
	},
	{
		9,
		"directional_light_character_main"
	},
	{
		10,
		"directional_light_character_fight_jq"
	},
	{
		11,
		"directional_light_character_lottery"
	},
	{
		12,
		"directional_light_clock"
	},
	{
		13,
		"directional_light_character_tupo"
	},
	{
		14,
		"retrieve_hero_ui3d_light"
	},
	{
		15,
		"cardpack_directional_light"
	}
}
local t_light = {}

t_light.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_light[v[1]] = v

	setmetatable(v, mt)
end

return t_light
