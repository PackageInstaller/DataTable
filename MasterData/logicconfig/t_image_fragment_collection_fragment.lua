-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_image_fragment_collection_fragment.lua

module("logicconfig.config.t_image_fragment_collection_fragment", package.seeall)

local title = {
	fragmentId = 2,
	openTime = 4,
	fragmentPlanId = 1,
	jumpTo = 3
}
local dataList = {
	{
		1,
		1,
		"npc#10012029",
		"2021-09-23T05:00:00"
	},
	{
		1,
		2,
		"npc#10012030",
		"2021-09-23T05:00:00"
	},
	{
		1,
		3,
		"npc#10012031",
		"2021-09-25T05:00:00"
	},
	{
		1,
		4,
		"npc#10012032",
		"2021-09-25T05:00:00"
	},
	{
		2,
		1,
		"npc#10012033",
		"2021-09-27T05:00:00"
	},
	{
		2,
		2,
		"npc#10012034",
		"2021-09-27T05:00:00"
	},
	{
		2,
		3,
		"npc#10012035",
		"2021-09-29T05:00:00"
	},
	{
		2,
		4,
		"npc#10012036",
		"2021-09-29T05:00:00"
	}
}
local t_image_fragment_collection_fragment = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_image_fragment_collection_fragment.dataList = dataList

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

return t_image_fragment_collection_fragment
