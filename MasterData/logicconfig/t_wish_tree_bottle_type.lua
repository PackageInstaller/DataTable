-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wish_tree_bottle_type.lua

module("logicconfig.config.t_wish_tree_bottle_type", package.seeall)

local title = {
	content = 3,
	typeId = 2,
	activityId = 1,
	pic = 4
}
local dataList = {
	{
		328001,
		1,
		"流星瓶",
		"board_pingzi_01"
	},
	{
		328001,
		2,
		"锦鲤瓶",
		"board_pingzi_02"
	},
	{
		328001,
		3,
		"希望瓶",
		"board_pingzi_03"
	},
	{
		328002,
		1,
		"流星瓶",
		"board_pingzi_06"
	},
	{
		328002,
		2,
		"锦鲤瓶",
		"board_pingzi_07"
	},
	{
		328002,
		3,
		"希望瓶",
		"board_pingzi_05"
	},
	{
		328003,
		1,
		"圣翼魔方",
		"board_mofang_01"
	},
	{
		328003,
		2,
		"白鸽魔方",
		"board_mofang_02"
	},
	{
		328003,
		3,
		"星芒魔方",
		"board_mofang_03"
	}
}
local t_wish_tree_bottle_type = {
	[328001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[328002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[328003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_wish_tree_bottle_type.dataList = dataList

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

return t_wish_tree_bottle_type
