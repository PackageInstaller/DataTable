-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_text.lua

module("logicconfig.config.t_goddess_text", package.seeall)

local title = {
	id = 2,
	raceId = 1,
	interval = 3,
	text = 4
}
local dataList = {
	{
		16005,
		1,
		{
			1,
			4
		},
		"您为什么一直看着我？"
	},
	{
		16005,
		2,
		{
			1,
			4
		},
		"我正处于待机模式，可随机激活。"
	},
	{
		16005,
		3,
		{
			1,
			4
		},
		"您的口头禅是什么呢？"
	},
	{
		16005,
		4,
		{
			1,
			4
		},
		"无限未来与087，为您服务。"
	},
	{
		16005,
		5,
		{
			1,
			4
		},
		"今天的天气很不错，您要出行去游玩吗？"
	},
	{
		16005,
		6,
		{
			5,
			8
		},
		"坐下来休息一下吧。"
	},
	{
		16005,
		7,
		{
			5,
			8
		},
		"今天的您，很不同，很耀眼。"
	},
	{
		16005,
		8,
		{
			5,
			8
		},
		"我没有‘害怕’这种情绪，请放心派发任务。"
	},
	{
		16005,
		9,
		{
			5,
			8
		},
		"谢谢您的关心，机体会自我修复，我很好。"
	},
	{
		16005,
		10,
		{
			5,
			8
		},
		"嗯？需要我陪伴您一些时光吗？"
	},
	{
		16005,
		11,
		{
			9,
			11
		},
		"你不会离开这里的，对吗？"
	},
	{
		16005,
		12,
		{
			9,
			11
		},
		"要小睡片刻吗？你的呼吸声让我好安心。"
	},
	{
		16005,
		13,
		{
			9,
			11
		},
		"你说的穿搭，是指机体的涂装吗？"
	},
	{
		16005,
		14,
		{
			9,
			11
		},
		"如果有机会，我一定会带你去未来旅行。"
	},
	{
		16005,
		15,
		{
			9,
			11
		},
		"你的手，是温暖的，原来这就是温暖…"
	}
}
local t_goddess_text = {
	[16005] = {
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
		dataList[15]
	}
}

t_goddess_text.dataList = dataList

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

return t_goddess_text
