-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miya_challenge_first.lua

module("logicconfig.config.t_miya_challenge_first", package.seeall)

local title = {
	stageId = 2,
	prizes = 5,
	prize = 6,
	stageDesc = 7,
	creepsMasterId = 3,
	firstPlanId = 1,
	damages = 4
}
local dataList = {
	{
		1,
		1,
		301,
		{
			10000,
			20000,
			99999
		},
		{
			1,
			1,
			1
		},
		"8:1:111111",
		"来打我啊"
	},
	{
		1,
		2,
		302,
		{
			20000
		},
		{
			2
		},
		"8:1:111111",
		"来打我啊"
	}
}
local t_miya_challenge_first = {
	{
		dataList[1],
		dataList[2]
	}
}

t_miya_challenge_first.dataList = dataList

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

return t_miya_challenge_first
