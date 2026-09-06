-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_bubble.lua

module("logicconfig.config.t_maintain_power_pillar_bubble", package.seeall)

local title = {
	scale = 3,
	bubbleId = 1,
	params = 4,
	bubbleType = 2,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		{
			120,
			100,
			-1
		},
		"",
		"救命鸭！救命鸭！"
	},
	{
		2,
		2,
		{
			120,
			100,
			-1
		},
		"10",
		"别打了！财宝我都给你！"
	},
	{
		3,
		2,
		{
			120,
			100,
			-1
		},
		"10",
		"为什么要一直打我？"
	},
	{
		4,
		1,
		{
			120,
			100,
			-1
		},
		"",
		"好无聊zzz"
	},
	{
		5,
		2,
		{
			120,
			100,
			-1
		},
		"15",
		"你干嘛诶呦"
	},
	{
		6,
		1,
		{
			120,
			100,
			-1
		},
		"",
		"哇，是你鸭！"
	},
	{
		7,
		1,
		{
			120,
			100,
			-1
		},
		"",
		"这块应该往上，诶呀不对不对"
	},
	{
		8,
		2,
		{
			120,
			100,
			-1
		},
		"15",
		"这样的意志…...我认可你了！"
	},
	{
		9,
		2,
		{
			120,
			100,
			-1
		},
		"1",
		"关卡已开启"
	},
	{
		10,
		1,
		{
			120,
			100,
			-1
		},
		"",
		"陪本大爷个玩游戏，宝贝就都送你了"
	},
	{
		11,
		2,
		{
			120,
			100,
			-1
		},
		"4",
		"桀桀，这里是我的地盘，就算你击败了我，也无法真正杀死我！"
	},
	{
		12,
		1,
		{
			145,
			130,
			-1
		},
		"",
		"你为何还在战场上游荡？"
	}
}
local t_maintain_power_pillar_bubble = {
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
	dataList[12]
}

t_maintain_power_pillar_bubble.dataList = dataList

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

return t_maintain_power_pillar_bubble
