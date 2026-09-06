-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_hall_hud_config.lua

module("logicconfig.config.t_star_hall_hud_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SHOW_ACTTIME",
		"6.27 5:00-7.25 5:00"
	},
	{
		"FINAL_ECHO_ACTID",
		"495001"
	},
	{
		"STAR_HALL_ACTID",
		"494001#494002"
	},
	{
		"EXCHANGE_JUMP_STR",
		"func#191#17#17160"
	},
	{
		"RULE_KEY",
		"star_hall_hud_rule"
	}
}
local t_star_hall_hud_config = {
	SHOW_ACTTIME = dataList[1],
	FINAL_ECHO_ACTID = dataList[2],
	STAR_HALL_ACTID = dataList[3],
	EXCHANGE_JUMP_STR = dataList[4],
	RULE_KEY = dataList[5]
}

t_star_hall_hud_config.dataList = dataList

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

return t_star_hall_hud_config
