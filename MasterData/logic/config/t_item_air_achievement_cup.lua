-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_item_air_achievement_cup.lua

module("logic.config.t_item_air_achievement_cup", package.seeall)

local title = {
	quality = 6,
	priority = 8,
	name = 2,
	type = 4,
	desc = 9,
	cupGetWay = 10,
	repeatItem = 7,
	subType = 5,
	isShowBag = 11,
	id = 1,
	icon = 3
}
local dataList = {
	{
		3400001,
		"创造达人",
		"3400001",
		34,
		1,
		3,
		"{1100003:100}",
		99,
		"多创造一些关卡，为难别人，成就自己。",
		"创造等级达到5",
		0
	},
	{
		3400002,
		"创造专家",
		"3400002",
		34,
		1,
		4,
		"{1100003:100}",
		98,
		"无情的关卡制造机器罢了。",
		"创造等级达到10",
		0
	},
	{
		3400003,
		"创造大师",
		"3400003",
		34,
		1,
		5,
		"{1100003:100}",
		97,
		"适度创造有益身体健康，过度创造能够升级更快。",
		"创造等级达到20",
		0
	},
	{
		3400004,
		"大师工匠",
		"3400004",
		34,
		1,
		5,
		"{1100003:100}",
		96,
		"游玩次数这么多，这个关卡一定有它的过人之处吧。",
		"创建的单个关卡被游玩了100次",
		0
	},
	{
		3400005,
		"明星坊主",
		"3400005",
		34,
		1,
		5,
		"{1100003:100}",
		95,
		"夸赞单薄，还是用数据说话吧。",
		"创建的单个关卡被点赞了100次",
		0
	},
	{
		3400006,
		"关卡突破者",
		"3400006",
		34,
		1,
		4,
		"{1100003:100}",
		94,
		"要我说，你的征途绝不会止步于此。",
		"竞技场等级达到A级",
		0
	},
	{
		3400007,
		"关卡粉碎者",
		"3400007",
		34,
		1,
		5,
		"{1100003:100}",
		93,
		"最终成为了强大的少数派。",
		"竞技场等级达到S级",
		0
	},
	{
		3400008,
		"探索达人",
		"3400008",
		34,
		1,
		3,
		"{1100003:100}",
		92,
		"好强，是天生如此吗？",
		"无尽模式连胜10场",
		0
	},
	{
		3400009,
		"探索专家",
		"3400009",
		34,
		1,
		4,
		"{1100003:100}",
		91,
		"连胜这么多？工作人员，去查查这个人的后台数据！",
		"无尽模式连胜20场",
		0
	},
	{
		3400010,
		"探索大师",
		"3400010",
		34,
		1,
		5,
		"{1100003:100}",
		90,
		"我们将考虑是否需要调整该模式的难度……",
		"无尽模式连胜30场",
		0
	},
	{
		3400011,
		"资产大亨",
		"3400011",
		34,
		1,
		4,
		"{1100003:100}",
		89,
		"攒钱是一种良好的品质。",
		"建造基金累积获得5000",
		0
	},
	{
		3400012,
		"资产富翁",
		"3400012",
		34,
		1,
		5,
		"{1100003:100}",
		88,
		"看到余额就会产生安全感。",
		"建造基金累积获得20000",
		0
	}
}
local t_item_air_achievement_cup = {}

t_item_air_achievement_cup.dataList = dataList

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
	t_item_air_achievement_cup[v[1]] = v

	setmetatable(v, mt)
end

return t_item_air_achievement_cup
