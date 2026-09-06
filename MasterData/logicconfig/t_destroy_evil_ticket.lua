-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_ticket.lua

module("logicconfig.config.t_destroy_evil_ticket", package.seeall)

local title = {
	itemKey = 3,
	activityId = 1,
	selectDifficult = 5,
	ticketId = 2,
	difficultStar = 4
}
local dataList = {
	{
		322001,
		1,
		"10:322002",
		{
			1,
			2,
			3
		},
		true
	},
	{
		322001,
		2,
		"10:322003",
		{
			4
		},
		false
	},
	{
		322002,
		1,
		"10:322006",
		{
			1,
			2,
			3
		},
		true
	},
	{
		322002,
		2,
		"10:322007",
		{
			6
		},
		false
	},
	{
		322003,
		1,
		"10:322010",
		{
			1,
			2,
			3
		},
		true
	},
	{
		322003,
		2,
		"10:322011",
		{
			6
		},
		false
	}
}
local t_destroy_evil_ticket = {
	[322001] = {
		dataList[1],
		dataList[2]
	},
	[322002] = {
		dataList[3],
		dataList[4]
	},
	[322003] = {
		dataList[5],
		dataList[6]
	}
}

t_destroy_evil_ticket.dataList = dataList

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

return t_destroy_evil_ticket
