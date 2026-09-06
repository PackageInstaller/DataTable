-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_school_level_prize.lua

module("logicconfig.config.t_magic_school_level_prize", package.seeall)

local title = {
	finishBgName = 9,
	titlePos = 10,
	bgName = 8,
	progress = 4,
	campId = 2,
	title = 6,
	prize = 5,
	desc = 7,
	activityId = 1,
	level = 3
}
local dataList = {
	{
		514001,
		1,
		1,
		100,
		"10:17168:100",
		"隐灭学徒",
		"进入战斗时获得50气势",
		"board_mfsrz_09",
		"board_mfsrz_02",
		{
			0,
			17.3
		}
	},
	{
		514001,
		1,
		2,
		500,
		"10:17168:100",
		"隐灭学者",
		"暴击率+20%",
		"board_mfsrz_09",
		"board_mfsrz_03",
		{
			0,
			17.3
		}
	},
	{
		514001,
		1,
		3,
		1000,
		"10:17168:100",
		"隐灭术士",
		"攻击时，降低目标50%受疗效果",
		"board_mfsrz_09",
		"board_mfsrz_04",
		{
			0,
			17.3
		}
	},
	{
		514001,
		1,
		4,
		2000,
		"10:17168:100",
		"隐灭守护者",
		"暴击伤害+50%",
		"board_mfsrz_09",
		"board_mfsrz_05",
		{
			0,
			17.3
		}
	},
	{
		514001,
		1,
		5,
		3500,
		"10:17168:100",
		"隐灭先驱",
		"攻击时，使目标获得30%受伤加深",
		"board_mfsrz_09",
		"board_mfsrz_06",
		{
			0,
			17.3
		}
	},
	{
		514001,
		1,
		6,
		5000,
		"10:17168:100",
		"隐灭代行者",
		"攻击时，吸收目标30气势",
		"board_mfsrz_09",
		"board_mfsrz_07",
		{
			0,
			17.3
		}
	},
	{
		514001,
		1,
		7,
		6500,
		"13:467:1",
		"隐灭统领",
		"攻击力+80%",
		"board_mfsrz_09",
		"board_mfsrz_08",
		{
			0,
			17.3
		}
	},
	{
		514001,
		2,
		1,
		100,
		"10:17168:100",
		"永辉学徒",
		"进入战斗时获得最大生命值上限*15%的生命护盾",
		"board_mfsrz_09",
		"board_mfsrz_02",
		{
			0,
			17.3
		}
	},
	{
		514001,
		2,
		2,
		500,
		"10:17168:100",
		"永辉学者",
		"受击时，获得最大生命值上限*8%的生命护盾",
		"board_mfsrz_09",
		"board_mfsrz_03",
		{
			0,
			17.3
		}
	},
	{
		514001,
		2,
		3,
		1000,
		"10:17168:100",
		"永辉术士",
		"使用治疗技能时，为受疗单位附加治疗量10%的护盾",
		"board_mfsrz_09",
		"board_mfsrz_04",
		{
			0,
			17.3
		}
	},
	{
		514001,
		2,
		4,
		2000,
		"10:17168:100",
		"永辉守护者",
		"受击时，获得最大生命值上限*12%的生命护盾",
		"board_mfsrz_09",
		"board_mfsrz_05",
		{
			0,
			17.3
		}
	},
	{
		514001,
		2,
		5,
		3500,
		"10:17168:100",
		"永辉先驱",
		"使用治疗技能时，为受疗单位附加治疗量20%的护盾",
		"board_mfsrz_09",
		"board_mfsrz_06",
		{
			0,
			17.3
		}
	},
	{
		514001,
		2,
		6,
		5000,
		"10:17168:100",
		"永辉代行者",
		"受到的治疗效果+50%",
		"board_mfsrz_09",
		"board_mfsrz_07",
		{
			0,
			17.3
		}
	},
	{
		514001,
		2,
		7,
		6500,
		"13:468:1",
		"永辉统领",
		"最大生命上限+100%",
		"board_mfsrz_09",
		"board_mfsrz_08",
		{
			0,
			17.3
		}
	}
}
local t_magic_school_level_prize = {
	[514001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14]
		}
	}
}

t_magic_school_level_prize.dataList = dataList

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

return t_magic_school_level_prize
