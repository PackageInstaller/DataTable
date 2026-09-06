-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ares_activity.lua

module("logicconfig.config.t_ares_activity", package.seeall)

local title = {
	playerLevel = 5,
	plotParam = 6,
	notReceiveTip = 7,
	endTime = 4,
	id = 1,
	prize = 2,
	startTime = 3
}
local dataList = {
	{
		1,
		"100:10144:1:1",
		"2020-01-01T05:00:00",
		"2020-05-13T05:00:00",
		0,
		"chapterId:1005,stageId:13",
		"恭喜 <color=#EDDFAAFF>%s</color> 成功领取 生命王者·阿瑞斯"
	},
	{
		2,
		"100:10144:1:1",
		"2091-05-16T05:00:00",
		"2091-11-20T05:00:00",
		15,
		"",
		"恭喜 <color=#EDDFAAFF>%s</color> 成功领取 生命王者·阿瑞斯"
	},
	{
		3,
		"100:10144:1:1",
		"2092-12-04T05:00:00",
		"2093-12-11T05:00:00",
		12,
		"chapterId:1004,stageId:13",
		"恭喜 <color=#EDDFAAFF>%s</color> 成功领取 生命王者·阿瑞斯"
	}
}
local t_ares_activity = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_ares_activity.dataList = dataList

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

return t_ares_activity
