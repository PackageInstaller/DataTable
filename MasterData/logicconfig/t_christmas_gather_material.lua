-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_christmas_gather_material.lua

module("logicconfig.config.t_christmas_gather_material", package.seeall)

local title = {
	openDay = 7,
	maxCount = 5,
	item = 4,
	materialPlanId = 1,
	id = 2,
	gainCount = 6,
	materialName = 3
}
local dataList = {
	{
		1,
		1,
		"天蚕丝布",
		"1004:1028",
		4,
		1,
		1
	},
	{
		1,
		2,
		"灵巧针线",
		"1004:1029",
		4,
		1,
		2
	},
	{
		1,
		3,
		"千色神水",
		"1004:1030",
		4,
		1,
		3
	},
	{
		1,
		4,
		"鞣炼皮革",
		"1004:1031",
		4,
		1,
		8
	},
	{
		1,
		5,
		"雪花晶链",
		"1004:1032",
		4,
		1,
		9
	},
	{
		1,
		6,
		"冬夜雪伞",
		"1004:1033",
		4,
		1,
		10
	}
}
local t_christmas_gather_material = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_christmas_gather_material.dataList = dataList

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

return t_christmas_gather_material
