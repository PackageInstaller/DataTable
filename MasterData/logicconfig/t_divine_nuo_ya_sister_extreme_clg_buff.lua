-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_sister_extreme_clg_buff.lua

module("logicconfig.config.t_divine_nuo_ya_sister_extreme_clg_buff", package.seeall)

local title = {
	buffDesc = 4,
	typeId = 2,
	activityId = 1,
	number = 3
}
local dataList = {
	{
		407001,
		1,
		1,
		"敌阵精灵每次受击时，自身每拥有100点气势，受到的伤害降低10%"
	},
	{
		407001,
		1,
		2,
		"敌阵精灵每次受击时，自身每拥有100点气势，受到的伤害降低20%"
	},
	{
		407001,
		1,
		3,
		"敌阵精灵每次受击时，自身每拥有100点气势，受到的伤害降低30%"
	},
	{
		407001,
		1,
		4,
		"敌阵精灵每次受击时，自身每拥有100点气势，受到的伤害降低50%"
	},
	{
		407001,
		1,
		5,
		"敌阵精灵每次受击时，自身每拥有50点气势，受到的伤害降低50%"
	},
	{
		407001,
		1,
		6,
		"敌阵精灵每次受击时，自身每拥有50点气势，受到的伤害降低75%"
	},
	{
		407001,
		2,
		1,
		"己阵精灵每次受击时，自身每拥有100点气势，受到的伤害增加10%"
	},
	{
		407001,
		2,
		2,
		"己阵精灵每次受击时，自身每拥有100点气势，受到的伤害增加20%"
	},
	{
		407001,
		2,
		3,
		"己阵精灵每次受击时，自身每拥有100点气势，受到的伤害增加30%"
	},
	{
		407001,
		2,
		4,
		"己阵精灵每次受击时，自身每拥有100点气势，受到的伤害增加50%"
	},
	{
		407001,
		2,
		5,
		"己阵精灵每次受击时，自身每拥有50点气势，受到的伤害增加50%"
	},
	{
		407001,
		2,
		6,
		"己阵精灵每次受击时，自身每拥有50点气势，受到的伤害增加75%"
	},
	{
		407002,
		1,
		1,
		"敌阵精灵每次受击时，自身每拥有100点气势，受到的伤害降低10%"
	},
	{
		407002,
		1,
		2,
		"敌阵精灵每次受击时，自身每拥有100点气势，受到的伤害降低20%"
	},
	{
		407002,
		1,
		3,
		"敌阵精灵每次受击时，自身每拥有100点气势，受到的伤害降低30%"
	},
	{
		407002,
		1,
		4,
		"敌阵精灵每次受击时，自身每拥有100点气势，受到的伤害降低50%"
	},
	{
		407002,
		1,
		5,
		"敌阵精灵每次受击时，自身每拥有50点气势，受到的伤害降低50%"
	},
	{
		407002,
		1,
		6,
		"敌阵精灵每次受击时，自身每拥有50点气势，受到的伤害降低75%"
	},
	{
		407002,
		2,
		1,
		"己阵精灵每次受击时，自身每拥有100点气势，受到的伤害增加10%"
	},
	{
		407002,
		2,
		2,
		"己阵精灵每次受击时，自身每拥有100点气势，受到的伤害增加20%"
	},
	{
		407002,
		2,
		3,
		"己阵精灵每次受击时，自身每拥有100点气势，受到的伤害增加30%"
	},
	{
		407002,
		2,
		4,
		"己阵精灵每次受击时，自身每拥有100点气势，受到的伤害增加50%"
	},
	{
		407002,
		2,
		5,
		"己阵精灵每次受击时，自身每拥有50点气势，受到的伤害增加50%"
	},
	{
		407002,
		2,
		6,
		"己阵精灵每次受击时，自身每拥有50点气势，受到的伤害增加75%"
	}
}
local t_divine_nuo_ya_sister_extreme_clg_buff = {
	[407001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	},
	[407002] = {
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		},
		{
			dataList[19],
			dataList[20],
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24]
		}
	}
}

t_divine_nuo_ya_sister_extreme_clg_buff.dataList = dataList

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

return t_divine_nuo_ya_sister_extreme_clg_buff
