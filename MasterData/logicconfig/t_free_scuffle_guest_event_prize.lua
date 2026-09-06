-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_guest_event_prize.lua

module("logicconfig.config.t_free_scuffle_guest_event_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 5,
	increaseCoin = 4,
	activityId = 1,
	hitCount = 3
}
local dataList = {
	{
		489001,
		1,
		1,
		"10000",
		"10:489002:1"
	},
	{
		489001,
		2,
		4,
		"20000",
		"10:489002:2"
	},
	{
		489001,
		3,
		8,
		"40000",
		"10:489002:3"
	},
	{
		489001,
		4,
		12,
		"60000",
		"10:489002:5"
	},
	{
		489001,
		5,
		16,
		"80000",
		"10:489002:8"
	},
	{
		489001,
		6,
		20,
		"100000",
		"10:489002:10"
	},
	{
		489002,
		1,
		1,
		"10000",
		"10:489004:1"
	},
	{
		489002,
		2,
		4,
		"20000",
		"10:489004:2"
	},
	{
		489002,
		3,
		8,
		"40000",
		"10:489004:3"
	},
	{
		489002,
		4,
		12,
		"60000",
		"10:489004:5"
	},
	{
		489002,
		5,
		16,
		"80000",
		"10:489004:8"
	},
	{
		489002,
		6,
		20,
		"100000",
		"10:489004:10"
	},
	{
		489003,
		1,
		1,
		"10000",
		"10:489006:1"
	},
	{
		489003,
		2,
		4,
		"20000",
		"10:489006:2"
	},
	{
		489003,
		3,
		8,
		"40000",
		"10:489006:3"
	},
	{
		489003,
		4,
		12,
		"60000",
		"10:489006:5"
	},
	{
		489003,
		5,
		16,
		"80000",
		"10:489006:8"
	},
	{
		489003,
		6,
		20,
		"100000",
		"10:489006:10"
	}
}
local t_free_scuffle_guest_event_prize = {
	[489001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[489002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[489003] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_free_scuffle_guest_event_prize.dataList = dataList

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

return t_free_scuffle_guest_event_prize
