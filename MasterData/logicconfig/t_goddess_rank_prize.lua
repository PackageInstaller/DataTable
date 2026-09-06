-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_rank_prize.lua

module("logicconfig.config.t_goddess_rank_prize", package.seeall)

local title = {
	activityId = 1,
	prize = 3,
	rank = 2
}
local dataList = {
	{
		121001,
		1,
		"104:2:600#2:50:1"
	},
	{
		121001,
		2,
		"104:2:500#2:50:1"
	},
	{
		121001,
		3,
		"104:2:500#2:50:1"
	},
	{
		121001,
		10,
		"104:2:300"
	},
	{
		121001,
		50,
		"104:2:200"
	},
	{
		121001,
		100,
		"104:2:100"
	}
}
local t_goddess_rank_prize = {
	[121001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		[10] = dataList[4],
		[50] = dataList[5],
		[100] = dataList[6]
	}
}

t_goddess_rank_prize.dataList = dataList

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

return t_goddess_rank_prize
