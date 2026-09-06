-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tour_arena_game_client_common.lua

module("logicconfig.config.t_tour_arena_game_client_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"TOURARENAGAME_JUMP_KEY_1",
		"ui#tourarenagametotalrankview"
	},
	{
		1,
		"TOURARENAGAME_JUMP_KEY_2",
		"ui#tourarenagamerankview"
	},
	{
		1,
		"TOURARENAGAME_JUMP_RED_1",
		""
	},
	{
		1,
		"TOURARENAGAME_JUMP_RED_2",
		""
	},
	{
		1,
		"TOURARENAGAME_RULE_MAIN_KEY",
		"tourarenagame_rules"
	}
}
local t_tour_arena_game_client_common = {
	{
		TOURARENAGAME_JUMP_KEY_1 = dataList[1],
		TOURARENAGAME_JUMP_KEY_2 = dataList[2],
		TOURARENAGAME_JUMP_RED_1 = dataList[3],
		TOURARENAGAME_JUMP_RED_2 = dataList[4],
		TOURARENAGAME_RULE_MAIN_KEY = dataList[5]
	}
}

t_tour_arena_game_client_common.dataList = dataList

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

return t_tour_arena_game_client_common
