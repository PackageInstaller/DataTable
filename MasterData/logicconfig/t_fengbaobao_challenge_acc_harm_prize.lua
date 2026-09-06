-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fengbaobao_challenge_acc_harm_prize.lua

module("logicconfig.config.t_fengbaobao_challenge_acc_harm_prize", package.seeall)

local title = {
	prizeId = 2,
	accHarm = 3,
	planId = 1,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		200,
		"8:1:500000"
	},
	{
		1,
		2,
		500,
		"4:503:10"
	},
	{
		1,
		3,
		1000,
		"4:36:5"
	},
	{
		1,
		4,
		1500,
		"4:14:60"
	},
	{
		1,
		5,
		2000,
		"4:36:5"
	},
	{
		1,
		6,
		2500,
		"4:30003:5"
	},
	{
		1,
		7,
		3000,
		"4:36:5"
	},
	{
		1,
		8,
		3500,
		"4:120001:10"
	},
	{
		1,
		9,
		4000,
		"4:13:60"
	},
	{
		1,
		10,
		4500,
		"4:36:5"
	},
	{
		1,
		11,
		5000,
		"4:10:90"
	},
	{
		1,
		12,
		5500,
		"4:31:5"
	},
	{
		1,
		13,
		6000,
		"4:120001:10"
	},
	{
		1,
		14,
		6500,
		"4:11:90"
	},
	{
		1,
		15,
		7000,
		"4:503:10"
	},
	{
		1,
		16,
		7500,
		"4:120001:10"
	},
	{
		1,
		17,
		8000,
		"4:12:90"
	},
	{
		1,
		18,
		8500,
		"4:41004:1"
	},
	{
		1,
		19,
		9000,
		"4:120001:10"
	},
	{
		1,
		20,
		10000,
		"4:80381:1"
	}
}
local t_fengbaobao_challenge_acc_harm_prize = {
	{
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
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_fengbaobao_challenge_acc_harm_prize.dataList = dataList

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

return t_fengbaobao_challenge_acc_harm_prize
