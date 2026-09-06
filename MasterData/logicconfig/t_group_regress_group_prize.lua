-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_regress_group_prize.lua

module("logicconfig.config.t_group_regress_group_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	activityId = 1,
	needProgress = 4
}
local dataList = {
	{
		598001,
		1,
		"10:598001:100",
		50
	},
	{
		598001,
		2,
		"10:598001:100",
		100
	},
	{
		598001,
		3,
		"10:598001:100",
		150
	},
	{
		598001,
		4,
		"10:598001:100",
		200
	},
	{
		598001,
		5,
		"10:598001:100",
		250
	},
	{
		598001,
		6,
		"10:598001:100",
		300
	},
	{
		598001,
		7,
		"10:598001:100",
		350
	},
	{
		598001,
		8,
		"10:598001:100",
		400
	}
}
local t_group_regress_group_prize = {
	[598001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_group_regress_group_prize.dataList = dataList

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

return t_group_regress_group_prize
