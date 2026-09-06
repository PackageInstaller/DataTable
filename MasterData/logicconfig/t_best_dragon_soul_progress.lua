-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_best_dragon_soul_progress.lua

module("logicconfig.config.t_best_dragon_soul_progress", package.seeall)

local title = {
	gainLikeTimes = 3,
	activityId = 1,
	type = 2
}
local dataList = {
	{
		358001,
		1,
		true
	},
	{
		358001,
		2,
		false
	}
}
local t_best_dragon_soul_progress = {
	[358001] = {
		dataList[1],
		dataList[2]
	}
}

t_best_dragon_soul_progress.dataList = dataList

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

return t_best_dragon_soul_progress
