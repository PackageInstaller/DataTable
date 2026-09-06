-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_emaki.lua

module("logicconfig.config.t_season_mode_pve_emaki", package.seeall)

local title = {
	strPlotContent = 5,
	paintName = 3,
	seasonId = 1,
	emaki = 2,
	paintTexture = 4
}
local dataList = {
	{
		1,
		1,
		"消逝之泪",
		"board_saijiwanfa_56",
		"魔偶的眼泪，只是通过魔法凝练而成的水元素。\r\n明明只是不值一提的东西，可当它落到指尖时，却散发出了惊人的力量……\r\n这股力量不在于强大——而在于能使我冰冷的肌肤，感受到了炙热的温度。\r\n“安心睡吧，我最忠诚的追随者。”\r\n当月亮落下时，你将以自由的姿态再次苏醒。"
	},
	{
		2,
		1,
		"狮王争霸",
		"board_s2_saijiwanfa_39",
		"大年三十，除夕已至，和修尔与诺亚忙活了一天，看着他们卖力舞狮，用精彩的表演赢得满堂喝彩，为大家带来欢乐的同时也为来年讨了个好彩头，回到家中已然是深夜。\r\n“嗯？谁背着我们准备了这么一大桌子饭菜，色香味俱全……肯定不是小雅！”\r\n诺亚趁着没人注意，悄悄捻起一个饺子吃掉。\r\n“哎？再怎么辛苦劳累也要等大家都上桌准备好啊，偷吃的坏蛋！修尔快来！修尔……你？”\r\n自打进了屋，修尔边看着眼前的发了呆，半晌才回过神来入座享用美食。\r\n“嗯……是熟悉的味道。”\r\n一滴眼泪无声划过修尔的面庞。\r\n“是谁呢？我为什么会这么熟悉……”"
	},
	{
		3,
		1,
		"迷雾骰局",
		"board_saijiwanfa3_03",
		"我听到了父神的意志--\r\n\"元素火种、混沌、魔界、分身、融合.....\"\r\n神域已经安稳太久,正需要一些好玩的东西。\r\n那我就让我来开启新的时代吧一一\r\n以最盛大的仪式,迎接父神的归来。"
	}
}
local t_season_mode_pve_emaki = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	}
}

t_season_mode_pve_emaki.dataList = dataList

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

return t_season_mode_pve_emaki
