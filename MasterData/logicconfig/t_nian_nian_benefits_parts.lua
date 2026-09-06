-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_nian_nian_benefits_parts.lua

module("logicconfig.config.t_nian_nian_benefits_parts", package.seeall)

local title = {
	maxLevel = 4,
	name = 3,
	describe = 6,
	id = 1,
	partsId = 2,
	upgradeCost = 5
}
local dataList = {
	{
		1,
		1,
		"虚空熔炉",
		5,
		"10:77001:8",
		"念念在无尽的虚空中发现的熔炉，非常适合用来打造武器。\r\n\r\n可将废铁变为精矿，可使断刃重开锋芒。\r\n\r\n被念念压榨久了之后，熔炉有了自己的意识，不想每天工作，所以将自己变幻成了心心的轮廓，希望念念可以让它少干点活儿。\r\n（然而并没有什么用）"
	},
	{
		1,
		2,
		"千年寒铁",
		8,
		"10:77001:10",
		"念念在水下游乐城中，发现的千年寒铁。\r\n\r\n由于太过珍稀，奥奇世界中还没有人能了解其主要构成。\r\n\r\n念念正在想办法彻底了解其构造，使其可以发挥出应有的价值。"
	},
	{
		1,
		3,
		"鬼灵火精",
		10,
		"10:77001:12",
		"念念发现熔炉时，便寄宿在了熔炉里面的火精。\r\n\r\n开始时，火精十分虚弱，无法为熔炉提供能量。\r\n为了能使熔炉正常运转，念念给火精找了各种“补药”：火精十全大补丸、千年火晶等，终于让火精恢复了力量，可以使熔炉正常运转。\r\n\r\n但是平时火精为了保存体力，大多数时间都在沉睡。"
	},
	{
		1,
		4,
		"炼装古籍",
		12,
		"10:77001:15",
		"自从念念出生时起，这本炼装古籍便一直由念念随身携带着，没有人知道它的来历。\r\n\r\n古籍上的文字晦涩难懂，但是念念似乎天生拥有这方面的天赋，对这本书无师自通。\r\n\r\n开始时，念念打造装备的知识都是从这本书上学的，但是现在念念炼装技巧已经非常高超了。"
	},
	{
		1,
		5,
		"心念之锤",
		15,
		"10:77001:18",
		"这把锤子是心心和念念一起制作出来的，因为融合了二者的力量，锤子变得无坚不摧，用来打造装备最合适不过了。\r\n\r\n然而念念总是吐槽这把锤子很丑，想再锻造一次，换个造型，心心却很喜欢，觉得这是他们第一次动手造出来的成果，是最好看的。"
	}
}
local t_nian_nian_benefits_parts = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_nian_nian_benefits_parts.dataList = dataList

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

return t_nian_nian_benefits_parts
