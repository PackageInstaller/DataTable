-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_king_challenge_params_define.lua

module("logicconfig.config.t_light_king_challenge_params_define", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"10"
	},
	{
		"PET_RANK_PRIZE",
		"14:19:1"
	},
	{
		"RACE_ID",
		"10100"
	},
	{
		"ITEM_ID",
		"4:96"
	},
	{
		"CONTRACT_IDS",
		"10325#10165"
	},
	{
		"GOODS_ID",
		"528"
	}
}
local t_light_king_challenge_params_define = {
	CHALLENGE_ID = dataList[1],
	PET_RANK_PRIZE = dataList[2],
	RACE_ID = dataList[3],
	ITEM_ID = dataList[4],
	CONTRACT_IDS = dataList[5],
	GOODS_ID = dataList[6]
}

t_light_king_challenge_params_define.dataList = dataList

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

return t_light_king_challenge_params_define
