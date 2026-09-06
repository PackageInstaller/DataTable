-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_red_pack_plan.lua

module("logicconfig.config.t_group_red_pack_plan", package.seeall)

local title = {
	dailyGainLimit = 7,
	redPackPlanId = 1,
	dailySendLimit = 6,
	type = 2,
	cost = 3,
	name = 10,
	sendItem = 4,
	imgPath = 11,
	redPackCount = 5,
	senderPrize = 8,
	duration = 12,
	addVoteValue = 9
}
local dataList = {
	{
		1,
		1,
		"105:6056:1000",
		"104:2:1000",
		100,
		5,
		8,
		"10:251001:20#10:251002:10",
		0,
		"精美红包",
		"board_nshongbao_06#board_nshongbao_05#board_nshongbao_12#board_nshongbao_06#board_nshongbao_17",
		86400
	},
	{
		1,
		2,
		"105:6057:3000",
		"104:2:3000",
		100,
		5,
		5,
		"10:251001:60#10:251002:30",
		0,
		"豪华红包",
		"board_nshongbao_07#board_nshongbao_05#board_nshongbao_13#board_nshongbao_07#board_nshongbao_17",
		86400
	},
	{
		1,
		3,
		"105:6058:5000",
		"104:2:5000",
		100,
		3,
		3,
		"10:251001:100#10:251002:50",
		0,
		"至尊红包",
		"board_nshongbao_08#board_nshongbao_05#board_nshongbao_14#board_nshongbao_08#board_nshongbao_17",
		86400
	},
	{
		2,
		1,
		"105:6056:1000",
		"104:2:1000",
		100,
		5,
		8,
		"10:251004:20#10:251005:10",
		0,
		"精美红包",
		"board_nshongbao_01#board_nshongbao_04#board_nshongbao_09#board_nshongbao_01#board_nshongbao_15",
		86400
	},
	{
		2,
		2,
		"105:6057:3000",
		"104:2:3000",
		100,
		5,
		5,
		"10:251004:60#10:251005:30",
		0,
		"豪华红包",
		"board_nshongbao_02#board_nshongbao_04#board_nshongbao_10#board_nshongbao_02#board_nshongbao_15",
		86400
	},
	{
		2,
		3,
		"105:6058:5000",
		"104:2:5000",
		100,
		3,
		3,
		"10:251004:100#10:251005:50",
		0,
		"至尊红包",
		"board_nshongbao_03#board_nshongbao_04#board_nshongbao_11#board_nshongbao_03#board_nshongbao_15",
		86400
	}
}
local t_group_red_pack_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_group_red_pack_plan.dataList = dataList

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

return t_group_red_pack_plan
