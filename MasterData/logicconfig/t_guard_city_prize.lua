-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_city_prize.lua

module("logicconfig.config.t_guard_city_prize", package.seeall)

local title = {
	prizeId = 2,
	score = 3,
	prize = 4,
	prizePlanId = 1
}
local dataList = {}
local t_guard_city_prize = {}

t_guard_city_prize.dataList = dataList

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

return t_guard_city_prize
