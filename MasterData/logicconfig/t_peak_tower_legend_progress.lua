-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tower_legend_progress.lua

module("logicconfig.config.t_peak_tower_legend_progress", package.seeall)

local title = {
	score = 4,
	progressId = 3,
	prize = 5,
	weekId = 2,
	activityId = 1
}
local dataList = {
	{
		567001,
		1,
		1,
		1000,
		"8:1:250000"
	},
	{
		567001,
		1,
		2,
		1500,
		"4:11002:5000"
	},
	{
		567001,
		1,
		3,
		2000,
		"4:510022:2"
	},
	{
		567001,
		1,
		4,
		2500,
		"4:400002:25"
	},
	{
		567001,
		1,
		5,
		3000,
		"4:400002:25"
	},
	{
		567001,
		1,
		6,
		4000,
		"4:400004:6"
	},
	{
		567001,
		2,
		1,
		1000,
		"8:1:250000"
	},
	{
		567001,
		2,
		2,
		1500,
		"4:11002:5000"
	},
	{
		567001,
		2,
		3,
		2000,
		"4:510022:2"
	},
	{
		567001,
		2,
		4,
		2500,
		"4:400002:25"
	},
	{
		567001,
		2,
		5,
		3000,
		"4:400002:25"
	},
	{
		567001,
		2,
		6,
		4000,
		"4:400004:6"
	},
	{
		567001,
		3,
		1,
		1000,
		"8:1:250000"
	},
	{
		567001,
		3,
		2,
		1500,
		"4:11002:5000"
	},
	{
		567001,
		3,
		3,
		2000,
		"4:510022:2"
	},
	{
		567001,
		3,
		4,
		2500,
		"4:400002:25"
	},
	{
		567001,
		3,
		5,
		3000,
		"4:400002:25"
	},
	{
		567001,
		3,
		6,
		4000,
		"4:400004:6"
	},
	{
		567001,
		4,
		1,
		1000,
		"8:1:250000"
	},
	{
		567001,
		4,
		2,
		1500,
		"4:11002:5000"
	},
	{
		567001,
		4,
		3,
		2000,
		"4:510022:2"
	},
	{
		567001,
		4,
		4,
		2500,
		"4:400002:25"
	},
	{
		567001,
		4,
		5,
		3000,
		"4:400002:25"
	},
	{
		567001,
		4,
		6,
		4000,
		"4:400004:6"
	}
}
local t_peak_tower_legend_progress = {
	[567001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		},
		{
			dataList[19],
			dataList[20],
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24]
		}
	}
}

t_peak_tower_legend_progress.dataList = dataList

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

return t_peak_tower_legend_progress
