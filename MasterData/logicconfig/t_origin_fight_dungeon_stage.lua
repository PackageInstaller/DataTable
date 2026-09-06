-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_fight_dungeon_stage.lua

module("logicconfig.config.t_origin_fight_dungeon_stage", package.seeall)

local title = {
	initPoses = 4,
	roles = 3,
	stageId = 1,
	eventPlanId = 5,
	mapSize = 2
}
local dataList = {
	{
		1,
		{
			5,
			5
		},
		{
			1,
			2
		},
		{
			{
				0,
				0
			},
			{
				3,
				0
			}
		},
		1
	}
}
local t_origin_fight_dungeon_stage = {
	dataList[1]
}

t_origin_fight_dungeon_stage.dataList = dataList

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

return t_origin_fight_dungeon_stage
