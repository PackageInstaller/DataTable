-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_longyan_clg_activity.lua

module("logicconfig.config.t_origin_longyan_clg_activity", package.seeall)

local title = {
	gotoRaise = 4,
	gotoPack = 5,
	activityId = 1,
	skinId = 7,
	ruleKey = 6,
	gotoRank = 2,
	gotoShop = 3
}
local dataList = {
	{
		563001,
		"func#618#12042",
		"ui#lottery",
		"mibao#yuanqilibao",
		"func#1181",
		"yuanqilongyan_rule",
		12042
	}
}
local t_origin_longyan_clg_activity = {
	[563001] = dataList[1]
}

t_origin_longyan_clg_activity.dataList = dataList

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

return t_origin_longyan_clg_activity
