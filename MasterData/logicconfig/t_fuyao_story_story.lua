-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fuyao_story_story.lua

module("logicconfig.config.t_fuyao_story_story", package.seeall)

local title = {
	plotId = 2,
	basePlanId = 1,
	name = 5,
	storyId = 4,
	stepId = 3,
	params = 6
}
local dataList = {
	{
		1,
		1,
		1,
		4820005,
		"开场剧情",
		""
	},
	{
		1,
		2,
		2,
		4820006,
		"第二章-开场",
		""
	},
	{
		1,
		3,
		2,
		4820007,
		"第二章-完成",
		"4"
	},
	{
		1,
		4,
		2,
		4820008,
		"第二章-唤醒誓祖",
		""
	},
	{
		1,
		5,
		3,
		4820009,
		"第三章-开场",
		""
	},
	{
		1,
		6,
		3,
		4820010,
		"第三章-完成",
		"5"
	},
	{
		1,
		7,
		1,
		4820003,
		"第一章-完成",
		""
	}
}
local t_fuyao_story_story = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_fuyao_story_story.dataList = dataList

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

return t_fuyao_story_story
