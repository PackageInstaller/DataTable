-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_man_clg_activity.lua

module("logicconfig.config.t_dragon_man_clg_activity", package.seeall)

local title = {
	gotoRank = 4,
	activityId = 1,
	gotoDirectShop = 6,
	skinId = 7,
	gotoShop = 5,
	prize = 2,
	ruleKey = 3
}
local dataList = {
	{
		552001,
		"100:12039:1:1",
		"dragon_man_clg_rule",
		"func#618#12039",
		"mibao#MibaoShop",
		"func#95#jinglingyangcheng#all#50065",
		12039
	}
}
local t_dragon_man_clg_activity = {
	[552001] = dataList[1]
}

t_dragon_man_clg_activity.dataList = dataList

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

return t_dragon_man_clg_activity
