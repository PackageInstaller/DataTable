-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_operation_check_in_extra.lua

module("logicconfig.config.t_operation_check_in_extra", package.seeall)

local title = {
	jumpTo = 4,
	itemBuff = 2,
	activityId = 1,
	storyId = 3
}
local dataList = {
	{
		18001,
		"",
		0,
		""
	},
	{
		18002,
		"",
		0,
		""
	},
	{
		18003,
		"",
		0,
		""
	},
	{
		18004,
		"",
		0,
		""
	},
	{
		18005,
		"",
		0,
		""
	},
	{
		18006,
		"",
		0,
		""
	},
	{
		18007,
		"",
		0,
		""
	},
	{
		18008,
		"",
		0,
		""
	},
	{
		18009,
		"",
		0,
		""
	},
	{
		18010,
		"",
		0,
		""
	},
	{
		49001,
		"",
		0,
		""
	},
	{
		49002,
		"",
		0,
		""
	},
	{
		18011,
		"",
		0,
		""
	},
	{
		18012,
		"",
		0,
		""
	},
	{
		18013,
		"",
		0,
		""
	},
	{
		18014,
		"",
		0,
		""
	},
	{
		18015,
		"1:20006001,2:20006002",
		0,
		""
	},
	{
		18016,
		"",
		0,
		""
	},
	{
		18017,
		"",
		0,
		""
	},
	{
		18018,
		"",
		0,
		""
	},
	{
		18019,
		"",
		0,
		""
	},
	{
		18020,
		"",
		0,
		""
	},
	{
		18021,
		"",
		0,
		""
	},
	{
		18022,
		"",
		0,
		"func#5061"
	},
	{
		18023,
		"",
		0,
		"func#910"
	},
	{
		18024,
		"",
		0,
		"func#910"
	},
	{
		18025,
		"",
		0,
		"func#910"
	},
	{
		49003,
		"",
		0,
		"func#910"
	},
	{
		18026,
		"",
		0,
		"func#910"
	},
	{
		401003,
		"",
		0,
		"func#910"
	},
	{
		18027,
		"",
		0,
		"func#910"
	},
	{
		18028,
		"",
		0,
		"func#910"
	},
	{
		18029,
		"",
		0,
		"func#910"
	}
}
local t_operation_check_in_extra = {
	[18001] = dataList[1],
	[18002] = dataList[2],
	[18003] = dataList[3],
	[18004] = dataList[4],
	[18005] = dataList[5],
	[18006] = dataList[6],
	[18007] = dataList[7],
	[18008] = dataList[8],
	[18009] = dataList[9],
	[18010] = dataList[10],
	[49001] = dataList[11],
	[49002] = dataList[12],
	[18011] = dataList[13],
	[18012] = dataList[14],
	[18013] = dataList[15],
	[18014] = dataList[16],
	[18015] = dataList[17],
	[18016] = dataList[18],
	[18017] = dataList[19],
	[18018] = dataList[20],
	[18019] = dataList[21],
	[18020] = dataList[22],
	[18021] = dataList[23],
	[18022] = dataList[24],
	[18023] = dataList[25],
	[18024] = dataList[26],
	[18025] = dataList[27],
	[49003] = dataList[28],
	[18026] = dataList[29],
	[401003] = dataList[30],
	[18027] = dataList[31],
	[18028] = dataList[32],
	[18029] = dataList[33]
}

t_operation_check_in_extra.dataList = dataList

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

return t_operation_check_in_extra
