-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vip_bonus.lua

module("logicconfig.config.t_vip_bonus", package.seeall)

local title = {
	payGoodsId = 3,
	openTime = 5,
	gotoStr = 6,
	bonusId = 1,
	vipLv = 2,
	prize = 4
}
local dataList = {
	{
		1,
		0,
		"",
		"4:36:5#4:42003:1#4:31:5#4:3011:5#8:8:1000#4:30001:30#4:2:30#8:1:100000",
		nil,
		""
	},
	{
		2,
		1,
		"",
		"14:4:1#4:36:5#4:31:10#4:40008:1#4:3019:5#4:30001:50#4:2:50#4:30006:20",
		nil,
		""
	},
	{
		3,
		2,
		"",
		"4:320:1#4:42004:1#4:36:10#4:31:10#8:8:3000#4:30001:100#4:2:100#4:30006:40",
		nil,
		""
	},
	{
		4,
		3,
		"",
		"4:90316:2#4:36:10#4:31:10#4:90137:5#4:510022:1#4:30002:50#4:3:50#4:30006:60",
		nil,
		""
	},
	{
		5,
		4,
		"",
		"13:3:1#4:42005:1#4:90212:1#4:90037:1#4:36:10#4:510022:2#4:901:5000#4:30006:80",
		nil,
		""
	},
	{
		6,
		5,
		"",
		"4:90089:1#4:70003:1#4:36:10#4:90145:1#4:510022:3#4:30002:100#4:3:100#4:30006:100",
		nil,
		""
	},
	{
		7,
		6,
		"",
		"17:1031301:-1:1#4:42006:1#4:90145:1#4:510126:3#4:112:10#4:30003:100#4:3:100#4:30006:120",
		nil,
		""
	},
	{
		8,
		7,
		"",
		"1:10002:-1:1#1:10001:-1:1#1:10003:-1:1#1:11002:-1:1#1:11001:-1:1#1:11003:-1:1#4:90236:1#4:90037:1#4:36:10#4:510126:5#4:30006:200#4:25:100#8:1:500000",
		nil,
		""
	},
	{
		9,
		8,
		"",
		"4:410009:1#4:90145:1#4:30006:200#4:510243:5#4:12101:5",
		nil,
		"ui#accconsumeview"
	},
	{
		10,
		9,
		"",
		"4:410001:1#8:25:1200#18:410:0:1#4:510243:5#4:12101:5",
		nil,
		"ui#accconsumeview"
	},
	{
		11,
		10,
		"",
		"4:1038:1#14:452:1#4:510257:1#4:70003:1#4:510243:10#4:12101:10",
		"2025-12-19T05:00:00",
		""
	}
}
local t_vip_bonus = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11]
}

t_vip_bonus.dataList = dataList

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

return t_vip_bonus
