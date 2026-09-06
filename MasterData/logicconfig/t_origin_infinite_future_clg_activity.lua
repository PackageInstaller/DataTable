-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_infinite_future_clg_activity.lua

module("logicconfig.config.t_origin_infinite_future_clg_activity", package.seeall)

local title = {
	firstPassPrize = 2,
	jumpTo = 5,
	stageTip = 6,
	skinId = 3,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		619001,
		"4:510846:100",
		16047,
		"origininfinitefutureclgmainview_rule",
		{
			"event#gotofirstpassrankview#619001",
			"func#618#16047",
			"mibao#jinglingyangcheng",
			"ui#lottery"
		},
		"1次超杀=5%共振率，1次暴击=3%共振率，1次复活=10%共振率"
	}
}
local t_origin_infinite_future_clg_activity = {
	[619001] = dataList[1]
}

t_origin_infinite_future_clg_activity.dataList = dataList

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

return t_origin_infinite_future_clg_activity
