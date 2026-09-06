-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_ten_prize.lua

module("logicconfig.config.t_golden_ten_prize", package.seeall)

local title = {
	score = 3,
	prizeId = 2,
	inviteNeed = 5,
	followerPrize = 6,
	activityId = 1,
	leaderPrize = 4
}
local dataList = {
	{
		259001,
		1,
		70,
		"4:90111:1#4:147:1#4:3016:10#4:90062:120",
		0,
		"4:510160:1#4:109:1#4:3016:10#4:90062:120"
	},
	{
		259001,
		2,
		140,
		"7:132094:0:1#18:403:1#4:3016:10#4:90062:120",
		0,
		"4:90113:1#4:602:1#4:3016:10#4:90062:120"
	},
	{
		259001,
		3,
		210,
		"7:133094:0:1#18:402:1#4:3016:10#4:90062:120",
		1,
		"4:90113:1#4:41004:1#4:3016:10#4:90062:120"
	},
	{
		259001,
		4,
		280,
		"7:131094:0:1#18:401:1#4:3016:10#4:90062:120",
		2,
		"4:90113:1#4:602:1#4:3016:10#4:90062:120"
	},
	{
		259001,
		5,
		350,
		"7:134094:0:1#18:410:1#4:3016:10#4:90062:120",
		3,
		"4:90113:1#4:41004:1#4:3016:10#4:90062:120"
	},
	{
		259002,
		1,
		70,
		"4:90111:1#4:147:1#4:3016:10#4:90062:120",
		0,
		"4:510160:1#4:109:1#4:3016:10#4:90062:120"
	},
	{
		259002,
		2,
		140,
		"7:121094:0:1#18:403:1#4:3016:10#4:90062:120",
		0,
		"4:90113:1#4:602:1#4:3016:10#4:90062:120"
	},
	{
		259002,
		3,
		210,
		"7:122094:0:1#18:402:1#4:3016:10#4:90062:120",
		0,
		"4:90113:1#4:41004:1#4:3016:10#4:90062:120"
	},
	{
		259002,
		4,
		280,
		"7:123094:0:1#18:401:1#4:3016:10#4:90062:120",
		0,
		"4:90113:1#4:602:1#4:3016:10#4:90062:120"
	},
	{
		259002,
		5,
		350,
		"7:124094:0:1#18:410:1#4:3016:10#4:90062:120",
		0,
		"4:90113:1#4:41004:1#4:3016:10#4:90062:120"
	}
}
local t_golden_ten_prize = {
	[259001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[259002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_golden_ten_prize.dataList = dataList

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

return t_golden_ten_prize
