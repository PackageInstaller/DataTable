-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_immortal_movement_story.lua

module("logicconfig.config.t_immortal_movement_story", package.seeall)

local title = {
	sortId = 2,
	title = 4,
	activityId = 1,
	storyId = 3
}
local dataList = {
	{
		484001,
		1,
		4810001,
		"启蒙教学"
	},
	{
		484001,
		2,
		4810002,
		"一叶之音"
	},
	{
		484001,
		3,
		4810003,
		"和谐韵律"
	},
	{
		484001,
		4,
		4810004,
		"即兴演出"
	},
	{
		484001,
		5,
		4810005,
		"琴音抚梦"
	}
}
local t_immortal_movement_story = {
	[484001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_immortal_movement_story.dataList = dataList

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

return t_immortal_movement_story
