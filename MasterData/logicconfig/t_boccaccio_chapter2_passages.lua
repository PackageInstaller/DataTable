-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter2_passages.lua

module("logicconfig.config.t_boccaccio_chapter2_passages", package.seeall)

local title = {
	sortId = 4,
	desc = 5,
	errorWordIdList = 6,
	storyId = 2,
	activityId = 1,
	passagesId = 3
}
local dataList = {
	{
		580001,
		1,
		1,
		3,
		"世界的尽头，有一座灰白色的石塔。塔里住着最后一位守塔人，他的使命便是%s塔顶那盏永不暗淡的明灯，为所有迷航的行船指引归途。日复一日，他擦拭灯罩，添加灯油，即使他知道，已经很久没有行船从这片荒芜的海域经过了。",
		{
			1
		}
	},
	{
		580001,
		1,
		2,
		2,
		"远方，名为“吞噬者”的风暴正在形成。它迅猛狂暴地摧毁一切，所过之处只剩一地狼藉。人们开始乘船逃亡，驶向未知的求生之地。路过灯塔时，他们劝守塔人一起逃生，他只是摇头，说：“灯不能灭，只有%s的光芒才能指引人们回到家乡。”",
		{
			2
		}
	},
	{
		580001,
		1,
		3,
		4,
		"风暴接连吞噬天空与海洋，最后来到石塔前。守塔人看着逼近的风暴，沉默地割破手腕，将滚烫的血液滴入灯芯。火焰猛地窜高，爆发出前所未有的%s，那是他生命燃尽的光。光穿透了风暴，在黑暗中撕开一道口子，为逃亡的船队指明了最后的航道。",
		{
			3
		}
	},
	{
		580001,
		1,
		4,
		1,
		"当一切归于沉寂，石塔消失了，明灯也消失了，但在逃亡者的记忆中，永远有一束光，来自世界的尽头，来自那个%s的守塔人。",
		{
			4
		}
	},
	{
		580001,
		2,
		1,
		4,
		"女孩曾是一名战士。战场%s被人斩断的那段时间里，她在绝望中被一位路过的小说家所救，来到了另一个全然陌生的世界。那里的人问她的来历，她只是摇头，不说自己的名字，不提那场战争，也不碰任何会让她想起鲜血与背叛的东西。",
		{
			5
		}
	},
	{
		580001,
		2,
		2,
		3,
		"直到有一天，救她的人递来一本未完结的小说。小说里写的是一个男孩的故事：战争爆发后，曾与女孩并肩作战的男孩成为了地下城的首领，为了护住转移至地下的更多族人的%s之所，男孩亲自下令封死了地上士兵的退路。",
		{
			6
		}
	},
	{
		580001,
		2,
		3,
		1,
		"没有结局的小说最后一节笔迹尚新，写尽了男孩的痛苦与悔恨，女孩也终于理解了男孩当年的选择——那或许不是怯懦，而是选择痛苦地%s。因为即便换作是她，即便是再来一次，无论他们当中的哪一个都还会作出同样的决定。",
		{
			7
		}
	},
	{
		580001,
		2,
		4,
		2,
		"女孩回到了那片被战争碾碎的土地，开始做男孩没能做完的事——种地、修路、建房子、和曾经的族人们一起重建家园。她不再是一名战士，而是一个带着两个人的生命继续前行的人。从此，这片土地上开出的每一朵花，都凝结着两个人的%s。",
		{
			8
		}
	}
}
local t_boccaccio_chapter2_passages = {
	[580001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		}
	}
}

t_boccaccio_chapter2_passages.dataList = dataList

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

return t_boccaccio_chapter2_passages
