-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_hud.lua

module("logicconfig.config.t_teen_champion_king_hud", package.seeall)

local title = {
	activityId = 1,
	dateDesc = 6,
	startStepId = 4,
	endStepId = 5,
	title = 3,
	enterId = 2
}
local dataList = {
	{
		501001,
		1,
		"战区预选赛",
		1,
		1,
		"正赛时间：7.25-8.1\r\n娱乐时间：8.1-8.22"
	},
	{
		501001,
		2,
		"战区积分赛",
		2,
		2,
		"比赛时间：8.1-8.8"
	},
	{
		501001,
		3,
		"全服淘汰赛",
		3,
		10,
		"比赛时间：8.8-8.10"
	},
	{
		501001,
		4,
		"全服冠军赛",
		11,
		24,
		"比赛时间：8.10-8.16"
	},
	{
		501001,
		5,
		"全服娱乐赛",
		2,
		25,
		"正赛时间：7.25-8.1\r\n娱乐时间：8.1-8.22"
	}
}
local t_teen_champion_king_hud = {
	[501001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_teen_champion_king_hud.dataList = dataList

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

return t_teen_champion_king_hud
