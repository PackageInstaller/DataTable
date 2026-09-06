-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_hero_activity.lua

module("logicconfig.config.t_miracle_hero_activity", package.seeall)

local title = {
	totalSwitch = 6,
	costMatType = 9,
	copyId = 5,
	encryptorSwitch = 7,
	bubbleShowMat = 10,
	redPointId = 2,
	ultSkillElementNum = 8,
	shopGoto = 4,
	activityId = 1,
	ruleKey = 3
}
local dataList = {
	{
		383001,
		588,
		"miracle_hero_rule_key",
		"",
		4680001,
		true,
		true,
		4,
		"10:383007",
		"1004:1374:1"
	},
	{
		383002,
		588,
		"miracle_hero_rule_key",
		"",
		0,
		true,
		true,
		4,
		"10:383009",
		""
	},
	{
		383003,
		662,
		"miracle_hero_rule_key",
		"",
		4750001,
		true,
		true,
		4,
		"10:383011",
		"4:510399:2"
	},
	{
		383004,
		662,
		"miracle_hero_rule_key",
		"",
		0,
		true,
		true,
		4,
		"10:383011",
		"4:510399:2"
	}
}
local t_miracle_hero_activity = {
	[383001] = dataList[1],
	[383002] = dataList[2],
	[383003] = dataList[3],
	[383004] = dataList[4]
}

t_miracle_hero_activity.dataList = dataList

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

return t_miracle_hero_activity
