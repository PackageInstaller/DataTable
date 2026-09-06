-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_model.lua

module("logicconfig.config.t_lotus_battle_field_model", package.seeall)

local title = {
	usePackage = 6,
	name = 3,
	obsoletePlanId = 11,
	maxEndTimeSec = 15,
	activityId = 1,
	matchPlanId = 7,
	rankPlanId = 12,
	openTime = 13,
	spoilsRank = 14,
	memberNum = 4,
	model = 2,
	buffPlanId = 9,
	dailyTimes = 5,
	winBuffPlanId = 10,
	petPoolId = 8
}
local dataList = {
	{
		268001,
		1,
		"16人场",
		16,
		5,
		false,
		1,
		1,
		1,
		1,
		1,
		1,
		"10:00:00#12:00:00,14:00:00#18:00:00,20:00:00#23:00:00",
		4,
		900
	},
	{
		268001,
		2,
		"24人场",
		24,
		3,
		true,
		1,
		1,
		1,
		1,
		1,
		2,
		"12:00:00#14:00:00,18:00:00#20:00:00",
		12,
		900
	},
	{
		268002,
		1,
		"16人场",
		16,
		5,
		false,
		1,
		2,
		1,
		1,
		1,
		1,
		"10:00:00#12:00:00,14:00:00#18:00:00,20:00:00#23:00:00",
		4,
		900
	},
	{
		268002,
		2,
		"24人场",
		24,
		3,
		true,
		1,
		2,
		1,
		1,
		1,
		2,
		"12:00:00#14:00:00,18:00:00#20:00:00",
		12,
		900
	}
}
local t_lotus_battle_field_model = {
	[268001] = {
		dataList[1],
		dataList[2]
	},
	[268002] = {
		dataList[3],
		dataList[4]
	}
}

t_lotus_battle_field_model.dataList = dataList

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

return t_lotus_battle_field_model
