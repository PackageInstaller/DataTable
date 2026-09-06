-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_energy_buy_times.lua

module("logicconfig.config.t_energy_buy_times", package.seeall)

local title = {
	consume = 3,
	buyPlanId = 1,
	gainNum = 4,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:173:50",
		120
	},
	{
		1,
		2,
		"105:173:50",
		120
	},
	{
		1,
		3,
		"105:173:50",
		120
	},
	{
		1,
		4,
		"105:173:50",
		120
	},
	{
		1,
		5,
		"105:173:50",
		120
	},
	{
		2,
		1,
		"105:173:50",
		600
	},
	{
		2,
		2,
		"105:173:50",
		600
	},
	{
		2,
		3,
		"105:173:50",
		600
	},
	{
		2,
		4,
		"105:173:50",
		600
	},
	{
		2,
		5,
		"105:173:50",
		600
	},
	{
		3,
		1,
		"105:173:50",
		40
	},
	{
		3,
		2,
		"105:173:50",
		40
	},
	{
		3,
		3,
		"105:173:50",
		40
	},
	{
		3,
		4,
		"105:173:50",
		40
	},
	{
		3,
		5,
		"105:173:50",
		40
	},
	{
		4,
		1,
		"105:173:100",
		120
	},
	{
		4,
		2,
		"105:173:100",
		120
	},
	{
		4,
		3,
		"105:173:100",
		120
	},
	{
		4,
		4,
		"105:173:100",
		120
	},
	{
		4,
		5,
		"105:173:100",
		120
	},
	{
		5,
		1,
		"105:173:100",
		120
	},
	{
		5,
		2,
		"105:173:100",
		120
	},
	{
		5,
		3,
		"105:173:100",
		120
	},
	{
		5,
		4,
		"105:173:100",
		120
	},
	{
		5,
		5,
		"105:173:100",
		120
	}
}
local t_energy_buy_times = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	{
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	}
}

t_energy_buy_times.dataList = dataList

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

return t_energy_buy_times
