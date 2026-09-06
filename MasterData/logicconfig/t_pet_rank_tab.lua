-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_rank_tab.lua

module("logicconfig.config.t_pet_rank_tab", package.seeall)

local title = {
	bNeedRedDot = 8,
	name = 2,
	rankType = 3,
	popTip = 5,
	tip = 4,
	rankShowRange = 7,
	rankRange = 6,
	behaviour = 9,
	tab = 1
}
local dataList = {
	{
		1,
		"全服总战力",
		1,
		"1.总战力包括精灵自身养成和公共养成\r\n2.根据战力由高到低排名，榜单显示前200名",
		"",
		10000,
		200,
		false,
		201016
	},
	{
		2,
		"本服总战力",
		2,
		"1.总战力包括精灵自身养成和公共养成\r\n2.根据战力由高到低排名，榜单显示前200名",
		"",
		5000,
		200,
		false,
		201017
	},
	{
		3,
		"全服精灵战力",
		3,
		"1.精灵战力指自身养成，不包括公共养成\r\n2.<color=#20b376>≥%s</color>战力可上榜，按上榜时间排名，<color=#20b376>前1000名</color>领<color=#20b376>精灵称号</color>",
		"1、精灵战力，仅精灵自身养成（等级、觉醒、潜能、装备、星神、灵纹），不含公共养成\r\n2、达到<color=#C54949>指定战力</color>才可验证上榜，按<color=#C54949>上榜时间</color>先后排名，战力变化不会影响排名\r\n3、排名奖励\r\n※全服榜奖励\r\n①第1：全服第一战力精灵称号\r\n②第2-10：全服前十战力精灵称号\r\n③第11-100：全服前100战力精灵称号\r\n④第101-500：全服前500战力精灵称号\r\n⑤第501-1000：全服前1000战力精灵称号\r\n※本服榜奖励\r\n①第1-300：专属精灵头像",
		10000,
		200,
		true,
		201018
	},
	{
		4,
		"本服精灵战力",
		4,
		"1.精灵战力指自身养成，不包括公共养成\r\n2.<color=#20b376>≥%s</color>战力可上榜，按上榜时间排名，<color=#20b376>前300名</color>领<color=#20b376>精灵头像</color>",
		"1、精灵战力，仅精灵自身养成（等级、觉醒、潜能、装备、星神、灵纹），不含公共养成\r\n2、达到<color=#C54949>指定战力</color>才可验证上榜，按<color=#C54949>上榜时间</color>先后排名，战力变化不会影响排名\r\n3、排名奖励\r\n※全服榜奖励\r\n①第1：全服第一战力精灵称号\r\n②第2-10：全服前十战力精灵称号\r\n③第11-100：全服前100战力精灵称号\r\n④第101-500：全服前500战力精灵称号\r\n⑤第501-1000：全服前1000战力精灵称号\r\n※本服榜奖励\r\n①第1-300：专属精灵头像",
		5000,
		200,
		true,
		201019
	},
	{
		5,
		"全服获得",
		5,
		"1.根据获得精灵时间先后排名\r\n2.<color=#20b376>前5000名</color>领<color=#20b376>精灵称号</color>",
		"1、根据获得时间先后排名\r\n2、排名奖励\r\n※全服榜\r\n①第1：全服第一获得精灵称号\r\n②第2-10：全服前十获得精灵称号\r\n③第11-100：全服前100获得精灵称号\r\n④第101-500：全服前500获得精灵称号\r\n⑤第501-1000：全服前1000获得精灵称号\r\n⑥第1001-5000：全服前5000获得精灵称号\r\n※本服榜\r\n①第1-300：专属精灵头像框",
		100000,
		200,
		true,
		201020
	},
	{
		6,
		"本服获得",
		6,
		"1.根据获得精灵时间先后排名\r\n2.<color=#20b376>前300名</color>领<color=#20b376>精灵头像框</color>",
		"1、根据获得时间先后排名\r\n2、排名奖励\r\n※全服榜\r\n①第1：全服第一获得精灵称号\r\n②第2-10：全服前十获得精灵称号\r\n③第11-100：全服前100获得精灵称号\r\n④第101-500：全服前500获得精灵称号\r\n⑤第501-1000：全服前1000获得精灵称号\r\n⑥第1001-5000：全服前5000获得精灵称号\r\n※本服榜\r\n①第1-300：专属精灵头像框",
		5000,
		200,
		true,
		201021
	}
}
local t_pet_rank_tab = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_pet_rank_tab.dataList = dataList

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

return t_pet_rank_tab
