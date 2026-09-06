-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_theater_content.lua

module("logicconfig.config.t_theater_content", package.seeall)

local title = {
	expression = 6,
	face = 5,
	action = 4,
	status = 2,
	id = 1,
	dialog = 7,
	rule = 3
}
local dataList = {
	{
		1,
		1,
		"ruleB",
		{
			"1#0"
		},
		{
			"1#0",
			"2#3"
		},
		{
			"4#0#3"
		},
		{
			"2#0#3"
		}
	},
	{
		1,
		1,
		"ruleA",
		{
			"1#3"
		},
		{
			"8#3"
		},
		[7] = {
			"1#3#3"
		}
	},
	{
		2,
		1,
		"ruleB",
		{
			"2#0"
		},
		{
			"2#0",
			"2#3"
		},
		{
			"2#0#3"
		},
		{
			"4#0#3"
		}
	},
	{
		2,
		1,
		"ruleA",
		{
			"2#3"
		},
		{
			"7#3"
		},
		{
			"3#3#3"
		},
		{
			"3#3#3"
		}
	},
	{
		3,
		1,
		"ruleB",
		{
			"1#0"
		},
		{
			"3#0",
			"2#3"
		},
		{
			"1#0#3"
		},
		{
			"6#0#3"
		}
	},
	{
		3,
		1,
		"ruleA",
		{
			"1#3"
		},
		{
			"6#3"
		},
		[7] = {
			"5#3#3"
		}
	},
	{
		4,
		1,
		"ruleB",
		{
			"2#0"
		},
		{
			"2#0",
			"2#3"
		},
		{
			"2#0#3"
		},
		{
			"8#0#3"
		}
	},
	{
		4,
		1,
		"ruleA",
		{
			"2#3"
		},
		{
			"9#3"
		},
		{
			"4#3#3"
		},
		{
			"7#3#3"
		}
	},
	{
		5,
		1,
		"ruleB",
		{
			"1#0"
		},
		{
			"1#0",
			"2#3"
		},
		{
			"4#0#3"
		},
		{
			"10#0#3"
		}
	},
	{
		5,
		1,
		"ruleA",
		{
			"1#3"
		},
		{
			"6#3"
		},
		{
			"1#3#3"
		},
		{
			"9#3#3"
		}
	},
	{
		6,
		1,
		"ruleB",
		{
			"2#0"
		},
		{
			"1#0",
			"2#3"
		},
		{
			"4#0#3"
		},
		{
			"12#0#3"
		}
	},
	{
		6,
		1,
		"ruleA",
		{
			"2#3"
		},
		{
			"7#3"
		},
		{
			"3#3#3"
		},
		{
			"11#3#3"
		}
	},
	{
		7,
		1,
		"ruleB",
		{
			"1#0"
		},
		{
			"5#0",
			"2#3"
		},
		{
			"2#0#3"
		},
		{
			"14#0#3"
		}
	},
	{
		7,
		1,
		"ruleA",
		{
			"1#3"
		},
		{
			"6#3"
		},
		{
			"3#3#3"
		},
		{
			"13#3#3"
		}
	},
	{
		8,
		1,
		"ruleB",
		{
			"2#0"
		},
		{
			"4#0",
			"2#3"
		},
		[7] = {
			"16#0#3"
		}
	},
	{
		8,
		1,
		"ruleA",
		{
			"2#3"
		},
		{
			"8#3"
		},
		{
			"2#3#3"
		},
		{
			"15#3#3"
		}
	},
	{
		9,
		1,
		"ruleB",
		{
			"1#0"
		},
		{
			"4#0",
			"2#3"
		},
		[7] = {
			"18#0#3"
		}
	},
	{
		9,
		1,
		"ruleA",
		{
			"1#3"
		},
		{
			"7#3"
		},
		{
			"2#3#3"
		},
		{
			"17#3#3"
		}
	},
	{
		10,
		1,
		"ruleB",
		{
			"2#0"
		},
		{
			"2#0",
			"2#3"
		},
		{
			"4#0#3"
		},
		{
			"20#0#3"
		}
	},
	{
		10,
		1,
		"ruleA",
		{
			"2#3"
		},
		{
			"8#3"
		},
		{
			"3#3#3"
		},
		{
			"19#3#3"
		}
	},
	{
		11,
		1,
		"ruleB",
		{
			"1#0"
		},
		{
			"5#0",
			"2#3"
		},
		{
			"2#0#3"
		},
		{
			"22#0#3"
		}
	},
	{
		11,
		1,
		"ruleA",
		{
			"1#3"
		},
		{
			"6#3"
		},
		[7] = {
			"21#3#3"
		}
	},
	{
		12,
		1,
		"ruleB",
		{
			"2#0"
		},
		{
			"3#0",
			"2#3"
		},
		{
			"3#0#3"
		},
		{
			"24#0#3"
		}
	},
	{
		12,
		1,
		"ruleA",
		{
			"2#3"
		},
		{
			"9#3"
		},
		{
			"4#3#3"
		},
		{
			"23#3#3"
		}
	},
	{
		13,
		1,
		"ruleB",
		{
			"1#0"
		},
		{
			"4#0",
			"2#3"
		},
		[7] = {
			"26#0#3"
		}
	},
	{
		13,
		1,
		"ruleA",
		{
			"1#3"
		},
		{
			"6#3"
		},
		[7] = {
			"25#3#3"
		}
	},
	{
		14,
		1,
		"ruleB",
		{
			"2#0"
		},
		{
			"5#0",
			"2#3"
		},
		{
			"3#0#3"
		},
		{
			"28#0#3"
		}
	},
	{
		14,
		1,
		"ruleA",
		{
			"2#3"
		},
		{
			"9#3"
		},
		{
			"4#3#3"
		},
		{
			"27#3#3"
		}
	}
}
local t_theater_content = {
	{
		{
			ruleB = dataList[1],
			ruleA = dataList[2]
		}
	},
	{
		{
			ruleB = dataList[3],
			ruleA = dataList[4]
		}
	},
	{
		{
			ruleB = dataList[5],
			ruleA = dataList[6]
		}
	},
	{
		{
			ruleB = dataList[7],
			ruleA = dataList[8]
		}
	},
	{
		{
			ruleB = dataList[9],
			ruleA = dataList[10]
		}
	},
	{
		{
			ruleB = dataList[11],
			ruleA = dataList[12]
		}
	},
	{
		{
			ruleB = dataList[13],
			ruleA = dataList[14]
		}
	},
	{
		{
			ruleB = dataList[15],
			ruleA = dataList[16]
		}
	},
	{
		{
			ruleB = dataList[17],
			ruleA = dataList[18]
		}
	},
	{
		{
			ruleB = dataList[19],
			ruleA = dataList[20]
		}
	},
	{
		{
			ruleB = dataList[21],
			ruleA = dataList[22]
		}
	},
	{
		{
			ruleB = dataList[23],
			ruleA = dataList[24]
		}
	},
	{
		{
			ruleB = dataList[25],
			ruleA = dataList[26]
		}
	},
	{
		{
			ruleB = dataList[27],
			ruleA = dataList[28]
		}
	}
}

t_theater_content.dataList = dataList

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

return t_theater_content
