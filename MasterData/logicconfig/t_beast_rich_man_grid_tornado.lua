-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_grid_tornado.lua

module("logicconfig.config.t_beast_rich_man_grid_tornado", package.seeall)

local title = {
	id = 2,
	activityId = 1,
	step = 3
}
local dataList = {
	{
		558001,
		1,
		2
	},
	{
		558001,
		1,
		3
	},
	{
		558001,
		2,
		-4
	},
	{
		558001,
		2,
		2
	},
	{
		558001,
		2,
		3
	},
	{
		558001,
		2,
		-1
	},
	{
		558001,
		3,
		2
	},
	{
		558001,
		3,
		3
	},
	{
		558001,
		3,
		-5
	},
	{
		558001,
		4,
		2
	},
	{
		558001,
		4,
		4
	},
	{
		558001,
		5,
		5
	},
	{
		558001,
		5,
		-2
	},
	{
		558001,
		5,
		3
	},
	{
		558001,
		5,
		4
	}
}
local t_beast_rich_man_grid_tornado = {
	[558001] = {
		{
			[2] = dataList[1],
			[3] = dataList[2]
		},
		{
			[-4] = dataList[3],
			[2] = dataList[4],
			[3] = dataList[5],
			[-1] = dataList[6]
		},
		{
			[2] = dataList[7],
			[3] = dataList[8],
			[-5] = dataList[9]
		},
		{
			[2] = dataList[10],
			[4] = dataList[11]
		},
		{
			[5] = dataList[12],
			[-2] = dataList[13],
			[3] = dataList[14],
			[4] = dataList[15]
		}
	}
}

t_beast_rich_man_grid_tornado.dataList = dataList

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

return t_beast_rich_man_grid_tornado
