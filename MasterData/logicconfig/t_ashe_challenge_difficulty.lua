-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashe_challenge_difficulty.lua

module("logicconfig.config.t_ashe_challenge_difficulty", package.seeall)

local title = {
	challengePlanId = 4,
	desc = 3,
	recPower = 6,
	id = 2,
	prize = 5,
	difficultyPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"简单",
		1,
		"4:169:150",
		300000
	},
	{
		1,
		2,
		"中等",
		2,
		"4:169:250",
		800000
	},
	{
		1,
		3,
		"困难",
		3,
		"4:169:400",
		1200000
	},
	{
		2,
		1,
		"简单",
		4,
		"4:185:150",
		300000
	},
	{
		2,
		2,
		"中等",
		5,
		"4:185:250",
		800000
	},
	{
		2,
		3,
		"困难",
		6,
		"4:185:400",
		1200000
	},
	{
		3,
		1,
		"简单",
		7,
		"4:216:200",
		300000
	},
	{
		3,
		2,
		"中等",
		8,
		"4:216:300",
		800000
	},
	{
		3,
		3,
		"困难",
		9,
		"4:216:400",
		1200000
	},
	{
		4,
		1,
		"简单",
		10,
		"4:256:200",
		300000
	},
	{
		4,
		2,
		"中等",
		11,
		"4:256:300",
		800000
	},
	{
		4,
		3,
		"困难",
		12,
		"4:256:400",
		1200000
	}
}
local t_ashe_challenge_difficulty = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_ashe_challenge_difficulty.dataList = dataList

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

return t_ashe_challenge_difficulty
