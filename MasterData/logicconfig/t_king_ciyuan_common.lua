-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ciyuan_common.lua

module("logicconfig.config.t_king_ciyuan_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"A1",
		"func#43#86"
	},
	{
		"A2",
		"func#618#14011"
	},
	{
		"A3",
		"func#191#241#241001"
	},
	{
		"A4",
		"KingCiYuanChallenge_rule"
	},
	{
		"A5",
		"KingCiYuanExtChallenge_rule"
	},
	{
		"A6",
		"KingCiYuanBossChallenge_rule"
	},
	{
		"A7",
		"必定获得王者次元龙"
	},
	{
		"A8",
		"可获得王者次元币"
	},
	{
		"BuffStageNum",
		"3"
	},
	{
		"BuffStageResetCost",
		"105:6053:50"
	},
	{
		"A11",
		"104:2"
	},
	{
		"A12",
		"14011"
	},
	{
		"BossFreeCount",
		"3"
	},
	{
		"A14",
		"10:241001"
	},
	{
		"A15",
		"14011"
	},
	{
		"PetCardDesc",
		"通关次元挑战即可获得王者次元龙"
	}
}
local t_king_ciyuan_common = {
	A1 = dataList[1],
	A2 = dataList[2],
	A3 = dataList[3],
	A4 = dataList[4],
	A5 = dataList[5],
	A6 = dataList[6],
	A7 = dataList[7],
	A8 = dataList[8],
	BuffStageNum = dataList[9],
	BuffStageResetCost = dataList[10],
	A11 = dataList[11],
	A12 = dataList[12],
	BossFreeCount = dataList[13],
	A14 = dataList[14],
	A15 = dataList[15],
	PetCardDesc = dataList[16]
}

t_king_ciyuan_common.dataList = dataList

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

return t_king_ciyuan_common
