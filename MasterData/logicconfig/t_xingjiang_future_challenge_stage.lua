-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xingjiang_future_challenge_stage.lua

module("logicconfig.config.t_xingjiang_future_challenge_stage", package.seeall)

local title = {
	stageId = 2,
	difficulty = 5,
	battlePowers = 7,
	chapterDifficulty = 6,
	creepsMasterId = 3,
	prize = 4,
	challengePlanId = 1
}
local dataList = {
	{
		1,
		1,
		100001,
		"4:136:1",
		1,
		"简单",
		283483
	},
	{
		1,
		2,
		100002,
		"4:136:1",
		2,
		"普通",
		368528
	},
	{
		1,
		3,
		100003,
		"4:136:2",
		2,
		"普通",
		453573
	},
	{
		1,
		4,
		100004,
		"4:136:2",
		3,
		"困难",
		510270
	},
	{
		1,
		5,
		100005,
		"4:136:2",
		3,
		"困难",
		566966
	},
	{
		1,
		6,
		100006,
		"4:136:6",
		4,
		"噩梦",
		566966
	},
	{
		2,
		1,
		200001,
		"4:510402:6",
		1,
		"简单",
		0
	},
	{
		2,
		2,
		200002,
		"4:510402:6",
		2,
		"普通",
		0
	},
	{
		2,
		3,
		200003,
		"4:510402:6",
		2,
		"普通",
		0
	},
	{
		2,
		4,
		200004,
		"4:510402:6",
		3,
		"困难",
		0
	},
	{
		2,
		5,
		200005,
		"4:510402:6",
		3,
		"困难",
		0
	}
}
local t_xingjiang_future_challenge_stage = {
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
		dataList[11]
	}
}

t_xingjiang_future_challenge_stage.dataList = dataList

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

return t_xingjiang_future_challenge_stage
