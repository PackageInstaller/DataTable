-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_view_model.lua

module("logicconfig.config.t_cute_pet_view_model", package.seeall)

local title = {
	raceId = 1,
	default = 2
}
local dataList = {
	{
		101,
		{
			0,
			0,
			4
		}
	},
	{
		102,
		{
			0,
			0,
			5
		}
	},
	{
		103,
		{
			0,
			0,
			4
		}
	},
	{
		104,
		{
			0,
			0,
			3.5
		}
	},
	{
		201,
		{
			0,
			0,
			4
		}
	},
	{
		202,
		{
			0,
			0,
			4
		}
	},
	{
		203,
		{
			0,
			0,
			5
		}
	},
	{
		204,
		{
			0,
			0,
			4
		}
	},
	{
		301,
		{
			0,
			0,
			4
		}
	},
	{
		302,
		{
			0,
			0,
			4
		}
	},
	{
		401,
		{
			0,
			0,
			4.5
		}
	},
	{
		402,
		{
			0,
			0,
			4
		}
	},
	{
		105,
		{
			0,
			0,
			4
		}
	},
	{
		303,
		{
			0,
			0,
			4.5
		}
	},
	{
		205,
		{
			0,
			0,
			4.8
		}
	},
	{
		403,
		{
			0,
			0,
			4.5
		}
	},
	{
		206,
		{
			0,
			0,
			4.5
		}
	},
	{
		106,
		{
			0,
			0,
			4.8
		}
	}
}
local t_cute_pet_view_model = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[201] = dataList[5],
	[202] = dataList[6],
	[203] = dataList[7],
	[204] = dataList[8],
	[301] = dataList[9],
	[302] = dataList[10],
	[401] = dataList[11],
	[402] = dataList[12],
	[105] = dataList[13],
	[303] = dataList[14],
	[205] = dataList[15],
	[403] = dataList[16],
	[206] = dataList[17],
	[106] = dataList[18]
}

t_cute_pet_view_model.dataList = dataList

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

return t_cute_pet_view_model
