-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hundred_raffle.lua

module("logicconfig.config.t_hundred_raffle", package.seeall)

local title = {
	showType = 2,
	id = 1,
	count = 3,
	des = 4
}
local dataList = {
	{
		1,
		1,
		70,
		"七日签到活动中，<color=#C54949>每日签到</color>可领取免费10连，共计70连召唤"
	},
	{
		2,
		1,
		68,
		"每日活跃达到<color=#C54949>120</color>可领取1张召唤券，每周活跃达到<color=#C54949>250</color>可领取10张召唤券，每周共计17连召唤，公测福利月共计68连召唤"
	},
	{
		3,
		1,
		40,
		"部分章节<color=#C54949>完美通关</color>，领取10连召唤，共计40连召唤以上"
	},
	{
		4,
		2,
		2000,
		"挑战其他玩家，<color=#C54949>提升竞技场排名</color>，领取赛季奖励、历史最高排名奖励，共计可获得2000以上的钻石"
	},
	{
		5,
		1,
		10,
		"明星战队计划中，<color=#C54949>七日内达成5万战斗力</color>，可领取10连召唤"
	},
	{
		6,
		2,
		3000,
		"英雄试炼玩法中，<color=#C54949>达成指定目标的伤害量</color>，收集钻石奖励，共计可获得3000以上，最多4000的钻石"
	}
}
local t_hundred_raffle = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_hundred_raffle.dataList = dataList

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

return t_hundred_raffle
