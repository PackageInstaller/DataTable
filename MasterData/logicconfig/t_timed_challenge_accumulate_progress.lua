-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_accumulate_progress.lua

module("logicconfig.config.t_timed_challenge_accumulate_progress", package.seeall)

local title = {
	challengeId = 1,
	prize = 3,
	progressPercent = 2
}
local dataList = {
	{
		2,
		500,
		"4:5102:10#4:5000:200"
	},
	{
		2,
		1000,
		"4:41002:1#4:502:5"
	},
	{
		2,
		2000,
		"4:5102:20#4:5000:400"
	},
	{
		2,
		3500,
		"4:41002:1#4:502:10"
	},
	{
		2,
		5000,
		"4:5202:5#4:5000:800"
	},
	{
		2,
		6500,
		"4:41003:1#4:502:20"
	},
	{
		2,
		8000,
		"4:5202:10#4:5000:1500"
	},
	{
		2,
		10000,
		"100:10167:1:1#62:15:1"
	}
}
local t_timed_challenge_accumulate_progress = {
	[2] = {
		[500] = dataList[1],
		[1000] = dataList[2],
		[2000] = dataList[3],
		[3500] = dataList[4],
		[5000] = dataList[5],
		[6500] = dataList[6],
		[8000] = dataList[7],
		[10000] = dataList[8]
	}
}

t_timed_challenge_accumulate_progress.dataList = dataList

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

return t_timed_challenge_accumulate_progress
