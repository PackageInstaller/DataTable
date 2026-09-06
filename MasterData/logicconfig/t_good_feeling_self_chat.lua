-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_good_feeling_self_chat.lua

module("logicconfig.config.t_good_feeling_self_chat", package.seeall)

local title = {
	chatId = 1,
	chatText = 2,
	playerLvInterval = 3,
	weight = 4
}
local dataList = {
	{
		1,
		"早上好",
		{
			0,
			200
		},
		10
	},
	{
		2,
		"大家在干嘛？",
		{
			0,
			200
		},
		10
	},
	{
		3,
		"麒麟到了蓝龙湾会变成什么？",
		{
			0,
			200
		},
		10
	},
	{
		4,
		"早安，太阳",
		{
			0,
			200
		},
		10
	},
	{
		5,
		"下雨了……突然有些忧郁。",
		{
			0,
			200
		},
		10
	},
	{
		6,
		"我想买艘浮空船",
		{
			0,
			200
		},
		10
	},
	{
		7,
		"昨晚失眠了……",
		{
			0,
			200
		},
		10
	},
	{
		8,
		"我觉得自己长得真的还蛮不错的诶",
		{
			0,
			200
		},
		10
	},
	{
		9,
		"你们听说了吗……",
		{
			0,
			200
		},
		10
	},
	{
		10,
		"如果所有精灵都给我100钻石……",
		{
			0,
			200
		},
		10
	},
	{
		11,
		"好久不见。",
		{
			0,
			200
		},
		10
	},
	{
		12,
		"在线等：如何消除六块腹肌？",
		{
			0,
			200
		},
		10
	},
	{
		13,
		"说什么话可以让对方立刻原谅你？",
		{
			0,
			200
		},
		10
	},
	{
		14,
		"上学时，看到最伤感的一句话是什么？",
		{
			0,
			200
		},
		10
	},
	{
		15,
		"失眠的时候你们都在想什么？",
		{
			0,
			200
		},
		10
	},
	{
		16,
		"如果和洛世琦约会……",
		{
			0,
			200
		},
		10
	},
	{
		17,
		"你们知道鸡哥和鸭哥吗？",
		{
			0,
			200
		},
		10
	},
	{
		18,
		"林林奇的秘密",
		{
			0,
			200
		},
		10
	}
}
local t_good_feeling_self_chat = {
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
	dataList[18]
}

t_good_feeling_self_chat.dataList = dataList

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

return t_good_feeling_self_chat
