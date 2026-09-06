-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_psychic_clg_extreme_stage.lua

module("logicconfig.config.t_dragon_psychic_clg_extreme_stage", package.seeall)

local title = {
	teamId = 3,
	stageId = 2,
	stageDesc = 5,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		351001,
		1,
		1,
		101,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351001,
		1,
		2,
		102,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351001,
		2,
		1,
		103,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351001,
		2,
		2,
		104,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351001,
		3,
		1,
		105,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351001,
		3,
		2,
		106,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351002,
		1,
		1,
		101,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351002,
		1,
		2,
		102,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351002,
		2,
		1,
		103,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351002,
		2,
		2,
		104,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351002,
		3,
		1,
		105,
		"封印于龙系精灵的力量啊！快觉醒吧"
	},
	{
		351002,
		3,
		2,
		106,
		"封印于龙系精灵的力量啊！快觉醒吧"
	}
}
local t_dragon_psychic_clg_extreme_stage = {
	[351001] = {
		{
			dataList[1],
			dataList[2]
		},
		{
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6]
		}
	},
	[351002] = {
		{
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10]
		},
		{
			dataList[11],
			dataList[12]
		}
	}
}

t_dragon_psychic_clg_extreme_stage.dataList = dataList

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

return t_dragon_psychic_clg_extreme_stage
