-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mo_yan_challenge_plan.lua

module("logicconfig.config.t_mo_yan_challenge_plan", package.seeall)

local title = {
	ruleKey = 14,
	name = 4,
	planId = 1,
	resetChallengeCost = 11,
	systemPetPlan = 10,
	damageScorePlan = 13,
	buffPlan = 12,
	stagePlan = 3,
	desc = 17,
	dailyMaxScore = 9,
	viewName = 15,
	challengeType = 2,
	sweepTips = 16,
	buyTimesPlanId = 8,
	handler = 5,
	hasDailyTimesLimit = 6,
	freeDailyTimes = 7
}
local dataList = {
	{
		1,
		1,
		1001,
		"烈火红莲",
		101,
		false,
		0,
		0,
		120,
		1001,
		"",
		0,
		0,
		"liehuochallenge",
		"liehuohonglianiview",
		"你将开启扫荡直接通过本关\n按本关历史最高获得数计算\n<color=#ff0000>红莲花=%s朵</color>",
		"1、使用<color=#F5C701FF>系统精灵</color>按顺序破阵，关卡<color=#F5C701FF>次日5点</color>重置\n2、破阵胜利<color=#F5C701FF>保留</color>当前存活精灵血量\n3、本关<color=#F5C701FF>阵亡</color>的精灵不可上阵\n4、<color=#F5C701FF>击败3个阵</color>可分别获得<color=#F5C701FF>30/40/50红莲花</color>"
	},
	{
		1,
		2,
		2001,
		"火烈绽放",
		201,
		false,
		0,
		0,
		100,
		0,
		"105:189:50",
		1,
		0,
		"huolianchallenge",
		"honglianzhanfangview",
		"你将开启扫荡直接通过本关\n按本关历史最高获得数计算\n<color=#ff0001>红莲花=%s朵</color>",
		"1、使用<color=#F5C701FF>自己精灵</color>破阵，关卡<color=#F5C701FF>次日5点</color>重置\n2、每击败1个敌阵，剩余关卡敌阵精灵<color=#F5C701FF>增强</color>\n3、破阵胜利<color=#F5C701FF>保留</color>当前存活精灵血量\n4、本关<color=#F5C701FF>阵亡</color>的精灵不可上阵\n5、击败5个敌阵，通关可获得<color=#F5C701FF>100红莲花</color>"
	},
	{
		1,
		3,
		3001,
		"红莲女皇",
		301,
		true,
		2,
		1,
		320,
		0,
		"",
		0,
		1,
		"nvhuangchallenge",
		"hongliannvhuangview",
		"你将开启扫荡直接通过本关\n按本关历史最高获得数计算\n<color=#ff0002>红莲花=%s朵</color>",
		"1、每日对末炎<color=#F5C701FF>达成伤害</color>，可获得红莲花\n2、末炎血量次日5点重置\n3、<color=#F5C701FF>女性精灵</color>对末炎伤害提升100%"
	}
}
local t_mo_yan_challenge_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_mo_yan_challenge_plan.dataList = dataList

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

return t_mo_yan_challenge_plan
