-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saintknight_rui_buff.lua

module("logicconfig.config.t_saintknight_rui_buff", package.seeall)

local title = {
	id = 2,
	gameProgress = 3,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		172001,
		1,
		15,
		{
			"己阵生命及全属性+30%",
			"命中率+20%"
		}
	},
	{
		172001,
		2,
		30,
		{
			"己阵生命及全属性+20%",
			"无视目标20%防御"
		}
	},
	{
		172001,
		3,
		45,
		{
			"己阵生命及全属性+20%",
			"暴击率+20%"
		}
	},
	{
		172001,
		4,
		60,
		{
			"己阵生命及全属性+20%",
			"超杀伤害+15%"
		}
	},
	{
		172001,
		5,
		75,
		{
			"己阵生命及全属性+20%",
			"受到伤害减少10%"
		}
	},
	{
		172001,
		6,
		90,
		{
			"己阵生命及全属性+10%",
			"迷踪出手后为自身和己阵生命最低的精灵恢复10%的生命"
		}
	},
	{
		172001,
		7,
		105,
		{
			"己阵生命及全属性+10%",
			"迷踪契约兽获得所有契约技效果"
		}
	},
	{
		172001,
		8,
		120,
		{
			"己阵生命及全属性+10%",
			"受到攻击时吸收攻击者10点气势"
		}
	},
	{
		172001,
		9,
		135,
		{
			"己阵生命上限及全属性+10%",
			"迷踪普攻会眩晕目标1回合"
		}
	},
	{
		172001,
		10,
		150,
		{
			"己阵生命及全属性+10%",
			"受到攻击时将受到的10%伤害转化为护盾"
		}
	},
	{
		172001,
		11,
		165,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		12,
		180,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		13,
		195,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		14,
		210,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		15,
		225,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		16,
		240,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		17,
		255,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		18,
		270,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		19,
		285,
		{
			"己阵生命及全属性+10%"
		}
	},
	{
		172001,
		20,
		300,
		{
			"己阵生命及全属性+10%"
		}
	}
}
local t_saintknight_rui_buff = {
	[172001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_saintknight_rui_buff.dataList = dataList

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

return t_saintknight_rui_buff
