-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_field_filed.lua

module("logicconfig.config.t_holy_dragon_field_filed", package.seeall)

local title = {
	bgUrl = 10,
	openTime = 4,
	supportPetPlan = 5,
	fieldId = 2,
	rankPlanId = 9,
	relevantFloorId = 8,
	nameLangkey = 3,
	mustDeployRace = 6,
	activityId = 1,
	lockHeroSkill = 7
}
local dataList = {
	{
		611001,
		1,
		"holydragonfield_name_1",
		"2026-06-26T05:00:00",
		2,
		14046,
		0,
		1,
		2,
		"holydragonfield/bg_slzc_02"
	},
	{
		611001,
		2,
		"holydragonfield_name_2",
		"2026-07-03T05:00:00",
		1,
		14045,
		0,
		2,
		1,
		"holydragonfield/bg_slzc_04"
	},
	{
		611001,
		3,
		"holydragonfield_name_3",
		"2026-07-10T05:00:00",
		3,
		14049,
		414049,
		3,
		3,
		"holydragonfield/bg_slzc_03"
	}
}
local t_holy_dragon_field_filed = {
	[611001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_holy_dragon_field_filed.dataList = dataList

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

return t_holy_dragon_field_filed
