-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddishitian_challenge_info.lua

module("logicconfig.config.t_goddishitian_challenge_info", package.seeall)

local title = {
	challengeId = 1,
	finalStage = 3,
	normalStage = 2,
	passSaleCost = 4,
	passSaleAward = 5,
	passSaleAwardTime = 6
}
local dataList = {
	{
		41,
		{
			1,
			2,
			3
		},
		4,
		"204:204:288",
		"4:64008:20",
		"2022-07-22T05:00:00"
	}
}
local t_goddishitian_challenge_info = {
	[41] = dataList[1]
}

t_goddishitian_challenge_info.dataList = dataList

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

return t_goddishitian_challenge_info
