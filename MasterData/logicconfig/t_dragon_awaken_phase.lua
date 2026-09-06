-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_phase.lua

module("logicconfig.config.t_dragon_awaken_phase", package.seeall)

local title = {
	plotId = 5,
	openTime = 3,
	phaseId = 2,
	curPowerStr = 9,
	evolDesc = 8,
	showDesc = 7,
	stagePlan = 4,
	phaseName = 6,
	activityId = 1
}
local dataList = {
	{
		419001,
		1,
		"2024-09-27T05:00:00",
		1,
		0,
		"复活权柄",
		"共鸣程度：0%",
		"",
		"通关后续章节，可逐步收集权柄"
	},
	{
		419001,
		2,
		"2024-09-27T05:00:00",
		2,
		4730002,
		"光核权柄",
		"共鸣程度：25%",
		"获得复活权柄，首次死亡时，移除负面，恢复生命值至80%",
		"已获得权柄：复活"
	},
	{
		419001,
		3,
		"2024-11-29T05:00:00",
		3,
		4730003,
		"伤害权柄",
		"共鸣程度：50%",
		"获得光核权柄，给目标及目标周围的精灵施加光核",
		"已获得权柄：复活、光核"
	},
	{
		419001,
		4,
		"2024-11-29T05:00:00",
		4,
		4730004,
		"属性权柄",
		"共鸣程度：75%",
		"获得伤害权柄，伤害+30%",
		"已获得权柄：复活、光核、伤害"
	},
	{
		419001,
		5,
		"2024-11-29T05:00:00",
		5,
		4730005,
		"觉醒\r\n权柄",
		"共鸣程度：100%",
		"获得属性权柄，全属性+30%",
		"已获得权柄：复活、光核、伤害、属性"
	},
	{
		419002,
		1,
		"2025-02-28T05:00:00",
		6,
		0,
		"赤焰权柄",
		"共鸣程度：0%",
		"",
		"通关后续章节，可逐步收集权柄"
	},
	{
		419002,
		2,
		"2025-02-28T05:00:00",
		7,
		4790002,
		"红莲权柄",
		"共鸣程度：25%",
		"获得赤焰权柄，首次死亡时，移除负面，恢复生命值至80%",
		"已获得权柄：赤焰"
	},
	{
		419002,
		3,
		"2025-03-15T05:00:00",
		8,
		4790003,
		"伤害权柄",
		"共鸣程度：50%",
		"获得红莲权柄，自身攻击目标若包含男性，则提升气势并免疫下次攻击",
		"已获得权柄：赤焰、红莲"
	},
	{
		419002,
		4,
		"2025-03-15T05:00:00",
		9,
		4790004,
		"属性权柄",
		"共鸣程度：75%",
		"获得伤害权柄，伤害+30%",
		"已获得权柄：赤焰、红莲、伤害"
	},
	{
		419002,
		5,
		"2025-03-15T05:00:00",
		10,
		4790005,
		"涅槃\r\n权柄",
		"共鸣程度：100%",
		"获得属性权柄，全属性+30%",
		"已获得权柄：赤焰、红莲、伤害、属性"
	}
}
local t_dragon_awaken_phase = {
	[419001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[419002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_dragon_awaken_phase.dataList = dataList

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

return t_dragon_awaken_phase
