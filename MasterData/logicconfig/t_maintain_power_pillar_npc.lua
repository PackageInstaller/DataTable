-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_npc.lua

module("logicconfig.config.t_maintain_power_pillar_npc", package.seeall)

local title = {
	skinId = 3,
	npcId = 1,
	scale = 4,
	storyId = 2
}
local dataList = {
	{
		1,
		4660004,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		2,
		4660003,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		3,
		4660004,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		4,
		4660003,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		5,
		4660005,
		10196,
		{
			0,
			-50,
			0.18
		}
	},
	{
		6,
		4660004,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		7,
		4660004,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		8,
		4660005,
		10196,
		{
			0,
			-50,
			0.18
		}
	},
	{
		9,
		4660005,
		10196,
		{
			0,
			-50,
			0.18
		}
	},
	{
		10,
		4660005,
		10196,
		{
			0,
			-50,
			0.18
		}
	},
	{
		11,
		4660002,
		10167,
		{
			0,
			-60,
			0.14
		}
	},
	{
		401,
		4900001,
		18001,
		{
			0,
			-25,
			0.15
		}
	},
	{
		402,
		4900001,
		18001,
		{
			0,
			-25,
			0.15
		}
	},
	{
		403,
		4900001,
		18001,
		{
			0,
			-25,
			0.15
		}
	},
	{
		404,
		4770004,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		405,
		4770005,
		10196,
		{
			0,
			-50,
			0.18
		}
	},
	{
		406,
		4770003,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		407,
		4770003,
		10362,
		{
			0,
			-25,
			0.15
		}
	},
	{
		408,
		4770005,
		10196,
		{
			0,
			-50,
			0.18
		}
	},
	{
		409,
		4770005,
		10196,
		{
			0,
			-50,
			0.18
		}
	},
	{
		410,
		4770005,
		10196,
		{
			0,
			-50,
			0.18
		}
	},
	{
		411,
		4900001,
		18001,
		{
			0,
			-25,
			0.15
		}
	}
}
local t_maintain_power_pillar_npc = {
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
	[401] = dataList[12],
	[402] = dataList[13],
	[403] = dataList[14],
	[404] = dataList[15],
	[405] = dataList[16],
	[406] = dataList[17],
	[407] = dataList[18],
	[408] = dataList[19],
	[409] = dataList[20],
	[410] = dataList[21],
	[411] = dataList[22]
}

t_maintain_power_pillar_npc.dataList = dataList

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

return t_maintain_power_pillar_npc
