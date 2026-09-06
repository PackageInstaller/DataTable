-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seven_day_task_prize.lua

module("logicconfig.config.t_seven_day_task_prize", package.seeall)

local title = {
	prize = 2,
	needScore = 1
}
local dataList = {
	{
		20,
		"8:1:5000"
	},
	{
		40,
		"8:1:5000"
	},
	{
		60,
		"8:1:5000"
	},
	{
		90,
		"8:1:5000"
	},
	{
		120,
		"8:1:5000"
	}
}
local t_seven_day_task_prize = {
	[20] = dataList[1],
	[40] = dataList[2],
	[60] = dataList[3],
	[90] = dataList[4],
	[120] = dataList[5]
}

t_seven_day_task_prize.dataList = dataList

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

return t_seven_day_task_prize
