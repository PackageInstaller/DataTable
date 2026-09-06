-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_speed_up_card.lua

module("logicconfig.config.t_zoo_speed_up_card", package.seeall)

local title = {
	id = 1,
	speedUpTime = 2
}
local dataList = {
	{
		2,
		30
	},
	{
		3,
		60
	}
}
local t_zoo_speed_up_card = {
	[2] = dataList[1],
	[3] = dataList[2]
}

t_zoo_speed_up_card.dataList = dataList

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

return t_zoo_speed_up_card
