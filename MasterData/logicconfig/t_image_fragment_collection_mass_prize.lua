-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_image_fragment_collection_mass_prize.lua

module("logicconfig.config.t_image_fragment_collection_mass_prize", package.seeall)

local title = {
	id = 2,
	massPrizePlanId = 1,
	regardValue = 3,
	prize = 4
}
local dataList = {
	{
		1,
		1,
		10,
		"4:31:1"
	},
	{
		1,
		2,
		30,
		"4:111:1"
	},
	{
		1,
		3,
		50,
		"4:36:1"
	},
	{
		1,
		4,
		70,
		"4:112:2"
	}
}
local t_image_fragment_collection_mass_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_image_fragment_collection_mass_prize.dataList = dataList

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

return t_image_fragment_collection_mass_prize
