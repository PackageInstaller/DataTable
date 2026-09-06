-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_caiqing_draw_jump_to_plan.lua

module("logicconfig.config.t_caiqing_draw_jump_to_plan", package.seeall)

local title = {
	title1 = 6,
	btnPlanId = 3,
	title2 = 7,
	id = 2,
	rpIds = 5,
	jumpToPlanId = 1,
	startTime = 4
}
local dataList = {
	{
		1,
		1,
		1,
		nil,
		"c51",
		"过往章节",
		"回忆相遇"
	},
	{
		1,
		2,
		2,
		"2025-11-28T05:00:00",
		"c51",
		"此刻欢歌",
		"尽兴绽放"
	},
	{
		1,
		3,
		3,
		"2025-12-05T05:00:00",
		"c51",
		"未来序章",
		"约定同行"
	},
	{
		1,
		4,
		4,
		"2025-12-12T05:00:00",
		"c51",
		"永恒并肩",
		"一直都在"
	}
}
local t_caiqing_draw_jump_to_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_caiqing_draw_jump_to_plan.dataList = dataList

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

return t_caiqing_draw_jump_to_plan
