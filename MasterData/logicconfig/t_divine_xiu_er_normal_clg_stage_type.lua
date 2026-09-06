-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_er_normal_clg_stage_type.lua

module("logicconfig.config.t_divine_xiu_er_normal_clg_stage_type", package.seeall)

local title = {
	index = 2,
	title = 5,
	stageClgResultDescOfUp = 6,
	stageClgResultDescOfDown = 7,
	tipsDesc = 4,
	stageType = 3,
	activityId = 1
}
local dataList = {
	{
		329001,
		1,
		0,
		"我方被击败时，敌阵存活的精灵转化为“非”之力，<color=#4fdf93>我方至少击杀敌阵1只</color>精灵才统计“非”之力",
		"非之力",
		"本关“非”之力获得了提升",
		"本关“非”之力未变化"
	},
	{
		329001,
		2,
		1,
		"击败敌阵时，我方存活精灵数量转化为“是”之力，<color=#4fdf93>我方至少存活2只</color>精灵才统计“是”之力",
		"是之力",
		"本关“是”之力获得了提升",
		"本关“是”之力未变化"
	}
}
local t_divine_xiu_er_normal_clg_stage_type = {
	[329001] = {
		dataList[1],
		dataList[2]
	}
}

t_divine_xiu_er_normal_clg_stage_type.dataList = dataList

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

return t_divine_xiu_er_normal_clg_stage_type
