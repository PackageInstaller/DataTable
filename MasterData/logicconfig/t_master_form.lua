-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_master_form.lua

module("logicconfig.config.t_master_form", package.seeall)

local title = {
	maxFormCount = 5,
	openTime = 2,
	hotPetPlanId = 7,
	endTime = 3,
	winRateStatisticalPeriod = 8,
	periodId = 1,
	prizeCount = 6,
	sysFmtPlanIds = 4
}
local dataList = {
	{
		1,
		"2023-06-02T05:00:00",
		"2023-06-30T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		2,
		"2023-06-30T05:00:00",
		"2023-07-28T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		3,
		"2023-07-28T05:00:00",
		"2023-08-25T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		4,
		"2023-08-25T05:00:00",
		"2023-09-28T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		5,
		"2023-09-28T05:00:00",
		"2023-10-27T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		6,
		"2023-10-27T05:00:00",
		"2023-11-24T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		7,
		"2023-11-24T05:00:00",
		"2023-12-22T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		8,
		"2023-12-22T05:00:00",
		"2024-01-19T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		9,
		"2024-01-19T05:00:00",
		"2024-02-08T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		10,
		"2024-02-08T05:00:00",
		"2024-03-01T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		11,
		"2024-03-01T05:00:00",
		"2024-04-03T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		12,
		"2024-04-03T05:00:00",
		"2024-04-30T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		13,
		"2024-04-30T05:00:00",
		"2024-05-31T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		14,
		"2024-05-31T05:00:00",
		"2024-06-28T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		15,
		"2024-06-28T05:00:00",
		"2024-07-26T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		16,
		"2024-07-26T05:00:00",
		"2024-08-23T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		17,
		"2024-08-23T05:00:00",
		"2024-09-27T05:00:00",
		{
			1,
			2,
			3
		},
		3,
		3,
		0,
		""
	},
	{
		18,
		"2024-09-27T05:00:00",
		"2038-12-31T05:00:00",
		{
			1,
			2,
			3,
			5
		},
		3,
		3,
		1,
		"2026-06-27 05:00:00#2026-7-22 05:00:00"
	}
}
local t_master_form = {
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
	dataList[18]
}

t_master_form.dataList = dataList

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

return t_master_form
