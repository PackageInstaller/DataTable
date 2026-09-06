-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_script_killing_zone.lua

module("logicconfig.config.t_script_killing_zone", package.seeall)

local title = {
	tips = 8,
	name = 4,
	zoneId = 3,
	chapterId = 2,
	isFlip = 6,
	unlockIds = 7,
	activityId = 1,
	imgUrl = 5
}
local dataList = {
	{
		365001,
		1,
		4,
		"田星房间",
		"bg_jubensha_03",
		false,
		nil,
		""
	},
	{
		365001,
		1,
		5,
		"小维房间",
		"bg_jubensha_03",
		false,
		nil,
		""
	},
	{
		365001,
		1,
		7,
		"客厅",
		"bg_jubensha_02",
		false,
		nil,
		""
	},
	{
		365001,
		2,
		1,
		"书房",
		"bg_jubensha_04",
		false,
		nil,
		""
	},
	{
		365001,
		2,
		3,
		"百莎莎房间",
		"bg_jubensha_03",
		true,
		nil,
		""
	},
	{
		365001,
		2,
		4,
		"田星房间",
		"bg_jubensha_03",
		false,
		nil,
		""
	},
	{
		365001,
		2,
		5,
		"小维房间",
		"bg_jubensha_03",
		false,
		nil,
		""
	},
	{
		365001,
		2,
		7,
		"客厅",
		"bg_jubensha_02",
		false,
		nil,
		""
	},
	{
		365001,
		3,
		1,
		"书房",
		"bg_jubensha_04",
		false,
		nil,
		""
	},
	{
		365001,
		3,
		2,
		"公爵房间",
		"bg_jubensha_03",
		false,
		nil,
		""
	},
	{
		365001,
		3,
		4,
		"田星房间",
		"bg_jubensha_03",
		false,
		nil,
		""
	},
	{
		365001,
		3,
		6,
		"百序序房间",
		"bg_jubensha_03",
		true,
		nil,
		""
	},
	{
		365001,
		3,
		7,
		"客厅",
		"bg_jubensha_02",
		false,
		nil,
		""
	},
	{
		365002,
		1,
		1,
		"梦之岛·上",
		"bg_menghziduifuben04",
		false,
		nil,
		""
	},
	{
		365002,
		1,
		2,
		"梦之岛·下",
		"bg_menghziduifuben03",
		false,
		nil,
		""
	},
	{
		365003,
		1,
		1,
		"月下瑶池",
		"bg_jubensha_07",
		false,
		nil,
		""
	},
	{
		365003,
		2,
		2,
		"溪下殿堂",
		"bg_jubensha_08",
		false,
		nil,
		""
	},
	{
		365003,
		3,
		3,
		"月夜庭院",
		"bg_jubensha_09",
		false,
		nil,
		""
	}
}
local t_script_killing_zone = {
	[365001] = {
		{
			[4] = dataList[1],
			[5] = dataList[2],
			[7] = dataList[3]
		},
		{
			dataList[4],
			[3] = dataList[5],
			[4] = dataList[6],
			[5] = dataList[7],
			[7] = dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			[4] = dataList[11],
			[6] = dataList[12],
			[7] = dataList[13]
		}
	},
	[365002] = {
		{
			dataList[14],
			dataList[15]
		}
	},
	[365003] = {
		{
			dataList[16]
		},
		{
			[2] = dataList[17]
		},
		{
			[3] = dataList[18]
		}
	}
}

t_script_killing_zone.dataList = dataList

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

return t_script_killing_zone
