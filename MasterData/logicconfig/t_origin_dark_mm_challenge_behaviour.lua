-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mm_challenge_behaviour.lua

module("logicconfig.config.t_origin_dark_mm_challenge_behaviour", package.seeall)

local title = {
	id = 2,
	cost = 4,
	costPlanId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"普攻",
		5
	},
	{
		1,
		2,
		"超杀",
		5
	},
	{
		1,
		3,
		"复活",
		5
	},
	{
		1,
		4,
		"暴击",
		5
	},
	{
		1,
		5,
		"格挡",
		5
	},
	{
		1,
		6,
		"闪避",
		5
	}
}
local t_origin_dark_mm_challenge_behaviour = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_dark_mm_challenge_behaviour.dataList = dataList

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

return t_origin_dark_mm_challenge_behaviour
