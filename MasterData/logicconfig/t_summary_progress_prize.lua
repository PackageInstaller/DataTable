-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summary_progress_prize.lua

module("logicconfig.config.t_summary_progress_prize", package.seeall)

local title = {
	progress = 3,
	storyId = 5,
	prizePlanId = 1,
	id = 2,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		50000,
		"9:95001:1",
		4160001
	},
	{
		1,
		2,
		100000,
		"9:95001:1",
		4160001
	},
	{
		1,
		3,
		150000,
		"9:95001:1",
		4160001
	},
	{
		1,
		4,
		200000,
		"9:95001:2",
		4160001
	},
	{
		1,
		5,
		250000,
		"9:95001:2",
		4160001
	},
	{
		1,
		6,
		300000,
		"9:95001:3",
		4160001
	},
	{
		2,
		1,
		50000,
		"9:95001:1",
		4160002
	},
	{
		2,
		2,
		100000,
		"9:95001:1",
		4160002
	},
	{
		2,
		3,
		150000,
		"9:95001:1",
		4160002
	},
	{
		2,
		4,
		200000,
		"9:95001:2",
		4160002
	},
	{
		2,
		5,
		250000,
		"9:95001:2",
		4160002
	},
	{
		2,
		6,
		300000,
		"9:95001:3",
		4160002
	},
	{
		3,
		1,
		50000,
		"9:95001:1",
		4160003
	},
	{
		3,
		2,
		100000,
		"9:95001:1",
		4160003
	},
	{
		3,
		3,
		150000,
		"9:95001:1",
		4160003
	},
	{
		3,
		4,
		200000,
		"9:95001:2",
		4160003
	},
	{
		3,
		5,
		250000,
		"9:95001:2",
		4160003
	},
	{
		3,
		6,
		300000,
		"9:95001:3",
		4160003
	}
}
local t_summary_progress_prize = {
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
	}
}

t_summary_progress_prize.dataList = dataList

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

return t_summary_progress_prize
