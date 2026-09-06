-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_score.lua

module("logicconfig.config.t_chop_king_score", package.seeall)

local title = {
	score = 4,
	start = 3,
	planId = 2,
	activityId = 1
}
local dataList = {
	{
		470001,
		1,
		0,
		0
	},
	{
		470001,
		2,
		1,
		1
	},
	{
		470001,
		2,
		2,
		3
	},
	{
		470001,
		2,
		4,
		5
	},
	{
		470001,
		2,
		6,
		10
	},
	{
		470001,
		3,
		1,
		10
	},
	{
		470001,
		3,
		2,
		8
	},
	{
		470001,
		3,
		3,
		6
	},
	{
		470001,
		3,
		4,
		4
	},
	{
		470001,
		3,
		5,
		3
	},
	{
		470001,
		3,
		6,
		2
	},
	{
		470001,
		3,
		7,
		1
	}
}
local t_chop_king_score = {
	[470001] = {
		{
			[0] = dataList[1]
		},
		{
			dataList[2],
			dataList[3],
			[4] = dataList[4],
			[6] = dataList[5]
		},
		{
			dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_chop_king_score.dataList = dataList

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

return t_chop_king_score
