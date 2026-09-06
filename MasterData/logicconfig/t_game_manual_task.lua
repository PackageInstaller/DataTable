-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_manual_task.lua

module("logicconfig.config.t_game_manual_task", package.seeall)

local title = {
	id = 1,
	title = 2,
	taskInfo = 3
}
local dataList = {
	{
		1,
		"王者之路",
		"任务目标：战胜并获得圣光飞龙精灵"
	},
	{
		2,
		"猪猪成长记",
		"任务目标：达亲密度8级获得猪猪坐骑"
	},
	{
		3,
		"战术教室",
		"任务目标：通关“中阶战术”的第4关"
	},
	{
		4,
		"九宫八阵",
		"任务目标：通关防御阵第10关"
	}
}
local t_game_manual_task = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_game_manual_task.dataList = dataList

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

return t_game_manual_task
