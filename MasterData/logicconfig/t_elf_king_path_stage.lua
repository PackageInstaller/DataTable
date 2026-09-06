-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elf_king_path_stage.lua

module("logicconfig.config.t_elf_king_path_stage", package.seeall)

local title = {
	stageId = 1,
	prize = 3,
	PhaseId = 2,
	iconPath = 6,
	pos = 4,
	stageName = 5
}
local dataList = {
	{
		1,
		1,
		"8:1:600000",
		{
			0,
			98
		},
		"基础战斗",
		"board_jinglingwangzhilu_01"
	},
	{
		2,
		1,
		"100:17002:1:1#100:11002:1:1",
		{
			0,
			-82
		},
		"契约召唤",
		"board_jinglingwangzhilu_02"
	},
	{
		3,
		1,
		"4:510211:100",
		{
			0,
			98
		},
		"英雄上阵",
		"board_jinglingwangzhilu_03"
	},
	{
		4,
		1,
		"100:13005:1:1",
		{
			0,
			-82
		},
		"元素变换",
		"board_jinglingwangzhilu_04"
	},
	{
		5,
		1,
		"100:13013:1:1",
		{
			0,
			98
		},
		"通灵变身",
		"board_jinglingwangzhilu_05"
	},
	{
		6,
		1,
		"100:17010:1:1",
		{
			0,
			-82
		},
		"神曜昆仑",
		"board_jinglingwangzhilu_07"
	},
	{
		7,
		1,
		"8:1:600000",
		{
			0,
			98
		},
		"神曜无敌",
		"board_jinglingwangzhilu_09"
	},
	{
		8,
		1,
		"8:1:600000",
		{
			0,
			-82
		},
		"神曜伏妖",
		"board_jinglingwangzhilu_08"
	},
	{
		9,
		1,
		"4:90111:1",
		{
			0,
			98
		},
		"神曜圣骑",
		"board_jinglingwangzhilu_10"
	},
	{
		10,
		1,
		"100:10330:1:1",
		{
			0,
			-82
		},
		"王者试炼",
		"board_jinglingwangzhilu_06"
	}
}
local t_elf_king_path_stage = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_elf_king_path_stage.dataList = dataList

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

return t_elf_king_path_stage
