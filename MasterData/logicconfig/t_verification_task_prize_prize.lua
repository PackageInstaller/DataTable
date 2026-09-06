-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_verification_task_prize_prize.lua

module("logicconfig.config.t_verification_task_prize_prize", package.seeall)

local title = {
	prizeId = 2,
	needProgress = 3,
	prize = 4,
	prizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		50,
		"8:25:400"
	},
	{
		1,
		2,
		100,
		"8:25:400"
	},
	{
		1,
		3,
		150,
		"2:49:1"
	}
}
local t_verification_task_prize_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_verification_task_prize_prize.dataList = dataList

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

return t_verification_task_prize_prize
