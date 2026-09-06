-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_prediction_formation.lua

module("logicconfig.config.t_form_prediction_formation", package.seeall)

local title = {
	posList = 7,
	name = 8,
	petPlanId = 3,
	prizePlanId = 4,
	publicationTime = 6,
	activityId = 1,
	formId = 2,
	rankPrizePlanId = 5
}
local dataList = {
	{
		385001,
		1,
		1,
		1,
		1,
		"2024-08-02T05:00:00",
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"通灵师究阵"
	},
	{
		385001,
		2,
		2,
		2,
		2,
		"2024-08-09T05:00:00",
		{
			1,
			2,
			4,
			5,
			7,
			8
		},
		"创属性阵"
	}
}
local t_form_prediction_formation = {
	[385001] = {
		dataList[1],
		dataList[2]
	}
}

t_form_prediction_formation.dataList = dataList

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

return t_form_prediction_formation
