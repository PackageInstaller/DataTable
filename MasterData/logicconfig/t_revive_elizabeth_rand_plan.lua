-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_revive_elizabeth_rand_plan.lua

module("logicconfig.config.t_revive_elizabeth_rand_plan", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"AVATAR_RANGE",
		"1,11#18,50#52,73#75,81#83,121#123,145#155,325"
	},
	{
		"AVATAR_FRAME_RANGE",
		"1,4#7,85#87,168#170,184#187,230#233,253#256,287"
	},
	{
		"MAX_MSG_NUM",
		"3"
	}
}
local t_revive_elizabeth_rand_plan = {
	AVATAR_RANGE = dataList[1],
	AVATAR_FRAME_RANGE = dataList[2],
	MAX_MSG_NUM = dataList[3]
}

t_revive_elizabeth_rand_plan.dataList = dataList

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

return t_revive_elizabeth_rand_plan
