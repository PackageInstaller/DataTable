-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_image_fragment_collection_params.lua

module("logicconfig.config.t_image_fragment_collection_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_UNLOCK_NUM",
		"8"
	},
	{
		"IMAGE_FRAGMENT_NUM",
		"4"
	},
	{
		"MASS_THRESHOLD",
		"10"
	}
}
local t_image_fragment_collection_params = {
	DAILY_UNLOCK_NUM = dataList[1],
	IMAGE_FRAGMENT_NUM = dataList[2],
	MASS_THRESHOLD = dataList[3]
}

t_image_fragment_collection_params.dataList = dataList

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

return t_image_fragment_collection_params
