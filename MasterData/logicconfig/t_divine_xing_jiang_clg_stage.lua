-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xing_jiang_clg_stage.lua

module("logicconfig.config.t_divine_xing_jiang_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 5,
	starAtlasId = 4,
	buffDesc3 = 9,
	buffDesc2 = 8,
	iconPath = 6,
	buffDesc1 = 7,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		359001,
		1,
		101,
		1,
		"摩羯座",
		"ui/icon/cutepet/icon_mengchong_01.png",
		{
			"2",
			"需要2回合内击败敌阵"
		},
		{
			"光",
			"己阵光属性精灵首次攻击前会永久变为小梦"
		},
		{
			"黑色",
			"敌方暗属性精灵必定暴击"
		}
	},
	{
		359001,
		2,
		102,
		1,
		"水瓶座",
		"ui/icon/cutepet/icon_mengchong_02.png",
		{
			"4",
			"需要4回合内击败敌阵"
		},
		{
			"水",
			"己阵水属性精灵首次攻击前会永久变为小梦"
		},
		{
			"红色",
			"敌方火属性精灵必定暴击"
		}
	},
	{
		359001,
		3,
		103,
		2,
		"双鱼座",
		"ui/icon/cutepet/icon_mengchong_03.png",
		{
			"3",
			"需要3回合内击败敌阵"
		},
		{
			"火",
			"己阵火属性精灵首次攻击前会永久变为小梦"
		},
		{
			"绿色",
			"敌方草属性精灵必定暴击"
		}
	},
	{
		359001,
		4,
		104,
		2,
		"白羊座",
		"ui/icon/cutepet/icon_mengchong_04.png",
		{
			"5",
			"需要5回合内击败敌阵"
		},
		{
			"空",
			"己阵空属性精灵首次攻击前会永久变为小梦"
		},
		{
			"黑色",
			"敌方暗属性精灵必定暴击"
		}
	},
	{
		359001,
		5,
		105,
		3,
		"金牛座",
		"ui/icon/cutepet/icon_mengchong_05.png",
		{
			"2",
			"需要2回合内击败敌阵"
		},
		{
			"草",
			"己阵草属性精灵首次攻击前会永久变为小梦"
		},
		{
			"绿色",
			"敌方草属性精灵必定暴击"
		}
	},
	{
		359001,
		6,
		106,
		3,
		"双子座",
		"ui/icon/cutepet/icon_mengchong_06.png",
		{
			"4",
			"需要4回合内击败敌阵"
		},
		{
			"暗",
			"己阵暗属性精灵首次攻击前会永久变为小梦"
		},
		{
			"青色",
			"敌方创属性精灵必定暴击"
		}
	},
	{
		359001,
		7,
		107,
		4,
		"巨蟹座",
		"ui/icon/cutepet/icon_mengchong_07.png",
		{
			"4",
			"需要4回合内击败敌阵"
		},
		{
			"空",
			"己阵空属性精灵首次攻击前会永久变为小梦"
		},
		{
			"黄色",
			"敌方光属性精灵必定暴击"
		}
	},
	{
		359001,
		8,
		108,
		4,
		"狮子座",
		"ui/icon/cutepet/icon_mengchong_08.png",
		{
			"3",
			"需要3回合内击败敌阵"
		},
		{
			"水",
			"己阵水属性精灵首次攻击前会永久变为小梦"
		},
		{
			"白色",
			"敌方空属性精灵必定暴击"
		}
	},
	{
		359001,
		9,
		109,
		5,
		"处女座",
		"ui/icon/cutepet/icon_mengchong_09.png",
		{
			"5",
			"需要5回合内击败敌阵"
		},
		{
			"暗",
			"己阵暗属性精灵首次攻击前会永久变为小梦"
		},
		{
			"黄色",
			"敌方光属性精灵必定暴击"
		}
	},
	{
		359001,
		10,
		110,
		5,
		"天秤座",
		"ui/icon/cutepet/icon_mengchong_10.png",
		{
			"2",
			"需要2回合内击败敌阵"
		},
		{
			"火",
			"己阵火属性精灵首次攻击前会永久变为小梦"
		},
		{
			"白色",
			"敌方空属性精灵必定暴击"
		}
	},
	{
		359001,
		11,
		111,
		6,
		"天蝎座",
		"ui/icon/cutepet/icon_mengchong_11.png",
		{
			"5",
			"需要5回合内击败敌阵"
		},
		{
			"光",
			"己阵光属性精灵首次攻击前会永久变为小梦"
		},
		{
			"红色",
			"敌方火属性精灵必定暴击"
		}
	},
	{
		359001,
		12,
		112,
		6,
		"射手座",
		"ui/icon/cutepet/icon_mengchong_12.png",
		{
			"3",
			"需要3回合内击败敌阵"
		},
		{
			"草",
			"己阵草属性精灵首次攻击前会永久变为小梦"
		},
		{
			"蓝色",
			"敌方水属性精灵必定暴击"
		}
	}
}
local t_divine_xing_jiang_clg_stage = {
	[359001] = {
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
		dataList[12]
	}
}

t_divine_xing_jiang_clg_stage.dataList = dataList

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

return t_divine_xing_jiang_clg_stage
