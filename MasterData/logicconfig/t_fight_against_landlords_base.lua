-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fight_against_landlords_base.lua

module("logicconfig.config.t_fight_against_landlords_base", package.seeall)

local title = {
	gamePlanId = 2,
	cpPlanId = 4,
	buffPlanId = 3,
	prize = 5,
	scoreItem = 6,
	loseNum = 7,
	activityId = 1
}
local dataList = {
	{
		243001,
		1,
		1,
		1,
		"10:243001:1",
		"1004:1278",
		35
	},
	{
		243002,
		1,
		2,
		2,
		"10:243002:1",
		"1004:1311",
		35
	},
	{
		243003,
		1,
		2,
		2,
		"10:243002:1",
		"1004:1311",
		35
	},
	{
		243004,
		1,
		2,
		3,
		"10:310006:1#10:243004:1",
		"1004:1311",
		35
	},
	{
		243005,
		1,
		2,
		3,
		"10:310006:1#10:243004:1",
		"1004:1311",
		35
	},
	{
		243006,
		1,
		3,
		99,
		"10:243006:1",
		"1004:1311",
		30
	},
	{
		243007,
		1,
		3,
		99,
		"10:243008:10#10:310012:1#10:310013:1",
		"1004:1311",
		3
	}
}
local t_fight_against_landlords_base = {
	[243001] = dataList[1],
	[243002] = dataList[2],
	[243003] = dataList[3],
	[243004] = dataList[4],
	[243005] = dataList[5],
	[243006] = dataList[6],
	[243007] = dataList[7]
}

t_fight_against_landlords_base.dataList = dataList

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

return t_fight_against_landlords_base
