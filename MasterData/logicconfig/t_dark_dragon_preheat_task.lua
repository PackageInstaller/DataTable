-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_preheat_task.lua

module("logicconfig.config.t_dark_dragon_preheat_task", package.seeall)

local title = {
	score = 8,
	source = 9,
	type = 5,
	title = 3,
	prize = 7,
	desc = 4,
	id = 2,
	maxProgress = 6,
	taskPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"阅读剧情",
		"阅读剧情“水与暗的相约”",
		46,
		1,
		"",
		1,
		"event#cardhottaskstory#52001#1#7020001"
	},
	{
		1,
		2,
		"登录游戏",
		"累计登录3天",
		1,
		3,
		"",
		1,
		""
	},
	{
		1,
		3,
		"暗系集结",
		"获得10只暗系精灵数量",
		12,
		10,
		"",
		1,
		"func#43#19"
	},
	{
		1,
		4,
		"暗系试炼",
		"成功通关是非之塔10层",
		48,
		10,
		"",
		1,
		"func#15"
	}
}
local t_dark_dragon_preheat_task = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_dark_dragon_preheat_task.dataList = dataList

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

return t_dark_dragon_preheat_task
