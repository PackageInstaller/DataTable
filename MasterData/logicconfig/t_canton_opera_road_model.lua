-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_model.lua

module("logicconfig.config.t_canton_opera_road_model", package.seeall)

local title = {
	maxProgress = 7,
	modelProgressItem = 6,
	openTime = 4,
	costEnergy = 9,
	unlockCondition = 8,
	planId = 1,
	endTime = 5,
	modelId = 2,
	gameActId = 3,
	ruleKey = 10
}
local dataList = {
	{
		1,
		1,
		0,
		"2022-09-02T05:00:00",
		"2022-09-18T05:00:00",
		"10:189001",
		80,
		0,
		"66:5:50",
		""
	},
	{
		1,
		2,
		20002,
		"2022-09-04T05:00:00",
		"2022-09-18T05:00:00",
		"10:189002",
		100,
		1,
		"66:5:100",
		""
	},
	{
		1,
		3,
		68003,
		"2022-09-07T05:00:00",
		"2022-09-18T05:00:00",
		"10:189003",
		360,
		2,
		"66:5:120",
		""
	},
	{
		1,
		4,
		0,
		"2022-09-10T05:00:00",
		"2022-09-16T03:00:00",
		"",
		500000,
		3,
		"",
		""
	},
	{
		1,
		5,
		0,
		"2022-09-16T03:00:00",
		"2022-09-18T05:00:00",
		"",
		101377,
		4,
		"",
		""
	}
}
local t_canton_opera_road_model = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_canton_opera_road_model.dataList = dataList

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

return t_canton_opera_road_model
