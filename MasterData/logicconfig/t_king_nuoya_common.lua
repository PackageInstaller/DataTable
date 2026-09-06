-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_nuoya_common.lua

module("logicconfig.config.t_king_nuoya_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CUR_CHALLENGE_ID",
		"56"
	},
	{
		"SHOW_RESOURCE",
		"4:157"
	},
	{
		"JUMP_SHOP_KEY",
		"func#191#191#191002"
	},
	{
		"JUMP_SHOP_MIBAO_KEY",
		"mibao#shengritehui1"
	},
	{
		"JUMP_PET_TOP_RANK",
		"func#618#17009"
	},
	{
		"JUMP_LOTTERY_KEY",
		"func#43#75"
	},
	{
		"PET_TOP_RANK_RED",
		"ID_PET_TOP_RANK_17009"
	},
	{
		"LANDING_ONCE_RED_LIST",
		"-303#-304#-305"
	},
	{
		"CUR_PET_RACEID",
		"17009"
	},
	{
		"CUR_PET_SKINID",
		"17009"
	},
	{
		"STAGE_TEXT",
		"今日可获得:%s/%s\n结算后获得:%s"
	}
}
local t_king_nuoya_common = {
	CUR_CHALLENGE_ID = dataList[1],
	SHOW_RESOURCE = dataList[2],
	JUMP_SHOP_KEY = dataList[3],
	JUMP_SHOP_MIBAO_KEY = dataList[4],
	JUMP_PET_TOP_RANK = dataList[5],
	JUMP_LOTTERY_KEY = dataList[6],
	PET_TOP_RANK_RED = dataList[7],
	LANDING_ONCE_RED_LIST = dataList[8],
	CUR_PET_RACEID = dataList[9],
	CUR_PET_SKINID = dataList[10],
	STAGE_TEXT = dataList[11]
}

t_king_nuoya_common.dataList = dataList

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

return t_king_nuoya_common
