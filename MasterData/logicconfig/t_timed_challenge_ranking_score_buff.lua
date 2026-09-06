-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_ranking_score_buff.lua

module("logicconfig.config.t_timed_challenge_ranking_score_buff", package.seeall)

local title = {
	buffId = 1,
	buffDes = 2
}
local dataList = {
	{
		1,
		"每回合增加攻击"
	},
	{
		2,
		"60%基础命中率"
	},
	{
		3,
		"30%基础暴击率"
	},
	{
		4,
		"40%基础闪避率"
	},
	{
		101,
		"首次出手可额外出手一次"
	},
	{
		201,
		"伤害提升5%"
	},
	{
		202,
		"伤害提升10%"
	},
	{
		203,
		"伤害提升15%"
	},
	{
		301,
		"伤害减免+5%"
	},
	{
		302,
		"伤害减免+10%"
	},
	{
		303,
		"伤害减免+15%"
	},
	{
		401,
		"命中率+10%"
	},
	{
		402,
		"命中率+20%"
	},
	{
		403,
		"命中率+30%"
	},
	{
		501,
		"暴击率+10%"
	},
	{
		502,
		"暴击率+20%"
	},
	{
		503,
		"暴击率+30%"
	},
	{
		601,
		"己方攻击几率加异常状态"
	},
	{
		701,
		"秩序圣龙伤害-5%"
	},
	{
		702,
		"秩序圣龙伤害-10%"
	},
	{
		703,
		"秩序圣龙伤害-15%"
	},
	{
		801,
		"秩序圣龙受伤+5%"
	},
	{
		802,
		"秩序圣龙受伤+10%"
	},
	{
		803,
		"秩序圣龙受伤+15%"
	},
	{
		901,
		"秩序圣龙命中-5%"
	},
	{
		902,
		"秩序圣龙命中-10%"
	},
	{
		903,
		"秩序圣龙命中-15%"
	},
	{
		1001,
		"秩序圣龙暴击-8%"
	},
	{
		1002,
		"秩序圣龙暴击-16%"
	},
	{
		1003,
		"秩序圣龙暴击-20%"
	}
}
local t_timed_challenge_ranking_score_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	[101] = dataList[5],
	[201] = dataList[6],
	[202] = dataList[7],
	[203] = dataList[8],
	[301] = dataList[9],
	[302] = dataList[10],
	[303] = dataList[11],
	[401] = dataList[12],
	[402] = dataList[13],
	[403] = dataList[14],
	[501] = dataList[15],
	[502] = dataList[16],
	[503] = dataList[17],
	[601] = dataList[18],
	[701] = dataList[19],
	[702] = dataList[20],
	[703] = dataList[21],
	[801] = dataList[22],
	[802] = dataList[23],
	[803] = dataList[24],
	[901] = dataList[25],
	[902] = dataList[26],
	[903] = dataList[27],
	[1001] = dataList[28],
	[1002] = dataList[29],
	[1003] = dataList[30]
}

t_timed_challenge_ranking_score_buff.dataList = dataList

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

return t_timed_challenge_ranking_score_buff
