-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shi_zu_dragon_clg_transform.lua

module("logicconfig.config.t_shi_zu_dragon_clg_transform", package.seeall)

local title = {
	score = 5,
	activityId = 1,
	phaseId = 2,
	id = 3,
	buffNum = 4
}
local dataList = {
	{
		500001,
		1,
		1,
		0,
		0
	},
	{
		500001,
		1,
		2,
		1,
		1
	},
	{
		500001,
		1,
		3,
		2,
		2
	},
	{
		500001,
		1,
		4,
		3,
		3
	},
	{
		500001,
		2,
		1,
		0,
		0
	},
	{
		500001,
		2,
		2,
		1,
		1
	},
	{
		500001,
		2,
		3,
		2,
		2
	},
	{
		500001,
		2,
		4,
		3,
		3
	},
	{
		500001,
		2,
		5,
		4,
		4
	},
	{
		500001,
		2,
		6,
		5,
		5
	},
	{
		500001,
		2,
		7,
		6,
		6
	},
	{
		500001,
		3,
		1,
		0,
		0
	},
	{
		500001,
		3,
		2,
		5,
		1
	},
	{
		500001,
		3,
		3,
		10,
		2
	},
	{
		500001,
		3,
		4,
		15,
		3
	},
	{
		500001,
		3,
		5,
		20,
		4
	},
	{
		500001,
		3,
		6,
		25,
		5
	},
	{
		500001,
		3,
		7,
		30,
		6
	}
}
local t_shi_zu_dragon_clg_transform = {
	[500001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11]
		},
		{
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_shi_zu_dragon_clg_transform.dataList = dataList

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

return t_shi_zu_dragon_clg_transform
