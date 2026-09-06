-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_dragon_stage.lua

module("logicconfig.config.t_divine_king_dragon_stage", package.seeall)

local title = {
	stageId = 2,
	prize = 3,
	actId = 1,
	teamPlanId = 4
}
local dataList = {
	{
		314001,
		1,
		"4:510233:20",
		1
	},
	{
		314001,
		2,
		"4:510233:30",
		2
	},
	{
		314001,
		3,
		"4:510233:50",
		3
	},
	{
		314002,
		1,
		"8:1:1",
		1
	},
	{
		314002,
		2,
		"8:1:1",
		2
	},
	{
		314002,
		3,
		"8:1:1",
		3
	}
}
local t_divine_king_dragon_stage = {
	[314001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[314002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_king_dragon_stage.dataList = dataList

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

return t_divine_king_dragon_stage
