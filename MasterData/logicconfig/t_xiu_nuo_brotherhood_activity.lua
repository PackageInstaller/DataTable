-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiu_nuo_brotherhood_activity.lua

module("logicconfig.config.t_xiu_nuo_brotherhood_activity", package.seeall)

local title = {
	raceId = 7,
	showBar = 5,
	item = 8,
	raceIntro = 6,
	ruleKey = 3,
	params = 11,
	openTag = 10,
	funcId = 9,
	initBuffLv = 4,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		208001,
		207001,
		"xiunuotiaozhanview_rule",
		1,
		{
			"104:2",
			"4:153"
		},
		"神与魔，明与暗，留存与湮灭，变化只在一瞬间",
		17006,
		"4:153",
		"func#726#15",
		1
	},
	{
		208002,
		207002,
		"MesserChallengemainview_rule",
		1,
		{
			"104:2",
			"4:167"
		},
		"快过来，要和我一起照顾龙崽吗？",
		14012,
		"4:167",
		"func#816#21",
		2
	},
	{
		208003,
		207003,
		"miraclearuishimainview_rule",
		1,
		{
			"104:2",
			"4:416"
		},
		"奇迹之力，生生不息吗？",
		13019,
		"4:416",
		"func#1088",
		3,
		{
			btnQuanEFanJump = "func#545#3",
			btnTehuiJump = "mibao#yingsenzhuxiang1"
		}
	},
	{
		208004,
		207004,
		"divineluoshiqimainview_rule",
		1,
		{
			"104:2",
			"4:275"
		},
		"",
		14034,
		"4:275",
		"ui#lottery",
		4,
		{
			btnRankJump = "func#618#14034",
			btnTehuiJump = "mibao#MibaoShop"
		}
	}
}
local t_xiu_nuo_brotherhood_activity = {
	[208001] = dataList[1],
	[208002] = dataList[2],
	[208003] = dataList[3],
	[208004] = dataList[4]
}

t_xiu_nuo_brotherhood_activity.dataList = dataList

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

return t_xiu_nuo_brotherhood_activity
