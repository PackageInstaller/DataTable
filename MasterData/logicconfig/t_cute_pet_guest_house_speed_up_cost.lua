-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_guest_house_speed_up_cost.lua

module("logicconfig.config.t_cute_pet_guest_house_speed_up_cost", package.seeall)

local title = {
	cost = 2,
	costPlanId = 1,
	speedUpSecd = 3
}
local dataList = {
	{
		1,
		"4:11004",
		3600
	}
}
local t_cute_pet_guest_house_speed_up_cost = {
	dataList[1]
}

t_cute_pet_guest_house_speed_up_cost.dataList = dataList

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

return t_cute_pet_guest_house_speed_up_cost
