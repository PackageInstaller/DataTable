-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_warrior_tower_params.lua

module("logicconfig.config.t_warrior_tower_params", package.seeall)

local title = {
	myBuff = 5,
	unlock = 3,
	desc = 2,
	hasOwnForm = 7,
	periods = 4,
	formParam = 8,
	enemyBuff = 6,
	towerId = 1
}
local dataList = {
	{
		1,
		"主塔",
		-1,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		0,
		0,
		false,
		""
	},
	{
		2,
		"生命之塔",
		50,
		{
			1,
			5,
			7
		},
		0,
		0,
		true,
		"草"
	},
	{
		3,
		"智慧之塔",
		50,
		{
			2,
			3,
			7
		},
		0,
		0,
		true,
		"水"
	},
	{
		4,
		"力量之塔",
		50,
		{
			3,
			4,
			7
		},
		0,
		0,
		true,
		"火"
	},
	{
		5,
		"时间之塔",
		50,
		{
			4,
			6,
			7
		},
		0,
		0,
		true,
		"光"
	},
	{
		6,
		"是非之塔",
		50,
		{
			5,
			6,
			7
		},
		0,
		0,
		true,
		"暗"
	},
	{
		7,
		"时空之塔",
		50,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		0,
		0,
		true,
		"空"
	},
	{
		8,
		"创造之塔",
		50,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		0,
		0,
		true,
		"创"
	}
}
local t_warrior_tower_params = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_warrior_tower_params.dataList = dataList

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

return t_warrior_tower_params
