-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_activity.lua

module("logicconfig.config.t_three_matches_activity", package.seeall)

local title = {
	itemId = 3,
	activityId = 1,
	limit = 2
}
local dataList = {
	{
		207001,
		0,
		0
	},
	{
		207002,
		0,
		0
	},
	{
		207003,
		0,
		0
	},
	{
		207004,
		0,
		0
	}
}
local t_three_matches_activity = {
	[207001] = dataList[1],
	[207002] = dataList[2],
	[207003] = dataList[3],
	[207004] = dataList[4]
}

t_three_matches_activity.dataList = dataList

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

return t_three_matches_activity
