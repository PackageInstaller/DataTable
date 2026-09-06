-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dark_king_dragon_clg_angle.lua

module("logicconfig.config.t_divine_dark_king_dragon_clg_angle", package.seeall)

local title = {
	angle = 5,
	phaseId = 2,
	id = 3,
	num = 4,
	activityId = 1
}
local dataList = {
	{
		526001,
		1,
		1,
		1,
		180
	},
	{
		526001,
		1,
		2,
		2,
		150
	},
	{
		526001,
		1,
		3,
		3,
		120
	},
	{
		526001,
		1,
		4,
		4,
		90
	},
	{
		526001,
		1,
		5,
		5,
		60
	},
	{
		526001,
		1,
		6,
		6,
		30
	},
	{
		526001,
		2,
		1,
		1,
		30
	},
	{
		526001,
		2,
		2,
		2,
		60
	},
	{
		526001,
		2,
		3,
		3,
		90
	},
	{
		526001,
		2,
		4,
		4,
		120
	},
	{
		526001,
		2,
		5,
		5,
		150
	},
	{
		526001,
		2,
		6,
		6,
		180
	},
	{
		526001,
		3,
		1,
		2,
		180
	},
	{
		526001,
		3,
		2,
		4,
		150
	},
	{
		526001,
		3,
		3,
		6,
		120
	},
	{
		526001,
		3,
		4,
		8,
		90
	},
	{
		526001,
		3,
		5,
		10,
		60
	},
	{
		526001,
		3,
		6,
		12,
		30
	},
	{
		526001,
		4,
		1,
		0,
		0
	}
}
local t_divine_dark_king_dragon_clg_angle = {
	[526001] = {
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
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		},
		{
			dataList[19]
		}
	}
}

t_divine_dark_king_dragon_clg_angle.dataList = dataList

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

return t_divine_dark_king_dragon_clg_angle
