-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_global_prize.lua

module("logicconfig.config.t_domain_adventure_global_prize", package.seeall)

local title = {
	prizeId = 2,
	occupiedGridCount = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		402001,
		1,
		20,
		"10:402001:30"
	},
	{
		402001,
		2,
		40,
		"10:402001:30"
	},
	{
		402001,
		3,
		60,
		"10:402001:30"
	},
	{
		402001,
		4,
		80,
		"10:402001:30"
	},
	{
		402001,
		5,
		100,
		"10:402001:30"
	},
	{
		402001,
		6,
		120,
		"10:402001:30"
	},
	{
		402001,
		7,
		140,
		"10:402001:30"
	},
	{
		402001,
		8,
		160,
		"10:402001:30"
	},
	{
		402001,
		9,
		180,
		"10:402001:30"
	},
	{
		402001,
		10,
		200,
		"10:402001:30"
	}
}
local t_domain_adventure_global_prize = {
	[402001] = {
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

t_domain_adventure_global_prize.dataList = dataList

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

return t_domain_adventure_global_prize
