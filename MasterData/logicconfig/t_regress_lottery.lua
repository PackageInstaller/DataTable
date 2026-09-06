-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regress_lottery.lua

module("logicconfig.config.t_regress_lottery", package.seeall)

local title = {
	itemDesc = 6,
	itemName = 4,
	jumpTo = 3,
	id = 2,
	icon = 5,
	planId = 1
}
local dataList = {
	{
		4,
		1,
		"func#43#67",
		"神唤卡池",
		"icon_shenhuanjuan",
		"召唤五王"
	},
	{
		4,
		2,
		"func#43#68",
		"神钻卡池",
		"icon_shenzuanbenti",
		"召唤极、秩序圣龙"
	},
	{
		5,
		1,
		"func#43#67",
		"神唤卡池",
		"icon_shenhuanjuan",
		"召唤五王"
	},
	{
		5,
		2,
		"func#43#99",
		"神钻卡池",
		"icon_shenzuanbenti",
		"召唤极、秩序圣龙、修诺、以世"
	}
}
local t_regress_lottery = {
	[4] = {
		dataList[1],
		dataList[2]
	},
	[5] = {
		dataList[3],
		dataList[4]
	}
}

t_regress_lottery.dataList = dataList

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

return t_regress_lottery
