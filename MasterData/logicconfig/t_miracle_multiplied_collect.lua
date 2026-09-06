-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_multiplied_collect.lua

module("logicconfig.config.t_miracle_multiplied_collect", package.seeall)

local title = {
	openTime = 4,
	name = 3,
	endTime = 5,
	collectId = 2,
	poster = 6,
	jumpStr = 7,
	activityId = 1
}
local dataList = {
	{
		380001,
		1,
		"奇迹降临",
		"2024-06-28T05:00:00",
		"2024-07-26T05:00:00",
		"miracledouble/board_bxqj_01",
		"func#1093"
	},
	{
		380001,
		2,
		"奇迹寻宝",
		"2024-06-28T05:00:00",
		"2024-07-26T05:00:00",
		"miracledouble/board_bxqj_03",
		"func#1090"
	},
	{
		380001,
		3,
		"数字炸弹",
		"2024-06-28T05:00:00",
		"2024-07-26T05:00:00",
		"miracledouble/board_bxqj_06",
		"func#287"
	},
	{
		380001,
		4,
		"奇迹消消乐",
		"2024-07-05T05:00:00",
		"2024-07-26T05:00:00",
		"miracledouble/board_bxqj_04",
		"func#1085"
	},
	{
		380001,
		5,
		"奇迹挑战赛",
		"2024-07-05T05:00:00",
		"2024-07-26T05:00:00",
		"miracledouble/board_bxqj_05",
		"func#996"
	},
	{
		380001,
		6,
		"合成蛋糕",
		"2024-07-12T05:00:00",
		"2024-07-26T05:00:00",
		"miracledouble/board_bxqj_02",
		"func#975"
	}
}
local t_miracle_multiplied_collect = {
	[380001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_miracle_multiplied_collect.dataList = dataList

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

return t_miracle_multiplied_collect
