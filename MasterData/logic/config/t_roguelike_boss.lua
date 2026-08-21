-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_boss.lua

module("logic.config.t_roguelike_boss", package.seeall)

local title = {
	failEffectId = 19,
	name = 2,
	roundDice = 12,
	features = 14,
	totalDice = 13,
	successEffectId = 18,
	successDesc = 20,
	aniTimes = 9,
	staticResScale = 6,
	passiveEffect = 15,
	model = 3,
	skillName = 17,
	failDesc = 21,
	staticRes = 5,
	description = 10,
	galleryId = 22,
	spine = 8,
	passiveDesc = 16,
	head = 4,
	staticResOffset = 7,
	id = 1,
	weight = 11
}
local dataList = {
	{
		10001,
		"异常的熊",
		"120020",
		"head_10001",
		"10001",
		nil,
		nil,
		"character3d/120022_xiong/roguelike/roguelike-roguelike_p.prefab",
		{
			2033,
			633,
			4500,
			1233,
			1400
		},
		"",
		100,
		5,
		20,
		{
			1,
			1,
			1,
			1,
			1,
			1
		},
		30000023,
		"适者生存：\r\n一轮结束后，当前的特征骰结果对应面，会随机转化成该面以外的五个面之一",
		"技能",
		{
			30001005,
			30001008
		},
		{
			30000038
		},
		"怪物发出一声声悲鸣，下一秒发疯似地横冲直撞。你们不敢贸然行动，只能眼睁睁看着它逃回森林。",
		"你被撞倒在树上，错不及防陷入了昏迷。哭声、尖叫、哀鸣声和爆破声在黑暗中交织成地狱般的乐章，但你已经无法再抓住不断流逝的意识。",
		0
	},
	{
		10002,
		"终焉的熊",
		"120020",
		"head_10001",
		"10001",
		nil,
		nil,
		"character3d/120022_xiong/roguelike/roguelike-roguelike_p.prefab",
		{
			2033,
			633,
			4500,
			1233,
			1400
		},
		"",
		100,
		7,
		50,
		{
			3,
			4,
			4,
			4,
			5,
			5
		},
		30000023,
		"适者生存：\r\n一轮结束后，当前的特征骰结果对应面，会随机转化成该面以外的五个面之一",
		"技能",
		{
			99000000
		},
		{
			30000038
		},
		"…………",
		"实验室、科学家、女孩、流浪汉……你努力睁开眼，却发现眼前的一切变得模糊不清。一段段记忆在你脑海中坍塌，一切重归寂静……",
		100
	},
	{
		100003,
		"暴走黑人",
		"120020",
		"head_10001",
		"10001",
		nil,
		nil,
		"character3d/120022_xiong/roguelike/roguelike-roguelike_p.prefab",
		{
			2033,
			633,
			4500,
			1233,
			1400
		},
		"",
		100,
		5,
		20,
		{
			1,
			1,
			1,
			1,
			1,
			1
		},
		30000107,
		"暴走黑人将不会受到血量伤害，但每回合结束时怪物血量-1、所有角色SAN-1",
		"技能",
		{
			30001005,
			30001008
		},
		{
			30000041
		},
		"怪物发出一声声悲鸣，下一秒发疯似地横冲直撞。你们不敢贸然行动，只能眼睁睁看着它逃回森林。",
		"你被撞倒在树上，错不及防陷入了昏迷。哭声、尖叫、哀鸣声和爆破声在黑暗中交织成地狱般的乐章，但你已经无法再抓住不断流逝的意识。",
		101
	},
	{
		100004,
		"狂走黑人",
		"120020",
		"head_10001",
		"10001",
		nil,
		nil,
		"character3d/120022_xiong/roguelike/roguelike-roguelike_p.prefab",
		{
			2033,
			633,
			4500,
			1233,
			1400
		},
		"",
		100,
		7,
		50,
		{
			3,
			4,
			4,
			4,
			5,
			5
		},
		30000108,
		"狂走黑人将可以被打败，其血量每减少1点、攻击力便上升1点",
		"技能",
		{
			99000000
		},
		{
			30000041
		},
		"…………",
		"实验室、科学家、女孩、流浪汉……你努力睁开眼，却发现眼前的一切变得模糊不清。一段段记忆在你脑海中坍塌，一切重归寂静……",
		101
	}
}
local t_roguelike_boss = {}

t_roguelike_boss.dataList = dataList

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
	t_roguelike_boss[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_boss
