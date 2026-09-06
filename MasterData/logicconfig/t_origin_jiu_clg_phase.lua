-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_jiu_clg_phase.lua

module("logicconfig.config.t_origin_jiu_clg_phase", package.seeall)

local title = {
	prize = 5,
	ruleDesc = 6,
	phaseId = 3,
	type = 4,
	modelId = 2,
	activityId = 1
}
local dataList = {
	{
		577001,
		1,
		1,
		"COMMON",
		"8:1:200000",
		"1.生死之轴：选择关卡进行挑战\r\n2.同一序列内，后一关会继承前一关的某项规则（如“敌阵首回合伤害提升”）\r\n3.序列光环（收益）：通关本层后，获得该光环；效果：在受到克制伤害时，将此次伤害降低20%（或锁精灵）"
	},
	{
		577001,
		1,
		2,
		"WHEEL",
		"8:1:200000",
		"1.生死之轴：选择关卡进行挑战\r\n2.同一序列内，后一关会继承前一关的某项规则（如“敌阵首回合伤害提升”）\r\n3.序列光环（收益）：通关本层后，获得该光环；效果：首次受到致命伤害时，若受到的致命伤害是克制伤害，则复活并获得30%血量，否则复活并获得1%血量（或锁精灵）"
	},
	{
		577001,
		1,
		3,
		"LOCK_PET",
		"8:1:200000",
		"1.生死之轴：选择关卡进行挑战\r\n2.同一序列内，后一关会继承前一关的某项规则（如“敌阵首回合伤害提升”）\r\n3.序列光环（收益）：通关本层后，获得该光环；效果：进入战斗时，获得40点通灵点（或锁精灵）"
	},
	{
		577001,
		2,
		1,
		"COMMON",
		"4:90004:1",
		"1.生死之轴：选择关卡进行挑战"
	},
	{
		577001,
		2,
		2,
		"COMMON",
		"4:30006:40",
		"1.轮回之轴：选择关卡进行挑战"
	},
	{
		577001,
		2,
		3,
		"COMMON",
		"8:1:1000000",
		"1.冥王之轴：选择关卡进行挑战"
	}
}
local t_origin_jiu_clg_phase = {
	[577001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_origin_jiu_clg_phase.dataList = dataList

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

return t_origin_jiu_clg_phase
