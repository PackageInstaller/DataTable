-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_score.lua

module("logicconfig.config.t_gift_box_score", package.seeall)

local title = {
	score = 3,
	superPrizeScorePlan = 1,
	time = 2
}
local dataList = {
	{
		1,
		1,
		100
	},
	{
		1,
		2,
		90
	},
	{
		1,
		3,
		80
	},
	{
		1,
		4,
		70
	},
	{
		1,
		5,
		60
	},
	{
		1,
		6,
		50
	},
	{
		2,
		1,
		25
	},
	{
		2,
		2,
		20
	},
	{
		2,
		3,
		15
	},
	{
		2,
		4,
		10
	},
	{
		2,
		5,
		5
	}
}
local t_gift_box_score = {
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
		dataList[11]
	}
}

t_gift_box_score.dataList = dataList

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

return t_gift_box_score
