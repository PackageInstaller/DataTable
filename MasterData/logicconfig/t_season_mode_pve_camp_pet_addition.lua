-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_camp_pet_addition.lua

module("logicconfig.config.t_season_mode_pve_camp_pet_addition", package.seeall)

local title = {
	awakenLv = 2,
	additionPlanId = 1,
	addPercent = 3
}
local dataList = {
	{
		1,
		0,
		8
	},
	{
		1,
		1,
		10
	},
	{
		1,
		2,
		12
	},
	{
		1,
		3,
		14
	},
	{
		1,
		4,
		16
	},
	{
		1,
		5,
		18
	},
	{
		1,
		6,
		20
	},
	{
		2,
		0,
		4
	},
	{
		2,
		1,
		5
	},
	{
		2,
		2,
		6
	},
	{
		2,
		3,
		7
	},
	{
		2,
		4,
		8
	},
	{
		2,
		5,
		9
	},
	{
		2,
		6,
		10
	}
}
local t_season_mode_pve_camp_pet_addition = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	{
		[0] = dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_season_mode_pve_camp_pet_addition.dataList = dataList

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

return t_season_mode_pve_camp_pet_addition
