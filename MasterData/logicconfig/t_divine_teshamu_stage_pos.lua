-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_teshamu_stage_pos.lua

module("logicconfig.config.t_divine_teshamu_stage_pos", package.seeall)

local title = {
	activityId = 1,
	cellId = 3,
	floorId = 2,
	pos = 4
}
local dataList = {
	{
		504001,
		1,
		0,
		{
			-400,
			70
		}
	},
	{
		504001,
		1,
		1,
		{
			-200,
			70
		}
	},
	{
		504001,
		1,
		2,
		{
			-50,
			200
		}
	},
	{
		504001,
		1,
		3,
		{
			50,
			-50
		}
	},
	{
		504001,
		1,
		4,
		{
			150,
			200
		}
	},
	{
		504001,
		1,
		5,
		{
			300,
			70
		}
	},
	{
		504001,
		1,
		6,
		{
			500,
			70
		}
	},
	{
		504001,
		2,
		0,
		{
			-380,
			70
		}
	},
	{
		504001,
		2,
		1,
		{
			-180,
			70
		}
	},
	{
		504001,
		2,
		2,
		{
			-30,
			200
		}
	},
	{
		504001,
		2,
		3,
		{
			-30,
			-50
		}
	},
	{
		504001,
		2,
		4,
		{
			120,
			70
		}
	},
	{
		504001,
		2,
		5,
		{
			270,
			200
		}
	},
	{
		504001,
		2,
		6,
		{
			270,
			-50
		}
	},
	{
		504001,
		2,
		7,
		{
			470,
			70
		}
	},
	{
		504001,
		3,
		0,
		{
			-350,
			70
		}
	},
	{
		504001,
		3,
		1,
		{
			-150,
			70
		}
	},
	{
		504001,
		3,
		2,
		{
			50,
			200
		}
	},
	{
		504001,
		3,
		3,
		{
			50,
			-50
		}
	},
	{
		504001,
		3,
		4,
		{
			250,
			200
		}
	},
	{
		504001,
		3,
		5,
		{
			250,
			-50
		}
	},
	{
		504001,
		3,
		6,
		{
			450,
			80
		}
	}
}
local t_divine_teshamu_stage_pos = {
	[504001] = {
		{
			[0] = dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			[0] = dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			[0] = dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20],
			dataList[21],
			dataList[22]
		}
	}
}

t_divine_teshamu_stage_pos.dataList = dataList

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

return t_divine_teshamu_stage_pos
