-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_select_pet_plan.lua

module("logicconfig.config.t_show_down_select_pet_plan", package.seeall)

local title = {
	totalPetCount = 3,
	randomPetPoolId = 7,
	wishPetCount = 2,
	wishPetPoolId = 6,
	refreshTimesPlanId = 5,
	selectPetPlanId = 1,
	refreshTimes = 4
}
local dataList = {
	{
		1,
		1,
		10,
		2,
		1,
		1,
		2
	},
	{
		2,
		2,
		15,
		1,
		2,
		1,
		2
	},
	{
		3,
		1,
		10,
		1,
		2,
		1,
		2
	},
	{
		4,
		1,
		10,
		2,
		1,
		3,
		4
	},
	{
		5,
		2,
		15,
		1,
		2,
		3,
		4
	},
	{
		6,
		1,
		10,
		1,
		2,
		3,
		4
	}
}
local t_show_down_select_pet_plan = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_show_down_select_pet_plan.dataList = dataList

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

return t_show_down_select_pet_plan
