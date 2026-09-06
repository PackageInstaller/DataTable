-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_good_feeling_common.lua

module("logicconfig.config.t_good_feeling_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_INTERACT_COUNT",
		"3"
	},
	{
		"DAILY_SELF_CHAT_COUNT",
		"1"
	},
	{
		"DAILY_SCHEDULE_CHAT_TIMES",
		"12:00:00|18:00:00"
	},
	{
		"COMMON_ANSWER_DESC",
		"我觉得这一题你不一定会哦！说好了不许偷看！上网查的都是小傻瓜！"
	}
}
local t_good_feeling_common = {
	DAILY_INTERACT_COUNT = dataList[1],
	DAILY_SELF_CHAT_COUNT = dataList[2],
	DAILY_SCHEDULE_CHAT_TIMES = dataList[3],
	COMMON_ANSWER_DESC = dataList[4]
}

t_good_feeling_common.dataList = dataList

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

return t_good_feeling_common
