-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_quality.lua

module("logicconfig.config.t_dumpling_feast_quality", package.seeall)

local title = {
	score = 4,
	name = 3,
	quality = 2,
	intimacy = 5,
	activityId = 1
}
local dataList = {
	{
		562001,
		1,
		"绿色",
		3,
		10
	},
	{
		562001,
		2,
		"蓝色",
		10,
		30
	},
	{
		562001,
		3,
		"紫色",
		15,
		50
	},
	{
		562001,
		4,
		"黄金",
		30,
		100
	}
}
local t_dumpling_feast_quality = {
	[562001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_dumpling_feast_quality.dataList = dataList

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

return t_dumpling_feast_quality
