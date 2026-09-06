-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_nuo_ya_extreme_clg_buff.lua

module("logicconfig.config.t_miracle_nuo_ya_extreme_clg_buff", package.seeall)

local title = {
	leftHpPercent = 3,
	buffId = 2,
	buffDesc = 5,
	title = 4,
	activityId = 1
}
local dataList = {
	{
		382001,
		1,
		90,
		"90%-100%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>10%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>80</color> ，出手时降低敌方<color=#eb4624>25</color>气势"
	},
	{
		382001,
		2,
		70,
		"70%-89%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>20%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>60</color>，出手时降低敌方<color=#eb4624>30</color>气势"
	},
	{
		382001,
		3,
		50,
		"50%-69%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升 <color=#eb4624>30%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>40</color>，出手时降低敌方<color=#eb4624>35</color>气势"
	},
	{
		382001,
		4,
		30,
		"30%-49%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>40%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>30</color> ，出手时降低敌方<color=#eb4624>40</color>气势"
	},
	{
		382001,
		5,
		10,
		"10%-29%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>50%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>20</color> ，出手时降低敌方<color=#eb4624>45</color>气势"
	},
	{
		382001,
		6,
		0,
		"0%-9%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>60%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>10</color> ，出手时降低敌方<color=#eb4624>50</color>气势"
	},
	{
		382002,
		1,
		90,
		"90%-100%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>10%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>80</color> ，出手时降低敌方<color=#eb4624>25</color>气势"
	},
	{
		382002,
		2,
		70,
		"70%-89%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>20%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>60</color>，出手时降低敌方<color=#eb4624>30</color>气势"
	},
	{
		382002,
		3,
		50,
		"50%-69%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升 <color=#eb4624>30%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>40</color>，出手时降低敌方<color=#eb4624>35</color>气势"
	},
	{
		382002,
		4,
		30,
		"30%-49%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>40%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>30</color> ，出手时降低敌方<color=#eb4624>40</color>气势"
	},
	{
		382002,
		5,
		10,
		"10%-29%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>50%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>20</color> ，出手时降低敌方<color=#eb4624>45</color>气势"
	},
	{
		382002,
		6,
		0,
		"0%-9%",
		"己阵：自身首次攻击时，暴击率及暴击伤害提升<color=#eb4624>60%</color>\r\n敌阵：初始气势额外提升<color=#eb4624>10</color> ，出手时降低敌方<color=#eb4624>50</color>气势"
	}
}
local t_miracle_nuo_ya_extreme_clg_buff = {
	[382001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[382002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_miracle_nuo_ya_extreme_clg_buff.dataList = dataList

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

return t_miracle_nuo_ya_extreme_clg_buff
