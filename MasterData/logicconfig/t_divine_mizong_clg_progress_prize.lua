-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mizong_clg_progress_prize.lua

module("logicconfig.config.t_divine_mizong_clg_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	upgradeBuffItemCount = 5,
	starProgress = 3,
	activityId = 1
}
local dataList = {
	{
		477001,
		1,
		3,
		"4:283:5",
		0
	},
	{
		477001,
		2,
		6,
		"4:283:5",
		0
	},
	{
		477001,
		3,
		9,
		"4:283:5",
		0
	},
	{
		477001,
		4,
		12,
		"4:283:5",
		0
	},
	{
		477001,
		5,
		15,
		"4:283:5",
		0
	},
	{
		477001,
		6,
		18,
		"4:283:5",
		0
	},
	{
		477001,
		7,
		21,
		"4:283:8",
		0
	},
	{
		477001,
		8,
		24,
		"4:283:8",
		0
	},
	{
		477001,
		9,
		27,
		"4:283:12",
		0
	},
	{
		477001,
		10,
		30,
		"4:283:12",
		0
	},
	{
		477001,
		11,
		33,
		"4:283:15",
		0
	},
	{
		477001,
		12,
		36,
		"4:283:15",
		0
	}
}
local t_divine_mizong_clg_progress_prize = {
	[477001] = {
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
		dataList[12]
	}
}

t_divine_mizong_clg_progress_prize.dataList = dataList

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

return t_divine_mizong_clg_progress_prize
