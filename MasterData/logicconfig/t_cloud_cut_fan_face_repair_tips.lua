-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cloud_cut_fan_face_repair_tips.lua

module("logicconfig.config.t_cloud_cut_fan_face_repair_tips", package.seeall)

local title = {
	pos = 5,
	showPic = 3,
	Id = 2,
	activityId = 1,
	fixTips = 4
}
local dataList = {
	{
		615001,
		1,
		"board_qiaoshoucaiyunshanz_24",
		"燕子",
		{
			-92,
			0
		}
	},
	{
		615001,
		2,
		"board_qiaoshoucaiyunshanz_25",
		"荷花",
		{
			0,
			-198
		}
	},
	{
		615001,
		3,
		"board_qiaoshoucaiyunshanz_26",
		"含苞",
		{
			76,
			94
		}
	},
	{
		615001,
		4,
		"board_qiaoshoucaiyunshanz_27",
		"山脉",
		{
			-92,
			7
		}
	},
	{
		615001,
		5,
		"board_qiaoshoucaiyunshanz_28",
		"羽翼",
		{
			-10,
			-180
		}
	},
	{
		615001,
		6,
		"board_qiaoshoucaiyunshanz_29",
		"仙鹤",
		{
			74,
			85
		}
	},
	{
		615001,
		7,
		"board_qiaoshoucaiyunshanz_30",
		"燕",
		{
			-99,
			8
		}
	},
	{
		615001,
		8,
		"board_qiaoshoucaiyunshanz_31",
		"梅花",
		{
			-9,
			-208
		}
	},
	{
		615001,
		9,
		"board_qiaoshoucaiyunshanz_32",
		"梅花",
		{
			80,
			94
		}
	},
	{
		615001,
		10,
		"board_qiaoshoucaiyunshanz_33",
		"蝶",
		{
			-97,
			-2
		}
	},
	{
		615001,
		11,
		"board_qiaoshoucaiyunshanz_34",
		"牡丹",
		{
			18,
			-167
		}
	},
	{
		615001,
		12,
		"board_qiaoshoucaiyunshanz_35",
		"枝叶",
		{
			80,
			92
		}
	},
	{
		615001,
		13,
		"board_qiaoshoucaiyunshanz_36",
		"山脉",
		{
			-150,
			-81
		}
	},
	{
		615001,
		14,
		"board_qiaoshoucaiyunshanz_37",
		"燕子",
		{
			-12,
			-147
		}
	},
	{
		615001,
		15,
		"board_qiaoshoucaiyunshanz_38",
		"柳叶",
		{
			78,
			88
		}
	},
	{
		615001,
		16,
		"board_qiaoshoucaiyunshanz_39",
		"草丛",
		{
			-156,
			-74
		}
	},
	{
		615001,
		17,
		"board_qiaoshoucaiyunshanz_40",
		"荷叶",
		{
			-12,
			-187
		}
	},
	{
		615001,
		18,
		"board_qiaoshoucaiyunshanz_41",
		"花苞",
		{
			72,
			89
		}
	},
	{
		615001,
		19,
		"board_qiaoshoucaiyunshanz_42",
		"山景",
		{
			-156,
			-86
		}
	},
	{
		615001,
		20,
		"board_qiaoshoucaiyunshanz_43",
		"羽翼",
		{
			-15,
			-193
		}
	},
	{
		615001,
		21,
		"board_qiaoshoucaiyunshanz_44",
		"仙鹤",
		{
			79,
			84
		}
	}
}
local t_cloud_cut_fan_face_repair_tips = {
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
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_cloud_cut_fan_face_repair_tips.dataList = dataList

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

return t_cloud_cut_fan_face_repair_tips
