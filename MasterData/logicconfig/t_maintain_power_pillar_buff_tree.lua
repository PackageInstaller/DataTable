-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_buff_tree.lua

module("logicconfig.config.t_maintain_power_pillar_buff_tree", package.seeall)

local title = {
	onlyId = 4,
	buffPlanId = 1,
	listId = 2,
	type = 5,
	index = 3
}
local dataList = {
	{
		1,
		1,
		2,
		1,
		1
	},
	{
		1,
		2,
		1,
		2,
		2
	},
	{
		1,
		2,
		2,
		3,
		3
	},
	{
		1,
		2,
		3,
		4,
		4
	},
	{
		1,
		3,
		2,
		5,
		5
	},
	{
		1,
		4,
		1,
		6,
		6
	},
	{
		1,
		4,
		2,
		7,
		7
	},
	{
		1,
		4,
		3,
		8,
		8
	},
	{
		2,
		1,
		2,
		1,
		1
	},
	{
		2,
		2,
		1,
		2,
		2
	},
	{
		2,
		2,
		2,
		3,
		3
	},
	{
		2,
		2,
		3,
		4,
		4
	},
	{
		2,
		3,
		2,
		5,
		5
	},
	{
		2,
		4,
		1,
		6,
		6
	},
	{
		2,
		4,
		2,
		7,
		7
	},
	{
		2,
		4,
		3,
		8,
		8
	},
	{
		3,
		1,
		2,
		1,
		1
	},
	{
		3,
		2,
		1,
		2,
		2
	},
	{
		3,
		2,
		2,
		3,
		3
	},
	{
		3,
		2,
		3,
		4,
		4
	},
	{
		3,
		3,
		2,
		5,
		5
	},
	{
		3,
		4,
		1,
		6,
		6
	},
	{
		3,
		4,
		2,
		7,
		7
	},
	{
		3,
		4,
		3,
		8,
		8
	},
	{
		4,
		1,
		2,
		1,
		1
	},
	{
		4,
		2,
		1,
		2,
		2
	},
	{
		4,
		2,
		2,
		3,
		3
	},
	{
		4,
		2,
		3,
		4,
		4
	},
	{
		4,
		3,
		2,
		5,
		5
	},
	{
		4,
		4,
		1,
		6,
		6
	},
	{
		4,
		4,
		2,
		7,
		7
	},
	{
		4,
		4,
		3,
		8,
		8
	}
}
local t_maintain_power_pillar_buff_tree = {
	{
		{
			[2] = dataList[1]
		},
		{
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			[2] = dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8]
		}
	},
	{
		{
			[2] = dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			[2] = dataList[13]
		},
		{
			dataList[14],
			dataList[15],
			dataList[16]
		}
	},
	{
		{
			[2] = dataList[17]
		},
		{
			dataList[18],
			dataList[19],
			dataList[20]
		},
		{
			[2] = dataList[21]
		},
		{
			dataList[22],
			dataList[23],
			dataList[24]
		}
	},
	{
		{
			[2] = dataList[25]
		},
		{
			dataList[26],
			dataList[27],
			dataList[28]
		},
		{
			[2] = dataList[29]
		},
		{
			dataList[30],
			dataList[31],
			dataList[32]
		}
	}
}

t_maintain_power_pillar_buff_tree.dataList = dataList

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

return t_maintain_power_pillar_buff_tree
