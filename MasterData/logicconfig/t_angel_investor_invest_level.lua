-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_angel_investor_invest_level.lua

module("logicconfig.config.t_angel_investor_invest_level", package.seeall)

local title = {
	imgName = 5,
	consume = 3,
	hangMin = 4,
	typePrizeCountLimit = 6,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		588001,
		1,
		360,
		60,
		"board_tianshitouziren_02",
		{
			2,
			3,
			3
		}
	},
	{
		588001,
		2,
		360,
		50,
		"board_tianshitouziren_01",
		{
			3,
			4,
			4
		}
	},
	{
		588001,
		3,
		0,
		40,
		"board_tianshitouziren_03",
		{
			4,
			5,
			5
		}
	}
}
local t_angel_investor_invest_level = {
	[588001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_angel_investor_invest_level.dataList = dataList

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

return t_angel_investor_invest_level
