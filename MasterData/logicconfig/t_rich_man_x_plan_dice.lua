-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_rich_man_x_plan_dice.lua

module("logicconfig.config.t_rich_man_x_plan_dice", package.seeall)

local title = {
	cost = 3,
	randList = 4,
	diceId = 2,
	activityId = 1,
	times = 5
}
local dataList = {
	{
		373001,
		1,
		"10:373002:1",
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		1
	},
	{
		373001,
		2,
		"10:373003:1",
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		1
	},
	{
		373001,
		3,
		"10:373004:1",
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		3
	}
}
local t_rich_man_x_plan_dice = {
	[373001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_rich_man_x_plan_dice.dataList = dataList

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

return t_rich_man_x_plan_dice
