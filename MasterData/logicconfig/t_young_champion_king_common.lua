-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_young_champion_king_common.lua

module("logicconfig.config.t_young_champion_king_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"QUALIFIER_RANK_SHOW_COUNT",
		"350"
	},
	{
		"QUALIFIER_RANK_REGISTER_COUNT",
		"500"
	},
	{
		"KNOCKOUT_BATTLE_START_TIME",
		"300"
	},
	{
		"KNOCKOUT_BATTLE_OVER_TIME",
		"240"
	}
}
local t_young_champion_king_common = {
	QUALIFIER_RANK_SHOW_COUNT = dataList[1],
	QUALIFIER_RANK_REGISTER_COUNT = dataList[2],
	KNOCKOUT_BATTLE_START_TIME = dataList[3],
	KNOCKOUT_BATTLE_OVER_TIME = dataList[4]
}

t_young_champion_king_common.dataList = dataList

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

return t_young_champion_king_common
