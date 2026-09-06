-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_rank.lua

module("logicconfig.config.t_lotus_battle_field_rank", package.seeall)

local title = {
	score = 4,
	rankTitle = 6,
	startRank = 2,
	rankPlanId = 1,
	spoilsNum = 5,
	endRank = 3
}
local dataList = {
	{
		1,
		1,
		1,
		2000,
		2,
		"board_hlzc_bt02"
	},
	{
		1,
		2,
		2,
		1500,
		1,
		"board_hlzc_bt03"
	},
	{
		1,
		3,
		4,
		1200,
		1,
		"board_hlzc_bt01"
	},
	{
		1,
		5,
		8,
		100,
		1,
		"board_hlzc_bt01"
	},
	{
		1,
		9,
		16,
		50,
		1,
		"board_hlzc_bt03"
	},
	{
		2,
		1,
		1,
		5000,
		4,
		"board_hlzc_bt02"
	},
	{
		2,
		2,
		2,
		4500,
		3,
		"board_hlzc_bt02"
	},
	{
		2,
		3,
		4,
		4000,
		2,
		"board_hlzc_bt03"
	},
	{
		2,
		5,
		8,
		2000,
		1,
		"board_hlzc_bt03"
	},
	{
		2,
		9,
		12,
		1000,
		1,
		"board_hlzc_bt01"
	},
	{
		2,
		13,
		24,
		100,
		1,
		"board_hlzc_bt01"
	},
	{
		2,
		25,
		48,
		50,
		1,
		"board_hlzc_bt01"
	}
}
local t_lotus_battle_field_rank = {
	{
		{
			dataList[1]
		},
		{
			[2] = dataList[2]
		},
		{
			[4] = dataList[3]
		},
		[5] = {
			[8] = dataList[4]
		},
		[9] = {
			[16] = dataList[5]
		}
	},
	{
		{
			dataList[6]
		},
		{
			[2] = dataList[7]
		},
		{
			[4] = dataList[8]
		},
		[5] = {
			[8] = dataList[9]
		},
		[9] = {
			[12] = dataList[10]
		},
		[13] = {
			[24] = dataList[11]
		},
		[25] = {
			[48] = dataList[12]
		}
	}
}

t_lotus_battle_field_rank.dataList = dataList

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

return t_lotus_battle_field_rank
