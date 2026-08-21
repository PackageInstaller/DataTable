-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_portrait.lua

module("logic.config.t_item_portrait", package.seeall)

local title = {
	desc = 8,
	quality = 5,
	useDesc = 12,
	type = 3,
	getWays = 11,
	unlockdesc = 9,
	name = 2,
	repeatItem = 6,
	subType = 4,
	isShowBag = 10,
	id = 1,
	icon = 7
}
local dataList = {
	{
		2301001,
		"自省者",
		23,
		1,
		2,
		"{1001001:1,1001002:1}",
		"2301001",
		"堡垒构筑于幻觉之上，建造者也是拆除它的人",
		"无特殊获取途径",
		0,
		"",
		""
	},
	{
		2301002,
		"守正者",
		23,
		1,
		2,
		"{1001001:1,1001002:1}",
		"2301002",
		"秩序，你将全心仰赖它",
		"无特殊获取途径",
		0,
		"",
		""
	},
	{
		2301003,
		"谋略者",
		23,
		1,
		4,
		"{1001001:1,1001002:1}",
		"2301003",
		"游走与规则之间的狩猎者",
		"无特殊获取途径",
		0,
		"",
		""
	},
	{
		2301004,
		"亲和者",
		23,
		1,
		4,
		"{1001001:1,1001002:1}",
		"2301004",
		"那温室是良善的人用叮咛、交握的双手和不计前嫌的拥抱建成的",
		"无特殊获取途径",
		0,
		"",
		""
	},
	{
		2301005,
		"观察者",
		23,
		1,
		4,
		"{1001001:1,1001002:1}",
		"2301005",
		"观察，记录，流逝……在一切改变之外",
		"无特殊获取途径",
		0,
		"",
		""
	},
	{
		2301006,
		"颠覆者",
		23,
		1,
		3,
		"{1001001:1,1001002:1}",
		"2301006",
		"倒悬的星河是夜晚的彩虹",
		"无特殊获取途径",
		0,
		"",
		""
	},
	{
		2301007,
		"体验者",
		23,
		1,
		4,
		"{1001001:1,1001002:1}",
		"2301007",
		"那些正义的诗篇由我之口传诵",
		"无特殊获取途径",
		0,
		"",
		""
	},
	{
		2301008,
		"混沌者",
		23,
		1,
		4,
		"{1001001:1,1001002:1}",
		"2301008",
		"深渊也被锁链控制，否则它为何无声无息",
		"无特殊获取途径",
		0,
		"",
		""
	},
	{
		2301009,
		"狂欢者",
		23,
		1,
		4,
		"{1001001:1,1001002:1}",
		"2301009",
		"就欢饮达旦吧，未被邀请的黎明不会到来",
		"无特殊获取途径",
		0,
		"",
		""
	}
}
local t_item_portrait = {}

t_item_portrait.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_item_portrait[v[1]] = v

	setmetatable(v, mt)
end

return t_item_portrait
