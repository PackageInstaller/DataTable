-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_tower_rank_prize.lua

module("logicconfig.config.t_summon_master_tower_rank_prize", package.seeall)

local title = {
	prize = 3,
	seasonId = 1,
	rightTop = 2
}
local dataList = {
	{
		1,
		1,
		"104:2:1000#4:30006:100"
	},
	{
		1,
		10,
		"104:2:800#4:30006:60"
	},
	{
		1,
		50,
		"104:2:600#4:30006:40"
	},
	{
		1,
		100,
		"104:2:500#4:30006:30"
	},
	{
		1,
		200,
		"104:2:400#4:30006:20"
	},
	{
		1,
		500,
		"104:2:300#4:30006:20"
	},
	{
		1,
		1000,
		"104:2:200#4:30006:15"
	},
	{
		2,
		1,
		"104:2:1000#4:30006:100"
	},
	{
		2,
		10,
		"104:2:800#4:30006:60"
	},
	{
		2,
		50,
		"104:2:600#4:30006:40"
	},
	{
		2,
		100,
		"104:2:500#4:30006:30"
	},
	{
		2,
		200,
		"104:2:400#4:30006:20"
	},
	{
		2,
		500,
		"104:2:300#4:30006:20"
	},
	{
		2,
		1000,
		"104:2:200#4:30006:15"
	},
	{
		4,
		1,
		"104:2:1000#4:30006:100"
	},
	{
		4,
		10,
		"104:2:800#4:30006:60"
	},
	{
		4,
		50,
		"104:2:600#4:30006:40"
	},
	{
		4,
		100,
		"104:2:500#4:30006:30"
	},
	{
		4,
		200,
		"104:2:400#4:30006:20"
	},
	{
		4,
		500,
		"104:2:300#4:30006:20"
	},
	{
		4,
		1000,
		"104:2:200#4:30006:15"
	},
	{
		5,
		1,
		"104:2:1000#4:30006:100"
	},
	{
		5,
		10,
		"104:2:800#4:30006:60"
	},
	{
		5,
		50,
		"104:2:600#4:30006:40"
	},
	{
		5,
		100,
		"104:2:500#4:30006:30"
	},
	{
		5,
		200,
		"104:2:400#4:30006:20"
	},
	{
		5,
		500,
		"104:2:300#4:30006:20"
	},
	{
		5,
		1000,
		"104:2:200#4:30006:15"
	},
	{
		6,
		1,
		"104:2:1000#4:30006:100"
	},
	{
		6,
		10,
		"104:2:800#4:30006:60"
	},
	{
		6,
		50,
		"104:2:600#4:30006:40"
	},
	{
		6,
		100,
		"104:2:500#4:30006:30"
	},
	{
		6,
		200,
		"104:2:400#4:30006:20"
	},
	{
		6,
		500,
		"104:2:300#4:30006:20"
	},
	{
		6,
		1000,
		"104:2:200#4:30006:15"
	}
}
local t_summon_master_tower_rank_prize = {
	{
		dataList[1],
		[10] = dataList[2],
		[50] = dataList[3],
		[100] = dataList[4],
		[200] = dataList[5],
		[500] = dataList[6],
		[1000] = dataList[7]
	},
	{
		dataList[8],
		[10] = dataList[9],
		[50] = dataList[10],
		[100] = dataList[11],
		[200] = dataList[12],
		[500] = dataList[13],
		[1000] = dataList[14]
	},
	[4] = {
		dataList[15],
		[10] = dataList[16],
		[50] = dataList[17],
		[100] = dataList[18],
		[200] = dataList[19],
		[500] = dataList[20],
		[1000] = dataList[21]
	},
	[5] = {
		dataList[22],
		[10] = dataList[23],
		[50] = dataList[24],
		[100] = dataList[25],
		[200] = dataList[26],
		[500] = dataList[27],
		[1000] = dataList[28]
	},
	[6] = {
		dataList[29],
		[10] = dataList[30],
		[50] = dataList[31],
		[100] = dataList[32],
		[200] = dataList[33],
		[500] = dataList[34],
		[1000] = dataList[35]
	}
}

t_summon_master_tower_rank_prize.dataList = dataList

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

return t_summon_master_tower_rank_prize
