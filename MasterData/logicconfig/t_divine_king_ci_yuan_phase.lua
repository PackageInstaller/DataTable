-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_ci_yuan_phase.lua

module("logicconfig.config.t_divine_king_ci_yuan_phase", package.seeall)

local title = {
	stagePlanId = 4,
	openTime = 3,
	phaseId = 2,
	prize = 5,
	rule = 6,
	activityId = 1
}
local dataList = {
	{
		405001,
		1,
		"2024-09-29T05:00:00",
		1,
		"4:510361:20",
		"①每关需要己阵出手次数达到要求才算通关\r\n②通关时，己阵出手次数最多的精灵在本层其他挑战中不可在上阵\r\n③己阵每次出手后，自身气势增加30点"
	},
	{
		405001,
		2,
		"2024-09-29T05:00:00",
		2,
		"4:510361:30",
		"①每关需要己阵出手次数达到要求才算通关\r\n②通关时，己阵出手次数最多的精灵在本层其他挑战中不可在上阵\r\n③敌阵精灵每受到一次攻击，气势增加30点"
	},
	{
		405001,
		3,
		"2024-09-29T05:00:00",
		3,
		"4:510361:50",
		"①每关需要己阵出手次数达到要求才算通关\r\n②通关时，己阵出手次数最多的精灵在本层其他挑战中不可在上阵\r\n③敌阵精灵每受到一次攻击，气势增加30点且全属性增加10%"
	},
	{
		405002,
		1,
		"2024-09-29T05:00:00",
		1,
		"8:1:1",
		"①每关需要己阵出手次数达到要求才算通关\r\n②通关时，己阵出手次数最多的精灵在本层其他挑战中不可在上阵\r\n③己阵每次出手后，自身气势增加30点"
	},
	{
		405002,
		2,
		"2024-09-29T05:00:00",
		2,
		"8:1:1",
		"①每关需要己阵出手次数达到要求才算通关\r\n②通关时，己阵出手次数最多的精灵在本层其他挑战中不可在上阵\r\n③敌阵精灵每受到一次攻击，气势增加30点"
	},
	{
		405002,
		3,
		"2024-09-29T05:00:00",
		3,
		"8:1:1",
		"①每关需要己阵出手次数达到要求才算通关\r\n②通关时，己阵出手次数最多的精灵在本层其他挑战中不可在上阵\r\n③敌阵精灵每受到一次攻击，气势增加30点且全属性增加10%"
	}
}
local t_divine_king_ci_yuan_phase = {
	[405001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[405002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_king_ci_yuan_phase.dataList = dataList

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

return t_divine_king_ci_yuan_phase
