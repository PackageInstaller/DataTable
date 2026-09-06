-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_seven_day_task_params.lua

module("logicconfig.config.t_seven_day_task_params", package.seeall)

local title = {
	paramVal = 2,
	paramKey = 1
}
local dataList = {
	{
		"duration",
		"14"
	},
	{
		"PetBattleId",
		"3092;3093"
	}
}
local t_seven_day_task_params = {
	duration = dataList[1],
	PetBattleId = dataList[2]
}

t_seven_day_task_params.dataList = dataList

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

return t_seven_day_task_params
