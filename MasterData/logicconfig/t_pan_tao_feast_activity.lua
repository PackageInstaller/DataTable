-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pan_tao_feast_activity.lua

module("logicconfig.config.t_pan_tao_feast_activity", package.seeall)

local title = {
	gotoStrs = 10,
	fridgeCapacity = 4,
	colCount = 3,
	initGridElements = 8,
	storyId = 11,
	scoreId = 12,
	energyId = 6,
	modelPlanId = 13,
	rowCount = 2,
	redPointId = 7,
	dailyGiftCount = 5,
	activityId = 1,
	ruleKey = 9
}
local dataList = {
	{
		622001,
		5,
		8,
		10,
		3,
		22,
		792,
		{
			{
				40001,
				24,
				16,
				16,
				32,
				27,
				16,
				30001
			},
			{
				15,
				1,
				1,
				2,
				2,
				8,
				8,
				21001
			},
			{
				16,
				9,
				0,
				0,
				0,
				0,
				10,
				22001
			},
			{
				13,
				5,
				4,
				3,
				3,
				4,
				5,
				13
			},
			{
				30001,
				31,
				16,
				16,
				27,
				20,
				16,
				30001
			}
		},
		"pan_tao_feast_activty_rule",
		{
			"ui#pantaofeastrankview#622001",
			"",
			"ui#pantaofeastbookview#622001"
		},
		4930013,
		1817,
		1
	}
}
local t_pan_tao_feast_activity = {
	[622001] = dataList[1]
}

t_pan_tao_feast_activity.dataList = dataList

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

return t_pan_tao_feast_activity
