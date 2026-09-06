-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_christmas_gather_random_prize.lua

module("logicconfig.config.t_christmas_gather_random_prize", package.seeall)

local title = {
	prize = 2,
	randomPlanId = 1
}
local dataList = {
	{
		1,
		"4:2:10"
	},
	{
		1,
		"4:30001:10"
	},
	{
		1,
		"4:501:10"
	}
}
local t_christmas_gather_random_prize = {
	{
		["4:2:10"] = dataList[1],
		["4:30001:10"] = dataList[2],
		["4:501:10"] = dataList[3]
	}
}

t_christmas_gather_random_prize.dataList = dataList

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

return t_christmas_gather_random_prize
