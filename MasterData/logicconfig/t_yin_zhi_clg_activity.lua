-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yin_zhi_clg_activity.lua

module("logicconfig.config.t_yin_zhi_clg_activity", package.seeall)

local title = {
	jumpStr3 = 5,
	ruleKey = 7,
	jumpStr2 = 4,
	attributes = 2,
	skinId = 8,
	jumpStr1 = 3,
	activityId = 1,
	jumpStr4 = 6
}
local dataList = {
	{
		486001,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		"func#618#16038",
		"mibao#jinglingyangcheng",
		"func#1240",
		"",
		"yinzhiclgmainview_rule",
		16038
	},
	{
		486002,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		"func#618#11038",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"func#545#52",
		"originbinglingwangclgmainview_rule",
		11038
	}
}
local t_yin_zhi_clg_activity = {
	[486001] = dataList[1],
	[486002] = dataList[2]
}

t_yin_zhi_clg_activity.dataList = dataList

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

return t_yin_zhi_clg_activity
