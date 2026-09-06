-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_cake_world_progress_reward.lua

module("logicconfig.config.t_birthday_cake_world_progress_reward", package.seeall)

local title = {
	prizeId = 2,
	cakeImg = 5,
	prizePlanId = 1,
	prize = 4,
	needScore = 3
}
local dataList = {
	{
		1,
		1,
		500000,
		"104:2:50",
		"board_zndg_24"
	},
	{
		1,
		2,
		1500000,
		"104:2:50",
		"board_zndg_24"
	},
	{
		1,
		3,
		3000000,
		"104:2:50",
		"board_zndg_25"
	},
	{
		1,
		4,
		5000000,
		"104:2:50",
		"board_zndg_25"
	},
	{
		1,
		5,
		7000000,
		"104:2:50",
		"board_zndg_26"
	},
	{
		1,
		6,
		10000000,
		"104:2:50",
		"board_zndg_26"
	},
	{
		2,
		1,
		500000,
		"104:2:50",
		"board_zndg_24"
	},
	{
		2,
		2,
		1500000,
		"104:2:50",
		"board_zndg_24"
	},
	{
		2,
		3,
		3000000,
		"104:2:50",
		"board_zndg_25"
	},
	{
		2,
		4,
		5000000,
		"104:2:50",
		"board_zndg_25"
	},
	{
		2,
		5,
		7000000,
		"104:2:50",
		"board_zndg_26"
	},
	{
		2,
		6,
		10000000,
		"104:2:50",
		"board_zndg_26"
	}
}
local t_birthday_cake_world_progress_reward = {
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
	}
}

t_birthday_cake_world_progress_reward.dataList = dataList

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

return t_birthday_cake_world_progress_reward
