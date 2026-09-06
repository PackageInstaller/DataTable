-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_activity_active_prize.lua

module("logicconfig.config.t_ji_activity_active_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	titleStr = 5,
	progress = 3,
	descStr = 6,
	jumpTo = 7,
	activityId = 1
}
local dataList = {
	{
		144001,
		1,
		90,
		"4:138:1",
		"活跃度I",
		"每日活跃度达到90",
		"func#5"
	},
	{
		144001,
		2,
		120,
		"4:138:2",
		"活跃度Ⅱ",
		"每日活跃度达到120",
		"func#5"
	},
	{
		144002,
		1,
		90,
		"4:138:1",
		"活跃度I",
		"每日活跃度达到90",
		"func#5"
	},
	{
		144002,
		2,
		120,
		"4:138:2",
		"活跃度Ⅱ",
		"每日活跃度达到120",
		"func#5"
	},
	{
		144003,
		1,
		90,
		"4:138:1",
		"活跃度I",
		"每日活跃度达到90",
		"func#5"
	},
	{
		144003,
		2,
		120,
		"4:138:2",
		"活跃度Ⅱ",
		"每日活跃度达到120",
		"func#5"
	},
	{
		144004,
		1,
		90,
		"4:138:1",
		"活跃度I",
		"每日活跃度达到90",
		"func#5"
	},
	{
		144004,
		2,
		120,
		"4:138:2",
		"活跃度Ⅱ",
		"每日活跃度达到120",
		"func#5"
	}
}
local t_ji_activity_active_prize = {
	[144001] = {
		dataList[1],
		dataList[2]
	},
	[144002] = {
		dataList[3],
		dataList[4]
	},
	[144003] = {
		dataList[5],
		dataList[6]
	},
	[144004] = {
		dataList[7],
		dataList[8]
	}
}

t_ji_activity_active_prize.dataList = dataList

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

return t_ji_activity_active_prize
