-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_image_fragment_collection_prize.lua

module("logicconfig.config.t_image_fragment_collection_prize", package.seeall)

local title = {
	shareImg = 6,
	imageId = 2,
	fragmentPlanId = 5,
	prizePlanId = 1,
	shareId = 7,
	prize = 3,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		"104:2:100",
		82037498,
		1,
		"board_fenxiang_01",
		7
	},
	{
		1,
		2,
		"104:2:100",
		82037498,
		2,
		"board_fenxiang_02",
		8
	}
}
local t_image_fragment_collection_prize = {
	{
		dataList[1],
		dataList[2]
	}
}

t_image_fragment_collection_prize.dataList = dataList

local multiLanguageCells = {
	desc = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_image_fragment_collection_prize
