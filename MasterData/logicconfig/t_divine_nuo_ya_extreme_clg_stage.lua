-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_extreme_clg_stage.lua

module("logicconfig.config.t_divine_nuo_ya_extreme_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 4,
	activityId = 1,
	selectPetCount = 3
}
local dataList = {
	{
		316001,
		1,
		12,
		"天芒试炼"
	},
	{
		316001,
		2,
		10,
		"审判试炼"
	},
	{
		316001,
		3,
		30,
		"时隙试炼"
	}
}
local t_divine_nuo_ya_extreme_clg_stage = {
	[316001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_nuo_ya_extreme_clg_stage.dataList = dataList

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

return t_divine_nuo_ya_extreme_clg_stage
