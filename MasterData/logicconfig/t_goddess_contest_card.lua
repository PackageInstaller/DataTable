-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_card.lua

module("logicconfig.config.t_goddess_contest_card", package.seeall)

local title = {
	cardId = 2,
	isRandomCard = 5,
	cardShowNum = 4,
	randomRange = 6,
	collectCardPlanId = 1,
	needVoteNum = 3
}
local dataList = {
	{
		1,
		1,
		150000,
		1,
		false
	},
	{
		1,
		2,
		250000,
		2,
		false
	},
	{
		1,
		3,
		350000,
		3,
		false
	},
	{
		1,
		4,
		500000,
		4,
		false
	},
	{
		1,
		5,
		600000,
		5,
		false
	},
	{
		1,
		6,
		700000,
		6,
		false
	},
	{
		1,
		7,
		800000,
		7,
		false
	},
	{
		1,
		8,
		950000,
		8,
		false
	},
	{
		1,
		9,
		1050000,
		9,
		false
	},
	{
		1,
		10,
		1050000,
		0,
		true,
		{
			5,
			9
		}
	}
}
local t_goddess_contest_card = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_goddess_contest_card.dataList = dataList

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

return t_goddess_contest_card
