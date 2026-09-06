-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_campaign_invite_score_prize.lua

module("logicconfig.config.t_campaign_invite_score_prize", package.seeall)

local title = {
	prizeId = 2,
	scoreReq = 3,
	planId = 1,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		20,
		"4:31:10#104:2:50#8:1:40000"
	},
	{
		1,
		2,
		60,
		"4:31:10#104:2:80#8:1:45000"
	},
	{
		1,
		3,
		120,
		"4:31:10#104:2:120#8:1:50000"
	},
	{
		1,
		4,
		220,
		"4:31:20#104:2:150#8:1:55000"
	},
	{
		1,
		5,
		250,
		"4:70003:1#104:2:200#8:1:60000"
	},
	{
		1,
		6,
		380,
		"1:300021:-1:1#104:2:300#8:1:100000"
	},
	{
		1,
		7,
		560,
		"18:403:1#104:2:400#8:1:150000"
	},
	{
		1,
		8,
		840,
		"4:90145:1#104:2:500#8:1:300000"
	},
	{
		2,
		1,
		20,
		"4:31:10#104:2:300#8:1:150000"
	},
	{
		2,
		2,
		60,
		"18:406:1#104:2:300#8:1:150000"
	},
	{
		2,
		3,
		120,
		"4:31:10#104:2:300#8:1:150000"
	},
	{
		2,
		4,
		180,
		"18:404:1#104:2:400#8:1:150000"
	},
	{
		2,
		5,
		240,
		"4:40008:3#104:2:300#8:1:150000"
	},
	{
		2,
		6,
		300,
		"18:401:1#104:2:300#8:1:150000"
	},
	{
		2,
		7,
		360,
		"4:40008:3#104:2:300#8:1:150000"
	},
	{
		2,
		8,
		420,
		"18:410:1#104:2:400#8:1:150000"
	},
	{
		3,
		1,
		85,
		"4:111:10#104:2:300#8:1:1000000"
	},
	{
		3,
		2,
		170,
		"4:112:10#104:2:400#8:1:1000000"
	},
	{
		3,
		3,
		250,
		"4:400002:100#104:2:500#8:1:1000000"
	},
	{
		3,
		4,
		340,
		"4:90037:1#104:2:800#8:1:1000000"
	},
	{
		3,
		5,
		420,
		"4:400004:50#104:2:1000#8:1:1000000"
	},
	{
		4,
		1,
		85,
		"4:30006:40#104:2:300#8:1:1000000"
	},
	{
		4,
		2,
		170,
		"4:30006:60#104:2:400#8:1:1000000"
	},
	{
		4,
		3,
		250,
		"4:400002:100#104:2:500#8:1:1000000"
	},
	{
		4,
		4,
		340,
		"4:90037:1#104:2:800#8:1:1000000"
	},
	{
		4,
		5,
		420,
		"4:400004:50#104:2:1000#8:1:1000000"
	}
}
local t_campaign_invite_score_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	},
	{
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26]
	}
}

t_campaign_invite_score_prize.dataList = dataList

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

return t_campaign_invite_score_prize
