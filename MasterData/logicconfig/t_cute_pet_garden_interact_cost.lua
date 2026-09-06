-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_garden_interact_cost.lua

module("logicconfig.config.t_cute_pet_garden_interact_cost", package.seeall)

local title = {
	cost = 2,
	addHappiness = 3,
	costPlanId = 1
}
local dataList = {
	{
		1,
		"4:11101",
		10
	},
	{
		2,
		"4:11102",
		20
	}
}
local t_cute_pet_garden_interact_cost = {
	dataList[1],
	dataList[2]
}

t_cute_pet_garden_interact_cost.dataList = dataList

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

return t_cute_pet_garden_interact_cost
