-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mo_yan_challenge_buy_times.lua

module("logicconfig.config.t_mo_yan_challenge_buy_times", package.seeall)

local title = {
	buyTimesPlanId = 1,
	consume = 3,
	times = 2
}
local dataList = {
	{
		1,
		1,
		"105:188:100"
	}
}
local t_mo_yan_challenge_buy_times = {
	{
		dataList[1]
	}
}

t_mo_yan_challenge_buy_times.dataList = dataList

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

return t_mo_yan_challenge_buy_times
