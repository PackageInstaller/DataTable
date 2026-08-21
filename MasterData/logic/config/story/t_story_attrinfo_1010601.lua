-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/story/t_story_attrinfo_1010601.lua

module("logic.config.story.t_story_attrinfo_1010601", package.seeall)

local title = {
	attrTypes = 3,
	storyCode = 1,
	questionKey = 2,
	attrValues = 4
}
local dataList = {
	{
		1010601,
		510102,
		{
			0,
			4
		},
		{
			0,
			2
		}
	}
}
local t_story_attrinfo_1010601 = {}

t_story_attrinfo_1010601.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_story_attrinfo_1010601[v[1]] = v

	setmetatable(v, mt)
end

return t_story_attrinfo_1010601
