-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seek_food_common.lua

module("logicconfig.config.t_seek_food_common", package.seeall)

local title = {
	value = 3,
	comPlanId = 1,
	key = 2
}
local dataList = {
	{
		1,
		"SF_MAIN_RULE_KEY",
		"seek_food_rule"
	},
	{
		1,
		"SF_REDID_FOOD_KEY",
		"-344"
	},
	{
		1,
		"SF_REDID_PRIZE_KEY",
		"-345"
	}
}
local t_seek_food_common = {
	{
		SF_MAIN_RULE_KEY = dataList[1],
		SF_REDID_FOOD_KEY = dataList[2],
		SF_REDID_PRIZE_KEY = dataList[3]
	}
}

t_seek_food_common.dataList = dataList

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

return t_seek_food_common
