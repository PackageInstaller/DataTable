-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_convoy_reward.lua

module("logicconfig.config.t_convoy_reward", package.seeall)

local title = {
	id = 1,
	reward = 3,
	convoyNum = 2
}
local dataList = {
	{
		1,
		1,
		"8:5:10#8:1:1000"
	},
	{
		2,
		50,
		"8:5:20#8:1:2000"
	},
	{
		3,
		100,
		"8:5:30#8:1:3000"
	},
	{
		4,
		150,
		"8:5:40#8:1:4000"
	},
	{
		5,
		200,
		"8:5:50#8:1:5000"
	},
	{
		6,
		250,
		"8:5:60#8:1:6000"
	},
	{
		7,
		300,
		"8:5:70#8:1:7000"
	},
	{
		8,
		350,
		"8:5:80#8:1:8000"
	},
	{
		9,
		400,
		"8:5:90#8:1:9000"
	},
	{
		10,
		450,
		"8:5:100#8:1:10000"
	},
	{
		11,
		500,
		"8:5:110#8:1:11000"
	},
	{
		12,
		550,
		"8:5:120#8:1:12000"
	},
	{
		13,
		600,
		"8:5:130#8:1:13000"
	},
	{
		14,
		650,
		"8:5:140#8:1:14000"
	},
	{
		15,
		700,
		"8:5:150#8:1:15000"
	},
	{
		16,
		750,
		"8:5:160#8:1:16000"
	},
	{
		17,
		800,
		"8:5:170#8:1:17000"
	},
	{
		18,
		850,
		"8:5:180#8:1:18000"
	},
	{
		19,
		900,
		"8:5:190#8:1:19000"
	},
	{
		20,
		950,
		"8:5:200#8:1:20000"
	},
	{
		21,
		1000,
		"8:5:210#8:1:21000"
	}
}
local t_convoy_reward = {
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
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_convoy_reward.dataList = dataList

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

return t_convoy_reward
