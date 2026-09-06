-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_event_bank.lua

module("logicconfig.config.t_beast_rich_man_event_bank", package.seeall)

local title = {
	id = 2,
	benfitWeight = 5,
	investment = 4,
	rate = 3,
	activityId = 1
}
local dataList = {
	{
		558001,
		1,
		0.5,
		{
			100,
			300,
			500
		},
		"80,20_50,50_60,30"
	},
	{
		558001,
		2,
		0.6,
		{
			300,
			1000,
			1500
		},
		"50,30_20,70"
	},
	{
		558001,
		3,
		0.7,
		{
			100,
			1000,
			10000
		},
		"100,10_50,30_10,60"
	},
	{
		558001,
		4,
		0.5,
		{
			300,
			500,
			1000
		},
		"80,20_50,50_60,30"
	},
	{
		558001,
		5,
		0.6,
		{
			500,
			1000,
			2000
		},
		"50,30_20,70"
	},
	{
		558001,
		6,
		0.7,
		{
			1000,
			10000,
			50000
		},
		"100,10_50,30_10,60"
	},
	{
		558001,
		7,
		0.5,
		{
			1000,
			3000,
			5000
		},
		"80,20_50,50_60,30"
	},
	{
		558001,
		8,
		0.6,
		{
			3000,
			5000,
			10000
		},
		"50,30_20,70"
	},
	{
		558001,
		9,
		0.7,
		{
			10000,
			100000,
			50000
		},
		"100,10_50,30_10,60"
	}
}
local t_beast_rich_man_event_bank = {
	[558001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_beast_rich_man_event_bank.dataList = dataList

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

return t_beast_rich_man_event_bank
