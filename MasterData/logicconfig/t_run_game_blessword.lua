-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_run_game_blessword.lua

module("logicconfig.config.t_run_game_blessword", package.seeall)

local title = {
	Id = 2,
	planId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"升值加薪"
	},
	{
		1,
		2,
		"身体健康"
	},
	{
		1,
		3,
		"万事如意"
	},
	{
		1,
		4,
		"抽卡欧皇"
	},
	{
		1,
		5,
		"永不言败"
	},
	{
		1,
		6,
		"双蛋传奇"
	},
	{
		1,
		7,
		"亿万梦"
	},
	{
		1,
		8,
		"运气爆棚"
	},
	{
		2,
		1,
		"超神崛起"
	},
	{
		2,
		2,
		"寰宇之力"
	},
	{
		2,
		3,
		"魔攻加强"
	},
	{
		2,
		4,
		"免疫buff"
	},
	{
		2,
		5,
		"永不言败"
	},
	{
		2,
		6,
		"降低气势"
	},
	{
		2,
		7,
		"护盾增强"
	},
	{
		2,
		8,
		"对敌群攻"
	},
	{
		3,
		1,
		"升值加薪"
	},
	{
		3,
		2,
		"身体健康"
	},
	{
		3,
		3,
		"万事如意"
	},
	{
		3,
		4,
		"抽卡欧皇"
	},
	{
		3,
		5,
		"永不言败"
	},
	{
		3,
		6,
		"双蛋传奇"
	},
	{
		3,
		7,
		"亿万梦"
	},
	{
		3,
		8,
		"运气爆棚"
	},
	{
		4,
		1,
		"超神崛起"
	},
	{
		4,
		2,
		"寰宇之力"
	},
	{
		4,
		3,
		"闪避英雄"
	},
	{
		4,
		4,
		"辅助加气"
	},
	{
		4,
		5,
		"永不言败"
	},
	{
		4,
		6,
		"命中提高"
	},
	{
		4,
		7,
		"神曜归来"
	},
	{
		4,
		8,
		"降低通灵"
	}
}
local t_run_game_blessword = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	},
	{
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32]
	}
}

t_run_game_blessword.dataList = dataList

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

return t_run_game_blessword
