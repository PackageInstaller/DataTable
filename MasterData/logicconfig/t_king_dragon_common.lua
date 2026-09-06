-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_dragon_common.lua

module("logicconfig.config.t_king_dragon_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CUR_CHALLENGE_ID",
		"48"
	},
	{
		"SHOW_RESOURCE",
		"4:150#4:151#204:2#105:1"
	},
	{
		"JUMP_SHOP_KEY",
		"func#191#191#191001"
	},
	{
		"JUMP_SHOP_MIBAO_KEY",
		"mibao#liandongtehui3"
	},
	{
		"JUMP_PET_TOP_RANK",
		"func#618#17003"
	},
	{
		"JUMP_LOTTERY_KEY",
		"func#676"
	},
	{
		"PET_TOP_RANK_RED",
		"ID_PET_TOP_RANK_17003"
	},
	{
		"LANDING_ONCE_RED_LIST",
		"-269#-270#-271"
	},
	{
		"CUR_PET_RACEID",
		"17003"
	},
	{
		"CUR_PET_SKINID",
		"17003"
	}
}
local t_king_dragon_common = {
	CUR_CHALLENGE_ID = dataList[1],
	SHOW_RESOURCE = dataList[2],
	JUMP_SHOP_KEY = dataList[3],
	JUMP_SHOP_MIBAO_KEY = dataList[4],
	JUMP_PET_TOP_RANK = dataList[5],
	JUMP_LOTTERY_KEY = dataList[6],
	PET_TOP_RANK_RED = dataList[7],
	LANDING_ONCE_RED_LIST = dataList[8],
	CUR_PET_RACEID = dataList[9],
	CUR_PET_SKINID = dataList[10]
}

t_king_dragon_common.dataList = dataList

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

return t_king_dragon_common
