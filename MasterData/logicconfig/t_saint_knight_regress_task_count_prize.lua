-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_regress_task_count_prize.lua

module("logicconfig.config.t_saint_knight_regress_task_count_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	taskCount = 3
}
local dataList = {
	{
		483001,
		1,
		1,
		"10:483001:10"
	},
	{
		483001,
		2,
		3,
		"10:483001:10"
	},
	{
		483001,
		3,
		5,
		"10:483001:10"
	},
	{
		483001,
		4,
		7,
		"10:483001:10"
	},
	{
		483001,
		5,
		9,
		"10:483001:10"
	}
}
local t_saint_knight_regress_task_count_prize = {
	[483001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_saint_knight_regress_task_count_prize.dataList = dataList

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

return t_saint_knight_regress_task_count_prize
