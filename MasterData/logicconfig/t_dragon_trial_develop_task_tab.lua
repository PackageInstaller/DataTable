-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_develop_task_tab.lua

module("logicconfig.config.t_dragon_trial_develop_task_tab", package.seeall)

local title = {
	lockTip = 5,
	openTime = 4,
	tabName = 2,
	raceId = 1,
	icon = 3
}
local dataList = {
	{
		10343,
		"爱心梦梦",
		"skill_610343",
		"",
		""
	},
	{
		10339,
		"暗黑梦梦",
		"skill_610339",
		"",
		""
	},
	{
		10342,
		"热血梦梦",
		"skill_610342",
		"2022-05-13 05:00:00",
		"2022-05-13开启热血梦梦的养成任务"
	},
	{
		10341,
		"炼金梦梦",
		"skill_610341",
		"2022-05-13 05:00:00",
		"2022-05-13开启炼金梦梦的养成任务"
	},
	{
		10338,
		"哆啦梦梦",
		"skill_610338",
		"2022-05-13 05:00:00",
		"2022-05-13开启哆啦梦梦的养成任务"
	}
}
local t_dragon_trial_develop_task_tab = {
	[10343] = dataList[1],
	[10339] = dataList[2],
	[10342] = dataList[3],
	[10341] = dataList[4],
	[10338] = dataList[5]
}

t_dragon_trial_develop_task_tab.dataList = dataList

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

return t_dragon_trial_develop_task_tab
