-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_story_summary.lua

module("logicconfig.config.t_story_summary", package.seeall)

local title = {
	reportBehavior = 3,
	storyPlanId = 1,
	storyName = 2
}
local dataList = {
	{
		1,
		"轮回终焉·序幕",
		0
	},
	{
		2,
		"神域领神·初见",
		0
	},
	{
		3,
		"大陆往事·间章",
		0
	},
	{
		4,
		"神裁协盟·六道",
		0
	},
	{
		5,
		"神域领神·乱起",
		0
	},
	{
		6,
		"神域领神·战意",
		0
	},
	{
		7,
		"创世神眷·起源",
		0
	},
	{
		8,
		"铠甲勇士，出击！",
		0
	},
	{
		9,
		"宙宇洞开·万象",
		0
	}
}
local t_story_summary = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_story_summary.dataList = dataList

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

return t_story_summary
