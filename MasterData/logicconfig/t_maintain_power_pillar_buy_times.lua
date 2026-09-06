-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_buy_times.lua

module("logicconfig.config.t_maintain_power_pillar_buy_times", package.seeall)

local title = {
	cost = 2,
	type = 1
}
local dataList = {
	{
		15,
		3
	}
}
local t_maintain_power_pillar_buy_times = {
	[15] = dataList[1]
}

t_maintain_power_pillar_buy_times.dataList = dataList

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

return t_maintain_power_pillar_buy_times
