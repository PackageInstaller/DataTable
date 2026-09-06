-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_topup_lottery_rand.lua

module("logicconfig.config.t_topup_lottery_rand", package.seeall)

local title = {
	prizeId = 2,
	randPlanId = 1,
	weight = 3
}
local dataList = {
	{
		1,
		1,
		10
	},
	{
		1,
		2,
		100
	},
	{
		1,
		3,
		100
	},
	{
		1,
		4,
		100
	},
	{
		1,
		5,
		100
	},
	{
		1,
		6,
		100
	},
	{
		1,
		7,
		100
	},
	{
		1,
		8,
		100
	},
	{
		1,
		9,
		100
	},
	{
		2,
		1,
		100
	},
	{
		2,
		2,
		0
	},
	{
		2,
		3,
		0
	},
	{
		2,
		4,
		0
	},
	{
		2,
		5,
		0
	},
	{
		2,
		6,
		0
	},
	{
		2,
		7,
		0
	},
	{
		2,
		8,
		0
	},
	{
		2,
		9,
		0
	}
}
local t_topup_lottery_rand = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_topup_lottery_rand.dataList = dataList

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

return t_topup_lottery_rand
