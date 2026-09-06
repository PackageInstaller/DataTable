-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_image_fragment_collection.lua

module("logicconfig.config.t_image_fragment_collection", package.seeall)

local title = {
	massPrizePlanId = 3,
	activityId = 1,
	prizePlanId = 2
}
local dataList = {
	{
		69001,
		1,
		1
	}
}
local t_image_fragment_collection = {
	[69001] = dataList[1]
}

t_image_fragment_collection.dataList = dataList

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

return t_image_fragment_collection
