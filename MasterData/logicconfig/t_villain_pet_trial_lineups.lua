-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_villain_pet_trial_lineups.lua

module("logicconfig.config.t_villain_pet_trial_lineups", package.seeall)

local title = {
	teamId = 2,
	lineupsPlanId = 1,
	randomPet = 3,
	formStrategy = 4
}
local dataList = {
	{
		1,
		1,
		{
			1101,
			1102,
			1103
		},
		6
	},
	{
		1,
		2,
		{
			1301,
			1302,
			1303
		},
		6
	},
	{
		1,
		3,
		{
			1401,
			1402,
			1403
		},
		6
	},
	{
		1,
		4,
		{
			1501,
			1502,
			1503
		},
		6
	},
	{
		1,
		5,
		{
			1601,
			1602,
			1603,
			1604
		},
		6
	},
	{
		1,
		6,
		{
			1701,
			1702
		},
		6
	}
}
local t_villain_pet_trial_lineups = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_villain_pet_trial_lineups.dataList = dataList

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

return t_villain_pet_trial_lineups
