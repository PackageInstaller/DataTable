-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_immortal_movement_score.lua

module("logicconfig.config.t_immortal_movement_score", package.seeall)

local title = {
	activityId = 1,
	requiredNotes = 3,
	title = 5,
	scoreId = 2,
	prize = 4
}
local dataList = {
	{
		484001,
		1,
		{
			1,
			2,
			3
		},
		"4:295:10#4:7008:50",
		"启蒙教学"
	},
	{
		484001,
		2,
		{
			1,
			2,
			3,
			4
		},
		"4:111:10#4:36:10",
		"一叶之音"
	},
	{
		484001,
		3,
		{
			1,
			2,
			3,
			4,
			5
		},
		"4:295:10#4:7008:50",
		"和谐韵律"
	},
	{
		484001,
		4,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		"4:12102:10#4:11002:30000",
		"即兴演出"
	},
	{
		484001,
		5,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7
		},
		"4:30006:100#8:1:1000000",
		"琴音抚梦"
	}
}
local t_immortal_movement_score = {
	[484001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_immortal_movement_score.dataList = dataList

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

return t_immortal_movement_score
