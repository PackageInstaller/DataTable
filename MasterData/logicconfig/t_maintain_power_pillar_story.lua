-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_maintain_power_pillar_story.lua

module("logicconfig.config.t_maintain_power_pillar_story", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	showDesc = 6,
	storyId = 5,
	id = 2,
	pos = 4
}
local dataList = {
	{
		152005,
		1,
		"10:152010:100",
		{
			-400,
			-30
		},
		4900002,
		"记忆\r\n残卷\r\n1"
	},
	{
		152005,
		2,
		"10:152010:100",
		{
			-185,
			-205
		},
		4900003,
		"记忆\r\n残卷\r\n2"
	},
	{
		152005,
		3,
		"10:152010:100",
		{
			125,
			-170
		},
		4900004,
		"记忆\r\n残卷\r\n3"
	},
	{
		152005,
		4,
		"10:152010:100",
		{
			385,
			-15
		},
		4900005,
		"记忆\r\n残卷\r\n4"
	}
}
local t_maintain_power_pillar_story = {
	[152005] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_maintain_power_pillar_story.dataList = dataList

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

return t_maintain_power_pillar_story
