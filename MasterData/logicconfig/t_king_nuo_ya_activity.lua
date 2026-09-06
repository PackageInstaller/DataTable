-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_nuo_ya_activity.lua

module("logicconfig.config.t_king_nuo_ya_activity", package.seeall)

local title = {
	lottery_jump = 5,
	rank_jump = 6,
	shop_jump = 4,
	skinId = 3,
	activityId = 1,
	challengeTime = 2
}
local dataList = {
	{
		321001,
		300,
		14020,
		"mibao#shengrihui4",
		"func#1002",
		"func#618#14020"
	}
}
local t_king_nuo_ya_activity = {
	[321001] = dataList[1]
}

t_king_nuo_ya_activity.dataList = dataList

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

return t_king_nuo_ya_activity
