-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fusion_soul_progress_prize.lua

module("logicconfig.config.t_fusion_soul_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		498001,
		1,
		1,
		"8:1:10000000"
	},
	{
		498001,
		2,
		3,
		"4:36:10"
	},
	{
		498001,
		3,
		5,
		"8:1:10000000"
	},
	{
		498001,
		4,
		8,
		"4:36:10"
	},
	{
		498001,
		5,
		12,
		"8:1:15000000"
	},
	{
		498001,
		6,
		16,
		"4:36:10"
	},
	{
		498001,
		7,
		21,
		"8:1:15000000"
	},
	{
		498001,
		8,
		27,
		"4:36:10"
	},
	{
		498001,
		9,
		32,
		"100:12010:1:1"
	}
}
local t_fusion_soul_progress_prize = {
	[498001] = {
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
}

t_fusion_soul_progress_prize.dataList = dataList

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

return t_fusion_soul_progress_prize
