-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hot_search_reply_npc.lua

module("logicconfig.config.t_hot_search_reply_npc", package.seeall)

local title = {
	context = 4,
	npcId = 2,
	skinId = 3,
	replyId = 1,
	afterSec = 5
}
local dataList = {
	{
		1,
		1,
		10138,
		"V我50钻，给你带路",
		2
	},
	{
		1,
		2,
		10139,
		"问到了能不能也给我发一份！",
		4
	},
	{
		1,
		3,
		10137,
		"[奥奇点评链接]星神界本地菜。",
		6
	},
	{
		2,
		1,
		13014,
		"原来是你，我还以为阿瑞又在偷吃",
		2
	},
	{
		2,
		2,
		13021,
		"那我问你，有带走垃圾吗（恼）",
		4
	},
	{
		2,
		3,
		13016,
		"白收拾了，我以为是主人吃的。",
		6
	},
	{
		3,
		1,
		10138,
		"哎哟喂，地道！",
		2
	},
	{
		3,
		2,
		10140,
		"我懂……我也吃到过。",
		4
	},
	{
		3,
		3,
		10141,
		"奶龙，你的嘴巴怎么亮亮的？",
		6
	},
	{
		4,
		1,
		1102602,
		"有没有可能，人家只有一招能出",
		2
	},
	{
		4,
		2,
		11027,
		"震惊，砂之城雕像首胜就在今天",
		4
	},
	{
		4,
		3,
		12028,
		"石头雕像只能出石头，令人忍俊不禁",
		6
	},
	{
		5,
		1,
		11018,
		"你怎么知道我拿到了奶龙亲签",
		2
	},
	{
		5,
		2,
		11013,
		"我在蓝龙湾很想你",
		4
	},
	{
		5,
		3,
		11003,
		"震惊，蓝龙湾首次出现冰棍手艺人",
		6
	},
	{
		6,
		1,
		14002,
		"为什么我遇到的云朵不会说话？",
		2
	},
	{
		6,
		2,
		11009,
		"接星神界门票代拍",
		4
	},
	{
		6,
		3,
		14019,
		"云朵赐予我力量吧！",
		6
	},
	{
		7,
		1,
		1800102,
		"我还以为认错了，原来真是奶龙呀",
		2
	},
	{
		7,
		2,
		1701801,
		"老究烧烤，来就管饱",
		4
	},
	{
		7,
		3,
		10139,
		"糯米糍是啥，我也想试试",
		6
	}
}
local t_hot_search_reply_npc = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_hot_search_reply_npc.dataList = dataList

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

return t_hot_search_reply_npc
