-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_tower_hundred_racing_mode.lua

module("logicconfig.config.t_glory_tower_hundred_racing_mode", package.seeall)

local title = {
	name = 2,
	stageGroupId = 3,
	templateId = 6,
	skinId = 7,
	id = 1,
	rankPrizePlanId = 5,
	excludePublicStrengthens = 4
}
local dataList = {
	{
		1,
		"竞速模式",
		1,
		false,
		1,
		201,
		10362
	},
	{
		2,
		"百战模式",
		2,
		false,
		2,
		202,
		10362
	}
}
local t_glory_tower_hundred_racing_mode = {
	dataList[1],
	dataList[2]
}

t_glory_tower_hundred_racing_mode.dataList = dataList

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

return t_glory_tower_hundred_racing_mode
