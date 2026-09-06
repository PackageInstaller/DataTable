-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_eternal_dragon_clg_activity.lua

module("logicconfig.config.t_origin_eternal_dragon_clg_activity", package.seeall)

local title = {
	firstPassPrize = 2,
	jumpTo = 4,
	skinId = 3,
	seasonMatStr = 5,
	ruleKeyMain = 6,
	activityId = 1
}
local dataList = {
	{
		551001,
		"4:510681:100",
		13028,
		{
			"func#618#13028",
			"ui#lottery",
			"mibao#jinglingyangcheng",
			"event#gotofirstpassrankview#551001"
		},
		{
			"1004:1592:1",
			"1004:1593:1",
			"1004:1594:1",
			"1004:1595:1"
		},
		"origineternaldragonclgmainview"
	}
}
local t_origin_eternal_dragon_clg_activity = {
	[551001] = dataList[1]
}

t_origin_eternal_dragon_clg_activity.dataList = dataList

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

return t_origin_eternal_dragon_clg_activity
