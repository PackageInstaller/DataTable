-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pan_tao_feast_round.lua

module("logicconfig.config.t_pan_tao_feast_round", package.seeall)

local title = {
	gridElementPrize = 3,
	activityId = 1,
	roundId = 2
}
local dataList = {
	{
		622001,
		1,
		{
			23001,
			30002
		}
	},
	{
		622001,
		2,
		{
			22001
		}
	},
	{
		622001,
		3,
		{
			24001,
			21001
		}
	},
	{
		622001,
		4,
		{
			24001
		}
	},
	{
		622001,
		5,
		{
			23001,
			30001
		}
	},
	{
		622001,
		6,
		{
			21002
		}
	},
	{
		622001,
		7,
		{
			30001
		}
	},
	{
		622001,
		8,
		{
			7,
			7
		}
	},
	{
		622001,
		9,
		{
			30001,
			34
		}
	},
	{
		622001,
		10,
		{
			30001,
			102
		}
	},
	{
		622001,
		11,
		{
			33,
			33
		}
	},
	{
		622001,
		12,
		{
			30002,
			31
		}
	},
	{
		622001,
		13,
		{
			30002
		}
	},
	{
		622001,
		14,
		{
			30001
		}
	},
	{
		622001,
		15,
		{
			7,
			7
		}
	},
	{
		622001,
		16,
		{
			30001,
			34
		}
	},
	{
		622001,
		17,
		{
			15,
			32,
			30002
		}
	},
	{
		622001,
		18,
		{
			30001
		}
	},
	{
		622001,
		19,
		{
			30001,
			7,
			31
		}
	},
	{
		622001,
		20,
		{
			30002
		}
	}
}
local t_pan_tao_feast_round = {
	[622001] = {
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

t_pan_tao_feast_round.dataList = dataList

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

return t_pan_tao_feast_round
