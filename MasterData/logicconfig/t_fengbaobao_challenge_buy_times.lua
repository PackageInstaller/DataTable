-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fengbaobao_challenge_buy_times.lua

module("logicconfig.config.t_fengbaobao_challenge_buy_times", package.seeall)

local title = {
	consume = 3,
	planId = 1,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:175:50"
	},
	{
		1,
		2,
		"105:175:50"
	}
}
local t_fengbaobao_challenge_buy_times = {
	{
		dataList[1],
		dataList[2]
	}
}

t_fengbaobao_challenge_buy_times.dataList = dataList

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

return t_fengbaobao_challenge_buy_times
