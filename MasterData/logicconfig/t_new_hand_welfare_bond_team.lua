-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_hand_welfare_bond_team.lua

module("logicconfig.config.t_new_hand_welfare_bond_team", package.seeall)

local title = {
	bondRaceIds = 2,
	bondTeamId = 1,
	name = 4,
	excludePublicStrengthens = 3
}
local dataList = {
	{
		1,
		{
			11009,
			12017,
			13007,
			14015,
			15016,
			11010,
			11041,
			11042,
			12046,
			13031,
			14044,
			15050
		},
		false,
		"神/源\n梦队"
	},
	{
		2,
		{
			15025,
			12022,
			13019,
			14025,
			11024,
			16025
		},
		false,
		"奇迹\n五王"
	},
	{
		3,
		{
			11021,
			14018,
			15018,
			12018,
			13009,
			16009
		},
		false,
		"神曜\n五王"
	},
	{
		4,
		{
			13009,
			13010,
			13014,
			13015,
			13016,
			13005
		},
		false,
		"开荒\n草队"
	},
	{
		5,
		{
			11029,
			12031,
			12032,
			13024,
			14035,
			15035
		},
		false,
		"神曜\n圣骑"
	}
}
local t_new_hand_welfare_bond_team = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_new_hand_welfare_bond_team.dataList = dataList

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

return t_new_hand_welfare_bond_team
