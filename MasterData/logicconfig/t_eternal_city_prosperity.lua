-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_city_prosperity.lua

module("logicconfig.config.t_eternal_city_prosperity", package.seeall)

local title = {
	reward = 3,
	maxStoreRewardTime = 4,
	activityId = 1,
	prosperity = 2
}
local dataList = {
	{
		557001,
		0,
		"",
		480
	},
	{
		557001,
		20,
		"10:557001:11",
		480
	},
	{
		557001,
		120,
		"10:557001:20",
		480
	},
	{
		557001,
		1000,
		"10:557001:31",
		480
	},
	{
		557001,
		1500,
		"10:557001:45",
		480
	},
	{
		557001,
		2300,
		"10:557001:61",
		480
	},
	{
		557001,
		3000,
		"10:557001:80",
		480
	},
	{
		557001,
		4000,
		"10:557001:101",
		480
	},
	{
		557001,
		5500,
		"10:557001:125",
		480
	},
	{
		557001,
		8000,
		"10:557001:151",
		480
	},
	{
		557001,
		11100,
		"10:557001:180",
		480
	},
	{
		557001,
		16100,
		"10:557001:211",
		480
	}
}
local t_eternal_city_prosperity = {
	[557001] = {
		[0] = dataList[1],
		[20] = dataList[2],
		[120] = dataList[3],
		[1000] = dataList[4],
		[1500] = dataList[5],
		[2300] = dataList[6],
		[3000] = dataList[7],
		[4000] = dataList[8],
		[5500] = dataList[9],
		[8000] = dataList[10],
		[11100] = dataList[11],
		[16100] = dataList[12]
	}
}

t_eternal_city_prosperity.dataList = dataList

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

return t_eternal_city_prosperity
