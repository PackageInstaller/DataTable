-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_yun_jie_dragon_clg_activity.lua

module("logicconfig.config.t_yun_jie_dragon_clg_activity", package.seeall)

local title = {
	ruleKey = 4,
	skinId = 5,
	jumpTo = 3,
	activityId = 1,
	passPrize = 2
}
local dataList = {
	{
		572001,
		"100:17026:1:1",
		{
			"func#618#17026",
			"func#95#Skin",
			"ui#wandererpassmainview#582001#4",
			"func#545#25"
		},
		"jianlong_rule",
		17026
	}
}
local t_yun_jie_dragon_clg_activity = {
	[572001] = dataList[1]
}

t_yun_jie_dragon_clg_activity.dataList = dataList

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

return t_yun_jie_dragon_clg_activity
