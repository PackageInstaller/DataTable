-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shadow_dragon_clg_now_stage.lua

module("logicconfig.config.t_shadow_dragon_clg_now_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 4,
	selectBuffPlan = 5,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		527001,
		1,
		"现在关卡-1",
		1001,
		0
	},
	{
		527001,
		2,
		"现在关卡-2",
		1002,
		1
	},
	{
		527001,
		3,
		"现在关卡-3",
		1003,
		1
	},
	{
		527001,
		4,
		"现在关卡-4",
		1004,
		1
	},
	{
		527001,
		5,
		"现在关卡-5",
		1005,
		1
	}
}
local t_shadow_dragon_clg_now_stage = {
	[527001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_shadow_dragon_clg_now_stage.dataList = dataList

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

return t_shadow_dragon_clg_now_stage
