-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cloud_cut_fan_face_collection.lua

module("logicconfig.config.t_cloud_cut_fan_face_collection", package.seeall)

local title = {
	showName = 5,
	bookPic = 3,
	fanFaceId = 2,
	activityId = 1,
	fixTips = 4
}
local dataList = {
	{
		615001,
		1,
		"board_qiaoshoucaiyunshanz_17",
		{
			1,
			2,
			3
		},
		"荷间燕语"
	},
	{
		615001,
		2,
		"board_qiaoshoucaiyunshanz_18",
		{
			4,
			5,
			6
		},
		"仙阁鸣鹤"
	},
	{
		615001,
		3,
		"board_qiaoshoucaiyunshanz_19",
		{
			7,
			8,
			9
		},
		"梅枝栖燕"
	},
	{
		615001,
		4,
		"board_qiaoshoucaiyunshanz_20",
		{
			10,
			11,
			12
		},
		"牡丹寻蝶"
	},
	{
		615001,
		5,
		"board_qiaoshoucaiyunshanz_21",
		{
			13,
			14,
			15
		},
		"柳岸春燕"
	},
	{
		615001,
		6,
		"board_qiaoshoucaiyunshanz_22",
		{
			16,
			17,
			18
		},
		"清池荷苞"
	},
	{
		615001,
		7,
		"board_qiaoshoucaiyunshanz_23",
		{
			19,
			20,
			21
		},
		"云巅鹤舞"
	}
}
local t_cloud_cut_fan_face_collection = {
	[615001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_cloud_cut_fan_face_collection.dataList = dataList

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

return t_cloud_cut_fan_face_collection
