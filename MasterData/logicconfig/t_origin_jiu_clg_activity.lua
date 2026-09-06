-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_jiu_clg_activity.lua

module("logicconfig.config.t_origin_jiu_clg_activity", package.seeall)

local title = {
	jumpStrThree = 7,
	jumpStrOne = 5,
	jumpRedIdThree = 12,
	skinId = 3,
	jumpRedIdFive = 14,
	jumpStrTwo = 6,
	jumpRedIdTwo = 11,
	jumpRedIdFour = 13,
	jumpRedIdOne = 10,
	jumpStrFive = 9,
	jumpStrFour = 8,
	ruleKeyMain = 2,
	activityId = 1,
	bossSkinId = 4
}
local dataList = {
	{
		577001,
		"yuanqijiu_rule",
		17025,
		17025,
		"event#gotofirstpassrankview#577001",
		"func#618#17025",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"func#43#145",
		"",
		"",
		"",
		"",
		""
	}
}
local t_origin_jiu_clg_activity = {
	[577001] = dataList[1]
}

t_origin_jiu_clg_activity.dataList = dataList

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

return t_origin_jiu_clg_activity
