-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_story.lua

module("logicconfig.config.t_beast_rich_man_story", package.seeall)

local title = {
	content = 4,
	type = 3,
	storyId = 2,
	playStoryId = 5,
	activityId = 1
}
local dataList = {
	{
		558001,
		1,
		2,
		"",
		4820062
	},
	{
		558001,
		2,
		2,
		"",
		4820063
	},
	{
		558001,
		3,
		2,
		"",
		4820064
	},
	{
		558001,
		4,
		2,
		"",
		4820065
	},
	{
		558001,
		5,
		2,
		"",
		4820066
	},
	{
		558001,
		6,
		2,
		"",
		4820067
	},
	{
		558001,
		7,
		2,
		"",
		4820068
	},
	{
		558001,
		8,
		1,
		"本女侠即将出山冒险，绝对不给师父丢脸，不过该去哪里好呢？",
		0
	},
	{
		558001,
		9,
		1,
		"青鸟仙子建议我将泣珠的本领进化为珍珠自产自销的产业链，怎么样，有兴趣投资吗？",
		0
	},
	{
		558001,
		10,
		1,
		"我仔细研究了你提出的“动物园”营业模式，如果我们青丘也对外展出的话，怎么宣传合适呢？",
		0
	},
	{
		558001,
		11,
		1,
		"喏，我师父特意寻来的两本武功秘籍，你我一人一本，学成之后下山历练一番，如何？",
		0
	},
	{
		558001,
		12,
		1,
		"偷偷告诉你，我最新学到一个赚钱的新法子，有没有兴趣投资一笔？不要告诉别人哦。",
		0
	},
	{
		558001,
		13,
		1,
		"往返人间仙界送信之余，本仙又开拓了一项名唤“代购”的新兼职，只是一开始要卖些什么东西好呢？",
		0
	},
	{
		558001,
		14,
		1,
		"有兴趣替本信使送几封信出去吗，越快越好，好处多多~",
		0
	},
	{
		558001,
		15,
		1,
		"昆仑山重建困难重重，你可愿助我一臂之力？事成之后，必有重谢。",
		0
	},
	{
		558001,
		16,
		1,
		"我学习了人间的团队管理模式，准备筹办一场昆仑山年会，来挑选一下你的专属座位吧。",
		0
	},
	{
		558001,
		17,
		1,
		"我略通些卜卦之术，可问财运、问桃花、问凶吉，有胆量试试吗？",
		0
	}
}
local t_beast_rich_man_story = {
	[558001] = {
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
		dataList[17]
	}
}

t_beast_rich_man_story.dataList = dataList

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

return t_beast_rich_man_story
