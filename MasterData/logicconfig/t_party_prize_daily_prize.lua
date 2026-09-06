-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_party_prize_daily_prize.lua

module("logicconfig.config.t_party_prize_daily_prize", package.seeall)

local title = {
	actStartTime = 4,
	id = 2,
	actEndTime = 5,
	actKey = 6,
	dailyPrizePlanId = 1,
	offlineTip = 7,
	dailyPrize = 3
}
local dataList = {
	{
		1,
		1,
		"8:1:5000",
		"2021-11-26T05:00:00",
		"2021-12-17T05:00:00",
		"func#420",
		"<color=#ffa429>11月26日-12月17日</color>开启签到活动，累计登录可领取100级圣翼·光天使！"
	},
	{
		1,
		2,
		"8:1:5000",
		"2021-11-26T05:00:00",
		"2021-12-17T05:00:00",
		"func#420",
		"<color=#ffa429>11月26日-12月17日</color>开启活动，召唤券神唤券拿不停，传说精灵免费兑换！"
	},
	{
		1,
		3,
		"8:1:5000",
		"2021-11-26T05:00:00",
		"2021-12-17T05:00:00",
		"func#420",
		"<color=#ffa429>11月26日-12月17日</color>开启活动，6只100级传说宠轻松拿！筑梦少年·诺亚额外兑满级、满觉醒！"
	},
	{
		1,
		4,
		"8:1:5000",
		"2021-11-26T05:00:00",
		"2021-12-17T05:00:00",
		"func#420",
		"<color=#ffa429>11月26日-12月17日</color>开启活动，七大特权福利限时开启！"
	},
	{
		1,
		5,
		"8:1:5000",
		"2021-11-26T05:00:00",
		"2021-12-17T05:00:00",
		"func#420",
		"<color=#ffa429>11月26日-12月17日</color>开启活动，海量钻石、金色星神、橙+1装备等轻松得！"
	},
	{
		1,
		6,
		"8:1:5000",
		"2021-11-26T05:00:00",
		"2021-12-17T05:00:00",
		"func#420",
		"<color=#ffa429>11月26日-12月17日</color>开启活动，传说精灵挑战限时回归！"
	},
	{
		1,
		7,
		"8:1:5000",
		"2021-11-26T05:00:00",
		"2021-12-17T05:00:00",
		"func#420",
		"<color=#ffa429>11月26日-12月17日</color>开启活动，冰晶梦萦·洛世琦皮肤轻松兑！"
	}
}
local t_party_prize_daily_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_party_prize_daily_prize.dataList = dataList

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

return t_party_prize_daily_prize
