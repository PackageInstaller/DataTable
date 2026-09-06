-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_of_radiant_gold_score.lua

module("logicconfig.config.t_king_of_radiant_gold_score", package.seeall)

local title = {
	score = 5,
	scorePlanId = 2,
	id = 3,
	activityId = 1,
	number = 4
}
local dataList = {
	{
		462001,
		1,
		1,
		1,
		0
	},
	{
		462001,
		1,
		2,
		5,
		0
	},
	{
		462001,
		1,
		3,
		10,
		0
	},
	{
		462001,
		2,
		1,
		1,
		0
	},
	{
		462001,
		2,
		2,
		3,
		0
	},
	{
		462001,
		2,
		3,
		5,
		0
	}
}
local t_king_of_radiant_gold_score = {
	[462001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_king_of_radiant_gold_score.dataList = dataList

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

return t_king_of_radiant_gold_score
