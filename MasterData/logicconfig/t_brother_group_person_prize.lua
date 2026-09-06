-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_brother_group_person_prize.lua

module("logicconfig.config.t_brother_group_person_prize", package.seeall)

local title = {
	progress = 3,
	viewId = 5,
	prizePlanId = 1,
	id = 2,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		0,
		"60:1:60",
		1
	},
	{
		1,
		2,
		200,
		"60:1:60",
		2
	},
	{
		1,
		3,
		400,
		"60:1:60",
		3
	},
	{
		1,
		4,
		600,
		"60:1:60",
		4
	},
	{
		1,
		5,
		800,
		"60:1:60",
		5
	},
	{
		1,
		6,
		1000,
		"60:1:60",
		6
	},
	{
		1,
		7,
		1200,
		"60:1:60",
		7
	},
	{
		1,
		8,
		1400,
		"60:1:60",
		8
	},
	{
		1,
		9,
		1600,
		"60:1:60",
		9
	},
	{
		1,
		10,
		1800,
		"60:1:60",
		10
	},
	{
		1,
		11,
		2000,
		"60:1:60",
		11
	},
	{
		1,
		12,
		2300,
		"60:1:60",
		12
	},
	{
		1,
		13,
		2600,
		"60:1:60",
		13
	},
	{
		1,
		14,
		2900,
		"60:1:60",
		14
	},
	{
		1,
		15,
		3200,
		"60:1:60",
		15
	},
	{
		1,
		16,
		3500,
		"60:1:60",
		16
	},
	{
		1,
		17,
		3800,
		"60:1:60",
		17
	},
	{
		1,
		18,
		4100,
		"60:1:60",
		18
	},
	{
		1,
		19,
		4500,
		"60:1:60",
		19
	},
	{
		1,
		20,
		5000,
		"60:1:60",
		20
	}
}
local t_brother_group_person_prize = {
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
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_brother_group_person_prize.dataList = dataList

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

return t_brother_group_person_prize
