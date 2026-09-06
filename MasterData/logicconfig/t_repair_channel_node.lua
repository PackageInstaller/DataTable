-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_repair_channel_node.lua

module("logicconfig.config.t_repair_channel_node", package.seeall)

local title = {
	dispatchNum = 4,
	nodeId = 3,
	nodeName = 7,
	prize = 5,
	conditionIds = 6,
	pos = 8,
	activityId = 1,
	branchId = 2
}
local dataList = {
	{
		605001,
		1,
		1,
		2,
		"10:605001:100",
		{
			2
		},
		"战场1",
		{
			-103,
			-255
		}
	},
	{
		605001,
		1,
		2,
		2,
		"10:605001:100",
		{
			1,
			3
		},
		"战场2",
		{
			-210,
			-212
		}
	},
	{
		605001,
		1,
		3,
		3,
		"10:605001:100",
		{
			5
		},
		"战场3",
		{
			-320,
			-231
		}
	},
	{
		605001,
		1,
		4,
		2,
		"10:605001:100",
		{
			6
		},
		"战场4",
		{
			-372,
			-125
		}
	},
	{
		605001,
		1,
		5,
		2,
		"10:605001:100",
		{
			7,
			8
		},
		"战场5",
		{
			-308,
			-29
		}
	},
	{
		605001,
		1,
		6,
		1,
		"10:605001:100",
		{
			1,
			7
		},
		"战场6",
		{
			-212,
			32
		}
	},
	{
		605001,
		2,
		1,
		2,
		"10:605001:100",
		{
			9
		},
		"圣殿1",
		{
			83,
			-212
		}
	},
	{
		605001,
		2,
		2,
		2,
		"10:605001:100",
		{
			8,
			10
		},
		"圣殿2",
		{
			168,
			-142
		}
	},
	{
		605001,
		2,
		3,
		3,
		"10:605001:100",
		{
			11,
			12,
			13
		},
		"圣殿3",
		{
			274,
			-111
		}
	},
	{
		605001,
		2,
		4,
		2,
		"10:605001:100",
		{
			14
		},
		"圣殿4",
		{
			358,
			-40
		}
	},
	{
		605001,
		2,
		5,
		2,
		"10:605001:100",
		{
			7,
			15
		},
		"圣殿5",
		{
			302,
			48
		}
	},
	{
		605001,
		2,
		6,
		1,
		"10:605001:100",
		{
			7,
			10
		},
		"圣殿6",
		{
			206,
			103
		}
	}
}
local t_repair_channel_node = {
	[605001] = {
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
	}
}

t_repair_channel_node.dataList = dataList

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

return t_repair_channel_node
