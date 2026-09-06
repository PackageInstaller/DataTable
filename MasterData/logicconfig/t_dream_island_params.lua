-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_island_params.lua

module("logicconfig.config.t_dream_island_params", package.seeall)

local title = {
	paramVal = 2,
	paramKey = 1
}
local dataList = {
	{
		"activityType",
		"33"
	},
	{
		"fakeId",
		"1004"
	}
}
local t_dream_island_params = {
	activityType = dataList[1],
	fakeId = dataList[2]
}

t_dream_island_params.dataList = dataList

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

return t_dream_island_params
