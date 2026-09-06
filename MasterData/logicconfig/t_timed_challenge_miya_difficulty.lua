-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_miya_difficulty.lua

module("logicconfig.config.t_timed_challenge_miya_difficulty", package.seeall)

local title = {
	costMaterial = 3,
	difficultyName = 2,
	recommendZdl = 5,
	recommendDynamicParam = 6,
	difficulty = 1,
	passPrize = 4
}
local dataList = {
	{
		1,
		"简单",
		"8:1:1000",
		"4:86:20",
		20000,
		7000
	},
	{
		2,
		"适中",
		"8:1:2000",
		"4:86:30",
		25000,
		9000
	},
	{
		3,
		"困难",
		"8:1:3000",
		"4:86:40",
		30000,
		11000
	},
	{
		4,
		"深渊",
		"8:1:4000",
		"4:86:50",
		35000,
		13000
	}
}
local t_timed_challenge_miya_difficulty = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_timed_challenge_miya_difficulty.dataList = dataList

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

return t_timed_challenge_miya_difficulty
