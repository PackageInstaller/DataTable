-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_battle_client_common.lua

module("logicconfig.config.t_new_family_battle_client_common", package.seeall)

local title = {
	pillarEnergySteps = 2,
	comPlanId = 1,
	adjustTipsKey = 4,
	towerTipsKey = 3
}
local dataList = {
	{
		1,
		{
			100,
			300
		},
		"familypillartower",
		"familypillartower"
	}
}
local t_new_family_battle_client_common = {
	dataList[1]
}

t_new_family_battle_client_common.dataList = dataList

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

return t_new_family_battle_client_common
