-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter2_word.lua

module("logicconfig.config.t_boccaccio_chapter2_word", package.seeall)

local title = {
	wordId = 2,
	gainNeedMaxKillCircle = 3,
	activityId = 1,
	content = 4
}
local dataList = {
	{
		580001,
		1,
		4,
		"温柔"
	},
	{
		580001,
		2,
		4,
		"守护"
	},
	{
		580001,
		3,
		4,
		"光芒"
	},
	{
		580001,
		4,
		4,
		"温暖"
	},
	{
		580001,
		5,
		4,
		"庇护"
	},
	{
		580001,
		6,
		4,
		"期望"
	},
	{
		580001,
		7,
		4,
		"退路"
	},
	{
		580001,
		8,
		4,
		"活着"
	},
	{
		580001,
		9,
		4,
		"热血"
	},
	{
		580001,
		10,
		4,
		"色彩"
	},
	{
		580001,
		11,
		4,
		"危险"
	},
	{
		580001,
		12,
		4,
		"恐惧"
	}
}
local t_boccaccio_chapter2_word = {
	[580001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_boccaccio_chapter2_word.dataList = dataList

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

return t_boccaccio_chapter2_word
