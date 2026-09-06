-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ice_king_challenge_config.lua

module("logicconfig.config.t_ice_king_challenge_config", package.seeall)

local title = {
	challengeId = 1,
	rankSize = 3,
	rankPrize = 4,
	ratio = 6,
	dailyItemCount = 2,
	sweepNeedAlivePetCount = 5,
	extItem = 7
}
local dataList = {
	{
		15,
		50,
		5999,
		"14:30:1",
		4,
		10,
		"100:10345#100:10098"
	}
}
local t_ice_king_challenge_config = {
	[15] = dataList[1]
}

t_ice_king_challenge_config.dataList = dataList

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

return t_ice_king_challenge_config
