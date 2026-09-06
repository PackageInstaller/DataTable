-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_treasure_basin.lua

module("logicconfig.config.t_treasure_basin", package.seeall)

local title = {
	prize = 4,
	rewardId = 2,
	faceId = 5,
	consumeId = 3,
	activityId = 1
}
local dataList = {
	{
		73001,
		1,
		1,
		"104:2:1",
		14003
	}
}
local t_treasure_basin = {
	[73001] = dataList[1]
}

t_treasure_basin.dataList = dataList

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

return t_treasure_basin
