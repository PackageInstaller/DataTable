-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_summon_pet_obtain_tier.lua

module("logicconfig.config.t_new_summon_pet_obtain_tier", package.seeall)

local title = {
	stagePlanId = 3,
	tierPlanId = 1,
	tier = 2
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		1,
		2,
		2
	},
	{
		1,
		3,
		3
	},
	{
		1,
		4,
		4
	},
	{
		1,
		5,
		5
	},
	{
		1,
		6,
		1
	},
	{
		1,
		7,
		2
	},
	{
		1,
		8,
		3
	},
	{
		1,
		9,
		4
	},
	{
		1,
		10,
		5
	},
	{
		1,
		11,
		1
	},
	{
		1,
		12,
		2
	},
	{
		1,
		13,
		3
	},
	{
		1,
		14,
		4
	},
	{
		2,
		1,
		6
	},
	{
		2,
		2,
		7
	},
	{
		2,
		3,
		8
	},
	{
		2,
		4,
		9
	},
	{
		2,
		5,
		10
	},
	{
		2,
		6,
		6
	},
	{
		2,
		7,
		7
	},
	{
		2,
		8,
		8
	},
	{
		2,
		9,
		9
	},
	{
		2,
		10,
		10
	},
	{
		2,
		11,
		6
	},
	{
		2,
		12,
		7
	},
	{
		2,
		13,
		8
	},
	{
		2,
		14,
		9
	}
}
local t_new_summon_pet_obtain_tier = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28]
	}
}

t_new_summon_pet_obtain_tier.dataList = dataList

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

return t_new_summon_pet_obtain_tier
