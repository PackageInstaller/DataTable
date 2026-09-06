-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_sourcemon_appear.lua

module("logicconfig.config.t_scene_sourcemon_appear", package.seeall)

local title = {
	description = 2,
	monsterId = 3,
	planId = 1
}
local dataList = {
	{
		1,
		"物攻源兽",
		{
			20001
		}
	},
	{
		1,
		"魔攻源兽",
		{
			20002
		}
	},
	{
		1,
		"超攻源兽",
		{
			20003
		}
	},
	{
		1,
		"物防源兽",
		{
			20004
		}
	},
	{
		1,
		"魔防源兽",
		{
			20005
		}
	},
	{
		1,
		"超防源兽",
		{
			20006
		}
	},
	{
		1,
		"生命源兽",
		{
			20007
		}
	},
	{
		1,
		"速度源兽",
		{
			20008
		}
	},
	{
		2,
		"变异物攻源兽",
		{
			20009
		}
	},
	{
		2,
		"变异魔攻源兽",
		{
			20010
		}
	},
	{
		2,
		"变异超攻源兽",
		{
			20011
		}
	},
	{
		2,
		"变异物防源兽",
		{
			20012
		}
	},
	{
		2,
		"变异魔防源兽",
		{
			20013
		}
	},
	{
		2,
		"变异超防源兽",
		{
			20014
		}
	},
	{
		2,
		"变异生命源兽",
		{
			20015
		}
	},
	{
		2,
		"变异速度源兽",
		{
			20016
		}
	},
	{
		3,
		"物攻源兽",
		{
			20017
		}
	},
	{
		3,
		"魔攻源兽",
		{
			20018
		}
	},
	{
		3,
		"超攻源兽",
		{
			20019
		}
	},
	{
		3,
		"物防源兽",
		{
			20020
		}
	},
	{
		3,
		"魔防源兽",
		{
			20021
		}
	},
	{
		3,
		"超防源兽",
		{
			20022
		}
	},
	{
		3,
		"生命源兽",
		{
			20023
		}
	},
	{
		3,
		"速度源兽",
		{
			20024
		}
	},
	{
		3,
		"变异物攻源兽",
		{
			20009
		}
	},
	{
		3,
		"变异魔攻源兽",
		{
			20010
		}
	},
	{
		3,
		"变异超攻源兽",
		{
			20011
		}
	},
	{
		3,
		"变异物防源兽",
		{
			20012
		}
	},
	{
		3,
		"变异魔防源兽",
		{
			20013
		}
	},
	{
		3,
		"变异超防源兽",
		{
			20014
		}
	},
	{
		3,
		"变异生命源兽",
		{
			20015
		}
	},
	{
		3,
		"变异速度源兽",
		{
			20016
		}
	},
	{
		4,
		"物攻源兽",
		{
			20001
		}
	},
	{
		4,
		"物防源兽",
		{
			20004
		}
	},
	{
		4,
		"速度源兽",
		{
			20008
		}
	},
	{
		5,
		"魔攻源兽",
		{
			20002
		}
	},
	{
		5,
		"魔防源兽",
		{
			20005
		}
	},
	{
		5,
		"生命源兽",
		{
			20007
		}
	},
	{
		6,
		"超攻源兽",
		{
			20003
		}
	},
	{
		6,
		"超防源兽",
		{
			20006
		}
	}
}
local t_scene_sourcemon_appear = {
	{
		物攻源兽 = dataList[1],
		魔攻源兽 = dataList[2],
		超攻源兽 = dataList[3],
		物防源兽 = dataList[4],
		魔防源兽 = dataList[5],
		超防源兽 = dataList[6],
		生命源兽 = dataList[7],
		速度源兽 = dataList[8]
	},
	{
		变异物攻源兽 = dataList[9],
		变异魔攻源兽 = dataList[10],
		变异超攻源兽 = dataList[11],
		变异物防源兽 = dataList[12],
		变异魔防源兽 = dataList[13],
		变异超防源兽 = dataList[14],
		变异生命源兽 = dataList[15],
		变异速度源兽 = dataList[16]
	},
	{
		物攻源兽 = dataList[17],
		魔攻源兽 = dataList[18],
		超攻源兽 = dataList[19],
		物防源兽 = dataList[20],
		魔防源兽 = dataList[21],
		超防源兽 = dataList[22],
		生命源兽 = dataList[23],
		速度源兽 = dataList[24],
		变异物攻源兽 = dataList[25],
		变异魔攻源兽 = dataList[26],
		变异超攻源兽 = dataList[27],
		变异物防源兽 = dataList[28],
		变异魔防源兽 = dataList[29],
		变异超防源兽 = dataList[30],
		变异生命源兽 = dataList[31],
		变异速度源兽 = dataList[32]
	},
	{
		物攻源兽 = dataList[33],
		物防源兽 = dataList[34],
		速度源兽 = dataList[35]
	},
	{
		魔攻源兽 = dataList[36],
		魔防源兽 = dataList[37],
		生命源兽 = dataList[38]
	},
	{
		超攻源兽 = dataList[39],
		超防源兽 = dataList[40]
	}
}

t_scene_sourcemon_appear.dataList = dataList

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

return t_scene_sourcemon_appear
