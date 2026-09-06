-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation_pos.lua

module("logicconfig.config.t_formation_pos", package.seeall)

local title = {
	pos = 3,
	camp = 1,
	posId = 2
}
local dataList = {
	{
		1,
		1,
		{
			-12,
			15.5,
			-14
		}
	},
	{
		1,
		2,
		{
			-12,
			13.1,
			-34
		}
	},
	{
		1,
		3,
		{
			-12,
			11.2,
			-54
		}
	},
	{
		1,
		4,
		{
			-25,
			15.5,
			-14
		}
	},
	{
		1,
		5,
		{
			-25,
			13.1,
			-34
		}
	},
	{
		1,
		6,
		{
			-25,
			11.2,
			-54
		}
	},
	{
		1,
		7,
		{
			-38,
			15.5,
			-14
		}
	},
	{
		1,
		8,
		{
			-38,
			13.1,
			-34
		}
	},
	{
		1,
		9,
		{
			-38,
			11.2,
			-54
		}
	},
	{
		2,
		1,
		{
			12,
			15.5,
			-14
		}
	},
	{
		2,
		2,
		{
			12,
			13.1,
			-34
		}
	},
	{
		2,
		3,
		{
			12,
			11.2,
			-54
		}
	},
	{
		2,
		4,
		{
			25,
			15.5,
			-14
		}
	},
	{
		2,
		5,
		{
			25,
			13.1,
			-34
		}
	},
	{
		2,
		6,
		{
			25,
			11.2,
			-54
		}
	},
	{
		2,
		7,
		{
			38,
			15.5,
			-14
		}
	},
	{
		2,
		8,
		{
			38,
			13.1,
			-34
		}
	},
	{
		2,
		9,
		{
			38,
			11.2,
			-54
		}
	}
}
local t_formation_pos = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_formation_pos.dataList = dataList

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

return t_formation_pos
