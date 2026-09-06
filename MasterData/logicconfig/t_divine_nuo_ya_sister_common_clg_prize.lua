-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_sister_common_clg_prize.lua

module("logicconfig.config.t_divine_nuo_ya_sister_common_clg_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	needScore = 3
}
local dataList = {
	{
		407001,
		1,
		20,
		"4:90004:1"
	},
	{
		407001,
		2,
		50,
		"4:251:5"
	},
	{
		407001,
		3,
		100,
		"8:1:1000000"
	},
	{
		407001,
		4,
		200,
		"4:251:5"
	},
	{
		407001,
		5,
		300,
		"4:251:10"
	}
}
local t_divine_nuo_ya_sister_common_clg_prize = {
	[407001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_nuo_ya_sister_common_clg_prize.dataList = dataList

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

return t_divine_nuo_ya_sister_common_clg_prize
