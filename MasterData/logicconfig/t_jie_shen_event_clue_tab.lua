-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jie_shen_event_clue_tab.lua

module("logicconfig.config.t_jie_shen_event_clue_tab", package.seeall)

local title = {
	prize = 4,
	clueIds = 3,
	res = 7,
	tabId = 2,
	title = 5,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		397001,
		1,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8,
			9,
			10
		},
		"60:1:100#4:111:2",
		"元素火种",
		"元素火种由光、暗、水、火、土等元素组成，不断释放着元素之力，是世界构成的基石，也是精灵的力量来源，可为精灵补充力量、甚至延续生命，失去元素之力会变得虚弱甚至面临死亡。\r\n\r\n大部分精灵只能使用、吸收一种元素，奥奇则可以使用所有元素。\r\n\r\n精灵大陆的元素火种存在于五神柱内，五神柱会把元素之力扩散到整个精灵大陆。当精灵消散后，体内的元素之力会被吸收进神柱，形成良性循环。\r\n\r\n神域中的元素火种则被领神们持有，越靠近火种获得的力量越多。因不断损耗，火种的元素之力即将枯竭。",
		"ui/icon/items/icon_juqing_yshz.png"
	},
	{
		397001,
		2,
		{
			11,
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20,
			21,
			22
		},
		"60:1:100#4:111:2",
		"暗蚀",
		"暗蚀通常为黑红色，能化成固体、液体、气体，附着在生灵上。可使精灵短时突破身体极限、提高能力，但也会失去理性陷入暴虐状态。暗蚀会让使用者上瘾，吸入越多越无法戒断，并且有几率感染附近的精灵。\r\n\r\n暗蚀的来源为魔界的暗蚀之泉，实际由阿撒托斯释放，所有感染的精灵会逐渐被他吸取生命、受他控制。",
		"ui/icon/items/icon_zushendaibi_02.png"
	},
	{
		397001,
		3,
		{
			23,
			24,
			25,
			26,
			27,
			28,
			29,
			30,
			31
		},
		"60:1:100#4:111:2",
		"领神",
		"领神为神域中的联合统治者，共有十位，均拥有各自的领地与一份元素火种，持有的火种会为所管辖区域提供元素之力，由此吸引精灵们投靠。\r\n\r\n领神通过参与神殿举办的共议会，与其他领神共同协商神域事务。领神们表面和平，私下划分各派、争斗不断。\r\n\r\n成为领神需要获得一份元素火种、拥有自己的领地、获得神殿主祭的认可、与在共议会上获得三票赞成。因此领神之位可更迭，目前已有三代领神。\r\n\r\n初代领神为四祖神陨落后，元素火种争夺战的十位胜利者。二代领神为第一次领神更迭中，成功抢夺初代领神元素火种的胜利者。三代领神为获得二代领神的元素火种，并达成条件成为领神者。",
		"ui/icon/items/icon_lingshen.png"
	},
	{
		397001,
		4,
		{
			32,
			33,
			34,
			35,
			36,
			37,
			38,
			39,
			40
		},
		"8:1:200000#4:111:2",
		"红幕",
		"魔界中心有一道倒流的红色瀑布，名赤流瀑布，也是赤焰龙皇的沉睡之地。瀑布蔓延到天空，化为红色的流云包裹着魔界精灵的居住范围，被称为红幕。\r\n\r\n红幕由赤焰龙皇提供力量，红幕之内将受到赤焰龙皇的监视。\r\n\r\n红幕能抵挡外面时不时出现的黑色沙尘暴“影”。“影”连通着神域的混沌之地，被卷入的精灵基本都会从此消失，成为阿撒托斯的养分。",
		"ui/icon/items/icon_zushendaibi_03.png"
	}
}
local t_jie_shen_event_clue_tab = {
	[397001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_jie_shen_event_clue_tab.dataList = dataList

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

return t_jie_shen_event_clue_tab
