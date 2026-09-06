-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cloud_cut_fan_material.lua

module("logicconfig.config.t_cloud_cut_fan_material", package.seeall)

local title = {
	materialId = 2,
	craftCost = 4,
	picPath = 5,
	typeId = 3,
	activityId = 1
}
local dataList = {
	{
		615001,
		1,
		1,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_17"
	},
	{
		615001,
		2,
		1,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_18"
	},
	{
		615001,
		3,
		1,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_19"
	},
	{
		615001,
		4,
		1,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_20"
	},
	{
		615001,
		5,
		2,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_11"
	},
	{
		615001,
		6,
		2,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_12"
	},
	{
		615001,
		7,
		2,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_13"
	},
	{
		615001,
		8,
		2,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_14"
	},
	{
		615001,
		9,
		3,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_15"
	},
	{
		615001,
		10,
		3,
		"10:615002:5",
		"board_qiaoshoucaiyunshanz_16"
	}
}
local t_cloud_cut_fan_material = {
	[615001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_cloud_cut_fan_material.dataList = dataList

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

return t_cloud_cut_fan_material
