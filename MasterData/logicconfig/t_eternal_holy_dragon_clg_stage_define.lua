-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_holy_dragon_clg_stage_define.lua

module("logicconfig.config.t_eternal_holy_dragon_clg_stage_define", package.seeall)

local title = {
	stageId = 2,
	mapId = 3,
	itemMaxOwnCount = 5,
	passStagePrize = 6,
	activityId = 1,
	itemPlanId = 4
}
local dataList = {
	{
		301001,
		1,
		1,
		1,
		6,
		"4:379:20"
	},
	{
		301001,
		2,
		2,
		1,
		6,
		"4:379:40"
	},
	{
		301001,
		3,
		3,
		1,
		6,
		"4:379:60"
	},
	{
		301002,
		1,
		1,
		1,
		6,
		"8:1:1"
	},
	{
		301002,
		2,
		2,
		1,
		6,
		"8:1:1"
	},
	{
		301002,
		3,
		3,
		1,
		6,
		"8:1:1"
	}
}
local t_eternal_holy_dragon_clg_stage_define = {
	[301001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[301002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_eternal_holy_dragon_clg_stage_define.dataList = dataList

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

return t_eternal_holy_dragon_clg_stage_define
