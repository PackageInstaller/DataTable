-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dark_king_dragon_clg_phase.lua

module("logicconfig.config.t_divine_dark_king_dragon_clg_phase", package.seeall)

local title = {
	convertType = 5,
	convertParam = 6,
	phaseId = 2,
	actDesc = 10,
	phaseName = 12,
	lockNum = 4,
	prize = 8,
	majorAxis = 13,
	lockType = 3,
	roundAngle = 7,
	passDesc = 9,
	minorAxis = 14,
	settlementDesc = 15,
	activityId = 1,
	lockDesc = 11
}
local dataList = {
	{
		526001,
		1,
		"MOST_ZDL",
		2,
		"ACTIVE",
		"",
		360,
		"4:400:25",
		"黄色星环所有关卡通关",
		"黄色星洞激活条件：锁定战力最高的1只精灵（达到2只后星洞激活）",
		"锁定战力最高的精灵",
		"黄色星轨",
		590,
		268,
		"精灵存活数："
	},
	{
		526001,
		2,
		"DEAD",
		6,
		"CIRCLE",
		"",
		360,
		"4:400:25",
		"红色星环所有关卡通关",
		"红色星洞激活条件：锁定阵亡精灵（达到6只后星洞激活）",
		"锁定全部死亡精灵",
		"红色星轨",
		485,
		300,
		"回合数："
	},
	{
		526001,
		3,
		"ALL",
		18,
		"BUFF_NUM",
		"20052502",
		360,
		"4:400:25",
		"紫色星环所有关卡通关",
		"紫色星洞激活条件：锁定全部上阵精灵（达到18只后星洞激活）",
		"锁定全部上阵精灵",
		"紫色星轨",
		322,
		207,
		"闪避次数："
	},
	{
		526001,
		4,
		"NOTHING",
		0,
		"NOTHING",
		"",
		360,
		"4:400:25",
		"最终关卡通关",
		"",
		"",
		"暗星挑战",
		0,
		0,
		""
	}
}
local t_divine_dark_king_dragon_clg_phase = {
	[526001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_dark_king_dragon_clg_phase.dataList = dataList

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

return t_divine_dark_king_dragon_clg_phase
