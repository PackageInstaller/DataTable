-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_story_prize.lua

module("logicconfig.config.t_story_prize", package.seeall)

local title = {
	prize = 2,
	storyId = 1
}
local dataList = {
	{
		4820036,
		"104:2:188"
	},
	{
		4820051,
		"104:2:188"
	},
	{
		4820052,
		"104:2:188"
	},
	{
		4820055,
		"104:2:188"
	},
	{
		4820056,
		"104:2:188"
	},
	{
		4820057,
		"104:2:188"
	},
	{
		4820058,
		"104:2:188"
	},
	{
		4830004,
		"104:2:188"
	},
	{
		4830005,
		"104:2:188"
	},
	{
		4820096,
		"104:2:188"
	},
	{
		4820097,
		"104:2:188"
	},
	{
		4820098,
		"104:2:188"
	}
}
local t_story_prize = {
	[4820036] = dataList[1],
	[4820051] = dataList[2],
	[4820052] = dataList[3],
	[4820055] = dataList[4],
	[4820056] = dataList[5],
	[4820057] = dataList[6],
	[4820058] = dataList[7],
	[4830004] = dataList[8],
	[4830005] = dataList[9],
	[4820096] = dataList[10],
	[4820097] = dataList[11],
	[4820098] = dataList[12]
}

t_story_prize.dataList = dataList

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

return t_story_prize
