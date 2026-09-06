-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_food.lua

module("logicconfig.config.t_seek_food", package.seeall)

local title = {
	redId = 5,
	name = 7,
	foodPic = 6,
	prize = 9,
	foodId = 2,
	creepsMasterId = 4,
	siteId = 3,
	activityId = 1,
	des = 8
}
local dataList = {
	{
		282001,
		1,
		1,
		101,
		"282001_1",
		"icon_aixindangao",
		"爱心蛋糕",
		"点缀着丰盛水果和奶油的蛋糕，据传是一名金发少女发明的，吃下去之后暖洋洋的，有着令人心情阳光的魔力。",
		"10:17076:1000"
	},
	{
		282001,
		2,
		1,
		102,
		"282001_2",
		"icon_meishi_02",
		"烈焰牛排",
		"火焰炙烤的牛排，丰富汁水，软嫩口感，迷人的美拉德反应让牛排散发着令人食指大动的气息。星神界的贵族们吃了都说好~",
		"10:17076:1000"
	},
	{
		282001,
		3,
		2,
		103,
		"282001_3",
		"icon_meishi_01",
		"嘟嘟火锅",
		"在终日海风呼啸的无尽之海，也有一种美食可以温暖你的胃和心——那就是嘟嘟火锅！浓郁汤底、鲜美食材，一种菜品，多重享受。",
		"10:17076:1000"
	},
	{
		282001,
		4,
		2,
		104,
		"282001_4",
		"icon_tl_sw03",
		"酸辣海鲜",
		"鲜虾白贝海带丝，鱿鱼螃蟹海蛎子。酸辣的汤底配以最鲜美的食材，无尽之海特色美食来袭，海的味道我知道~",
		"10:17076:1000"
	},
	{
		282001,
		5,
		3,
		105,
		"282001_5",
		"icon_tl_sw02",
		"清爽沙拉",
		"新鲜的蔬菜和水果，配以丰富的调料和酱汁，清新又健康。在终日炎热的砂之国，来一份清爽沙拉，给你带来快乐与满足。",
		"10:17076:1000"
	},
	{
		282001,
		6,
		3,
		106,
		"282001_6",
		"icon_nssw_jitui2",
		"鸡腿盛宴",
		"各个地方都有鸡，但只有砂之国的鸡才能做出这道鸡腿盛宴。炎热的天气、松软的沙土地让鸡肉更加紧致，特有的窑炉烹饪使鸡腿汁水充盈，美味尽在此刻~",
		"10:17076:1000"
	},
	{
		282001,
		7,
		4,
		107,
		"282001_7",
		"icon_gift18",
		"至尊披萨",
		"香脆口感、浓郁芝士、五彩斑斓的配料，甚至是上面的阿瑞肖像，都成就了至尊披萨的无穷魅力！搭一杯冰凉可口的气泡水，自得其乐，舒坦至极~",
		"10:17076:1000"
	},
	{
		282001,
		8,
		4,
		108,
		"282001_8",
		"icon_nssw_xuegao",
		"莓莓雪糕",
		"莓莓雪糕是味蕾的快乐源泉，也是消暑的天赐恩物！草莓和蔓越莓双莓搭配，制成果酱，酸甜可口，淋在的雪糕上，一口下去，轻松消除一天的疲惫~",
		"10:17076:1000"
	}
}
local t_seek_food = {
	[282001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_seek_food.dataList = dataList

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

return t_seek_food
