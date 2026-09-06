-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fame_hall.lua

module("logicconfig.config.t_fame_hall", package.seeall)

local title = {
	param = 4,
	name = 6,
	viewname = 5,
	tabId = 1,
	typeId = 2,
	rootTabId = 3,
	txtTips = 7
}
local dataList = {
	{
		1,
		1,
		0,
		"",
		"famehalltabyoungchampionview",
		"少年竞技王",
		"每一届少年竞技王的冠军将永久记录在名人堂中"
	},
	{
		2,
		2,
		0,
		"",
		"famehalltabkingarenaview",
		"王者竞技场",
		"每一赛季王者竞技场中战皇次数榜第一的玩家将永久记录在名人堂中"
	},
	{
		3,
		3,
		0,
		"",
		"famehalltabpeaktournamentview",
		"巅峰赛",
		"每一赛季巅峰赛中王者赛的全服冠军将永久记录在名人堂中"
	},
	{
		4,
		4,
		0,
		"",
		"famehalltabrankraceview",
		"经典排位赛",
		"每一赛季经典排位赛的全服传说榜第一名将永久记录在名人堂中"
	},
	{
		5,
		5,
		0,
		"",
		"famehalltabrankraceview",
		"极限排位赛",
		"每一赛季极限排位赛的全服传说榜第一名将永久记录在名人堂中"
	},
	{
		6,
		6,
		0,
		"",
		"famehalltabtutorsystemview",
		"出师榜",
		"出师榜每月排行的第一名将永久记录在名人堂中"
	},
	{
		7,
		0,
		0,
		"",
		"",
		"节日竞技榜",
		""
	},
	{
		8,
		7,
		7,
		"2",
		"famehalltabtourareaview",
		"元旦竞技",
		"每一期元旦竞技积分总榜排行的第一名将永久记录在名人堂中"
	},
	{
		9,
		7,
		7,
		"3",
		"famehalltabtourareaview",
		"春节竞技",
		"每一期春节竞技积分总榜排行的第一名将永久记录在名人堂中"
	},
	{
		10,
		7,
		7,
		"4",
		"famehalltabtourareaview",
		"周年竞技",
		"每一期周年竞技积分总榜排行的第一名将永久记录在名人堂中"
	},
	{
		11,
		7,
		7,
		"5",
		"famehalltabtourareaview",
		"暑期竞技",
		"每一期暑期竞技积分总榜排行的第一名将永久记录在名人堂中"
	},
	{
		12,
		7,
		7,
		"6",
		"famehalltabtourareaview",
		"国庆竞技",
		"每一期国庆竞技积分总榜排行的第一名将永久记录在名人堂中"
	},
	{
		13,
		7,
		7,
		"1",
		"famehalltabtourareaview",
		"生日竞技",
		"每一期生日竞技积分总榜排行的第一名将永久记录在名人堂中"
	}
}
local t_fame_hall = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13]
}

t_fame_hall.dataList = dataList

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

return t_fame_hall
