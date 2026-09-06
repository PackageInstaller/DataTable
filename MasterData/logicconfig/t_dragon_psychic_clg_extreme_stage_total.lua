-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_psychic_clg_extreme_stage_total.lua

module("logicconfig.config.t_dragon_psychic_clg_extreme_stage_total", package.seeall)

local title = {
	stageId = 2,
	name = 3,
	activityId = 1
}
local dataList = {
	{
		351001,
		1,
		"时空\n时空之门"
	},
	{
		351001,
		2,
		"虚空\n虚空之门"
	},
	{
		351001,
		3,
		"现世\n现世之门"
	},
	{
		351002,
		1,
		"时空\n时空之门"
	},
	{
		351002,
		2,
		"虚空\n虚空之门"
	},
	{
		351002,
		3,
		"现世\n现世之门"
	}
}
local t_dragon_psychic_clg_extreme_stage_total = {
	[351001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[351002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_dragon_psychic_clg_extreme_stage_total.dataList = dataList

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

return t_dragon_psychic_clg_extreme_stage_total
