-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_rank_prize.lua

module("logicconfig.config.t_camp_battle_rank_prize", package.seeall)

local title = {
	rankSection = 3,
	prize = 5,
	rank = 4,
	id = 2,
	rankPrizePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"第1名",
		1,
		"104:2:10000#4:510022:10#2:64:1#14:110:1"
	},
	{
		1,
		2,
		"第2-10名",
		10,
		"104:2:5000#4:510022:8#2:65:1#14:111:1"
	},
	{
		1,
		3,
		"第11-100名",
		100,
		"104:2:2000#4:510022:6#2:66:1#14:112:1"
	},
	{
		1,
		4,
		"第101-500名",
		500,
		"104:2:1000#4:510022:5"
	},
	{
		1,
		5,
		"第501-1000名",
		1000,
		"104:2:600#4:510022:4"
	},
	{
		1,
		6,
		"第1001-2000名",
		2000,
		"104:2:400#4:510022:3"
	},
	{
		1,
		7,
		"第2001-5000名",
		5000,
		"104:2:200#4:510022:2"
	},
	{
		1,
		8,
		"第5001-10000名",
		10000,
		"104:2:100#4:510022:1"
	},
	{
		2,
		1,
		"第1名",
		1,
		"104:2:10000#4:510022:10#2:70:1#14:113:1"
	},
	{
		2,
		2,
		"第2-10名",
		10,
		"104:2:5000#4:510022:8#2:71:1#14:114:1"
	},
	{
		2,
		3,
		"第11-100名",
		100,
		"104:2:2000#4:510022:6#2:72:1#14:115:1"
	},
	{
		2,
		4,
		"第101-500名",
		500,
		"104:2:1000#4:510022:5"
	},
	{
		2,
		5,
		"第501-1000名",
		1000,
		"104:2:600#4:510022:4"
	},
	{
		2,
		6,
		"第1001-2000名",
		2000,
		"104:2:400#4:510022:3"
	},
	{
		2,
		7,
		"第2001-5000名",
		5000,
		"104:2:200#4:510022:2"
	},
	{
		2,
		8,
		"第5001-10000名",
		10000,
		"104:2:100#4:510022:1"
	}
}
local t_camp_battle_rank_prize = {
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
	}
}

t_camp_battle_rank_prize.dataList = dataList

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

return t_camp_battle_rank_prize
