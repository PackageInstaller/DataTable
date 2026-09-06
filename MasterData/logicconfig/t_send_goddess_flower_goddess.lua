-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_send_goddess_flower_goddess.lua

module("logicconfig.config.t_send_goddess_flower_goddess", package.seeall)

local title = {
	txtBubByPrize = 5,
	goddessId = 2,
	pos = 6,
	goddessPlanId = 1,
	skineId = 3,
	scale = 7,
	txtBubByFlower = 4
}
local dataList = {
	{
		1,
		1,
		16006,
		"谢谢你，训练师，这些花又让我想起了女神节那天的美景",
		"辛苦了，训练师，这是给你的一些礼物，收下吧",
		{
			0,
			-650
		},
		{
			1.5,
			1.5
		}
	},
	{
		1,
		2,
		10097,
		"哦？虽然说我最爱的是红莲，但是这朵花也莫名戳中了我，你费心了",
		"收下这么多的花并不在我的计划之内，给你一些礼物聊表心意吧",
		{
			0,
			-700
		},
		{
			1.5,
			1.5
		}
	},
	{
		1,
		3,
		16005,
		"这个花朵看起来很柔软，要好好珍藏起来才行",
		"赠礼程序——执行！",
		{
			0,
			-600
		},
		{
			1.7,
			1.7
		}
	},
	{
		1,
		4,
		10147,
		"经历过那么多次时间旅行，这朵花是我收到过最特别的礼物",
		"给你~这可是我收藏的好东西！",
		{
			-65,
			-1000
		},
		{
			1.7,
			1.7
		}
	},
	{
		1,
		5,
		10167,
		"花朵？小蝴蝶们会喜欢的，潘多拉……也很喜欢，谢谢",
		"谢谢你，阿瑞说这是好东西，送给你做礼物吧",
		{
			35,
			-600
		},
		{
			1.8,
			1.8
		}
	},
	{
		1,
		6,
		1100101,
		"哇~真好看！不愧是你！",
		"嘿嘿~这是我和念念去玩的时候找到的宝贝！收下吧~",
		{
			-40,
			-630
		},
		{
			1.3,
			1.3
		}
	},
	{
		1,
		7,
		11003,
		"哎呀~这朵花的香气太迷人了，带着这朵花一起送信肯定会更开心的！",
		"以本记者游历遍世界的眼光来看，这些可都是好宝贝！快收下！",
		{
			-40,
			-800
		},
		{
			1.3,
			1.3
		}
	}
}
local t_send_goddess_flower_goddess = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_send_goddess_flower_goddess.dataList = dataList

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

return t_send_goddess_flower_goddess
