-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_puzzle_jigsaw_activity.lua

module("logicconfig.config.t_puzzle_jigsaw_activity", package.seeall)

local title = {
	jigsawPlanId = 2,
	id = 1,
	prizePlanId = 3
}
local dataList = {
	{
		56001,
		1,
		1
	}
}
local t_puzzle_jigsaw_activity = {
	[56001] = dataList[1]
}

t_puzzle_jigsaw_activity.dataList = dataList

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

return t_puzzle_jigsaw_activity
