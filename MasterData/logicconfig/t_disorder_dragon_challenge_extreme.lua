-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_dragon_challenge_extreme.lua

module("logicconfig.config.t_disorder_dragon_challenge_extreme", package.seeall)

local title = {
	condition = 5,
	extremeId = 1,
	creepsMasterId = 2,
	buffIds = 4,
	prize = 3
}
local dataList = {
	{
		1,
		201,
		"100:16011:1:1",
		{
			21,
			22,
			23,
			24,
			25,
			26,
			27
		},
		{
			1,
			1000000
		}
	}
}
local t_disorder_dragon_challenge_extreme = {
	dataList[1]
}

t_disorder_dragon_challenge_extreme.dataList = dataList

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

return t_disorder_dragon_challenge_extreme
