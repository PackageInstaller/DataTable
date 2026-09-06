-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_buy_times_cost.lua

module("logicconfig.config.t_dragon_trial_buy_times_cost", package.seeall)

local title = {
	cost = 3,
	planId = 1,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:199:20"
	},
	{
		1,
		2,
		"105:199:20"
	},
	{
		1,
		3,
		"105:199:25"
	},
	{
		1,
		4,
		"105:199:25"
	},
	{
		2,
		1,
		"105:199:20"
	},
	{
		2,
		2,
		"105:199:20"
	},
	{
		2,
		3,
		"105:199:25"
	},
	{
		2,
		4,
		"105:199:25"
	}
}
local t_dragon_trial_buy_times_cost = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_dragon_trial_buy_times_cost.dataList = dataList

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

return t_dragon_trial_buy_times_cost
