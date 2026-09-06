-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_game_blocks.lua

module("logicconfig.config.t_three_matches_game_blocks", package.seeall)

local title = {
	score = 3,
	blockId = 1,
	icon = 2
}
local dataList = {
	{
		1,
		"icon_bs2",
		0
	},
	{
		2,
		"icon_bs3",
		0
	},
	{
		3,
		"icon_zhadan",
		0
	},
	{
		4,
		"icon_dangao_lanmei",
		0
	},
	{
		5,
		"icon_nssw_qingcai",
		0
	},
	{
		6,
		"icon_shandian",
		0
	},
	{
		7,
		"icon_shandian",
		0
	},
	{
		8,
		"icon_bsr",
		5
	},
	{
		9,
		"icon_bsy",
		5
	},
	{
		10,
		"icon_bsb",
		5
	},
	{
		11,
		"icon_bsg",
		5
	},
	{
		12,
		"icon_bs1",
		5
	},
	{
		16,
		"icon_bs11",
		0
	},
	{
		17,
		"icon_bs6",
		0
	},
	{
		18,
		"icon_bs7",
		0
	},
	{
		19,
		"icon_bs8",
		0
	},
	{
		20,
		"icon_bs9",
		0
	},
	{
		21,
		"icon_bs10",
		0
	},
	{
		22,
		"icon_bs12",
		0
	},
	{
		25,
		"",
		0
	}
}
local t_three_matches_game_blocks = {
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
	[16] = dataList[13],
	[17] = dataList[14],
	[18] = dataList[15],
	[19] = dataList[16],
	[20] = dataList[17],
	[21] = dataList[18],
	[22] = dataList[19],
	[25] = dataList[20]
}

t_three_matches_game_blocks.dataList = dataList

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

return t_three_matches_game_blocks
