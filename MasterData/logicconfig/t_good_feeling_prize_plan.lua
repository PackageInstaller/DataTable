-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_good_feeling_prize_plan.lua

module("logicconfig.config.t_good_feeling_prize_plan", package.seeall)

local title = {
	planId = 1,
	prize = 3,
	lv = 2
}
local dataList = {
	{
		1,
		10,
		"104:2:10#8:1:10000#4:110002:1"
	},
	{
		1,
		20,
		"104:2:30#8:1:30000#4:110002:1"
	},
	{
		1,
		30,
		"104:2:50#8:1:50000#4:110002:1"
	}
}
local t_good_feeling_prize_plan = {
	{
		[10] = dataList[1],
		[20] = dataList[2],
		[30] = dataList[3]
	}
}

t_good_feeling_prize_plan.dataList = dataList

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

return t_good_feeling_prize_plan
