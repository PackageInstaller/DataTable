-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_meng_meng_clg_activity.lua

module("logicconfig.config.t_origin_king_meng_meng_clg_activity", package.seeall)

local title = {
	normalClgSupportPetPlanId = 8,
	extremeClgSupportPetId = 5,
	normalClgCreepsMasterId = 6,
	unlockBossStageValue = 3,
	normalClgPetFilter = 9,
	extremeClgCreepsMasterId = 4,
	jumpStrTwo = 13,
	jumpStrOne = 12,
	skinId = 11,
	normalClgPrize = 7,
	jumpStrThree = 14,
	jumpStrFive = 16,
	jumpStrFour = 15,
	ruleKeyMain = 10,
	activityId = 1,
	extremePrize = 2
}
local dataList = {
	{
		594001,
		"4:510803:100",
		350,
		1006,
		100000010,
		1012,
		"4:443:10",
		1,
		"Signs$梦之队",
		"yqwzmm_rule",
		11041,
		"func#618#11041",
		"event#gotofirstpassrankview#594001",
		"func#43#129",
		"ui#lottery",
		"mibao#mengduiyangcheng"
	}
}
local t_origin_king_meng_meng_clg_activity = {
	[594001] = dataList[1]
}

t_origin_king_meng_meng_clg_activity.dataList = dataList

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

return t_origin_king_meng_meng_clg_activity
