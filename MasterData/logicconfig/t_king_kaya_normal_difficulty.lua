-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_kaya_normal_difficulty.lua

module("logicconfig.config.t_king_kaya_normal_difficulty", package.seeall)

local title = {
	score = 3,
	name = 4,
	difficulty = 2,
	pos = 5,
	activityId = 1
}
local dataList = {
	{
		371001,
		1,
		20,
		"简单",
		{
			-500,
			50
		}
	},
	{
		371001,
		2,
		25,
		"普通",
		{
			-250,
			-100
		}
	},
	{
		371001,
		3,
		30,
		"困难",
		{
			0,
			50
		}
	},
	{
		371001,
		4,
		35,
		"地狱",
		{
			250,
			-100
		}
	},
	{
		371001,
		5,
		40,
		"炼狱",
		{
			500,
			50
		}
	},
	{
		371002,
		1,
		20,
		"简单",
		{
			-500,
			50
		}
	},
	{
		371002,
		2,
		25,
		"普通",
		{
			-250,
			-100
		}
	},
	{
		371002,
		3,
		30,
		"困难",
		{
			0,
			50
		}
	},
	{
		371002,
		4,
		35,
		"地狱",
		{
			250,
			-100
		}
	},
	{
		371002,
		5,
		40,
		"炼狱",
		{
			500,
			50
		}
	}
}
local t_king_kaya_normal_difficulty = {
	[371001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[371002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_king_kaya_normal_difficulty.dataList = dataList

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

return t_king_kaya_normal_difficulty
