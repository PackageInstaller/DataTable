-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_move_event.lua

module("logicconfig.config.t_explore_under_move_event", package.seeall)

local title = {
	eventDesc = 4,
	iconId = 5,
	movement = 3,
	planId = 1,
	subId = 2
}
local dataList = {
	{
		1,
		1,
		-3,
		"一阵猛烈的龙卷风从旁边袭来，你措手不及，后退了3步",
		8
	},
	{
		1,
		2,
		-2,
		"一阵猛烈的龙卷风从旁边袭来，你措手不及，后退了2步",
		9
	},
	{
		1,
		5,
		2,
		"你感受到一阵轻盈的风，卷着你的身体漂浮起来，回过神来已经前进了2步",
		12
	},
	{
		1,
		6,
		3,
		"你感受到一阵轻盈的风，卷着你的身体漂浮起来，回过神来已经前进了3步",
		13
	},
	{
		2,
		1,
		1,
		"你感受到一阵轻盈的风，卷着你的身体漂浮起来，回过神来已经前进了1步",
		11
	},
	{
		2,
		2,
		-1,
		"一阵猛烈的龙卷风从旁边袭来，你措手不及，后退了1步",
		10
	},
	{
		2,
		5,
		2,
		"你感受到一阵轻盈的风，卷着你的身体漂浮起来，回过神来已经前进了2步",
		12
	},
	{
		2,
		6,
		-2,
		"一阵猛烈的龙卷风从旁边袭来，你措手不及，后退了2步",
		9
	},
	{
		3,
		1,
		-1,
		"一阵猛烈的龙卷风从旁边袭来，你措手不及，后退了1步",
		10
	},
	{
		3,
		2,
		-2,
		"一阵猛烈的龙卷风从旁边袭来，你措手不及，后退了2步",
		9
	},
	{
		3,
		3,
		3,
		"你感受到一阵轻盈的风，卷着你的身体漂浮起来，回过神来已经前进了3步",
		13
	},
	{
		3,
		4,
		4,
		"你感受到一阵轻盈的风，卷着你的身体漂浮起来，回过神来已经前进了4步",
		14
	}
}
local t_explore_under_move_event = {
	{
		dataList[1],
		dataList[2],
		[5] = dataList[3],
		[6] = dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		[5] = dataList[7],
		[6] = dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_explore_under_move_event.dataList = dataList

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

return t_explore_under_move_event
