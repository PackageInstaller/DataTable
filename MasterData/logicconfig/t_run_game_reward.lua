-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run_game_reward.lua

module("logicconfig.config.t_run_game_reward", package.seeall)

local title = {
	prizeId = 2,
	gameTime = 3,
	reward = 4,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		40,
		"4:30:5#8:1:20000"
	},
	{
		1,
		2,
		50,
		"4:30:3#8:1:15000"
	},
	{
		1,
		3,
		60,
		"4:30:2#8:1:10000"
	},
	{
		2,
		1,
		40,
		"10:228002:50#8:1:20000"
	},
	{
		2,
		2,
		50,
		"10:228002:30#8:1:15000"
	},
	{
		2,
		3,
		60,
		"10:228002:20#8:1:10000"
	},
	{
		3,
		1,
		40,
		"10:228003:500"
	},
	{
		3,
		2,
		50,
		"10:228003:300"
	},
	{
		3,
		3,
		60,
		"10:228003:250"
	},
	{
		4,
		1,
		40,
		"10:228004:500"
	},
	{
		4,
		2,
		50,
		"10:228004:300"
	},
	{
		4,
		3,
		60,
		"10:228004:250"
	}
}
local t_run_game_reward = {
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

t_run_game_reward.dataList = dataList

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

return t_run_game_reward
