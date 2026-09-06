-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter2_error_word.lua

module("logicconfig.config.t_boccaccio_chapter2_error_word", package.seeall)

local title = {
	activityId = 1,
	content = 5,
	errorWordId = 2,
	storyId = 3,
	replaceWordId = 4
}
local dataList = {
	{
		580001,
		1,
		1,
		2,
		"熄灭"
	},
	{
		580001,
		2,
		1,
		4,
		"冰冷"
	},
	{
		580001,
		3,
		1,
		3,
		"黑暗"
	},
	{
		580001,
		4,
		1,
		1,
		"冷漠"
	},
	{
		580001,
		5,
		2,
		7,
		"绝路"
	},
	{
		580001,
		6,
		2,
		5,
		"迫害"
	},
	{
		580001,
		7,
		2,
		8,
		"逝去"
	},
	{
		580001,
		8,
		2,
		6,
		"失望"
	}
}
local t_boccaccio_chapter2_error_word = {
	[580001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_boccaccio_chapter2_error_word.dataList = dataList

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

return t_boccaccio_chapter2_error_word
