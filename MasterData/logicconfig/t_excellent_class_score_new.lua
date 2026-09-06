-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_excellent_class_score_new.lua

module("logicconfig.config.t_excellent_class_score_new", package.seeall)

local title = {
	prize = 3,
	activityId = 1,
	needScore = 2
}
local dataList = {
	{
		106001,
		100,
		"4:96003:1"
	},
	{
		106001,
		200,
		"4:96003:1"
	},
	{
		106001,
		300,
		"4:96003:1"
	},
	{
		106001,
		400,
		"4:96003:1"
	},
	{
		106001,
		500,
		"4:96003:1"
	},
	{
		106002,
		60,
		"4:96003:1"
	},
	{
		106002,
		120,
		"4:96003:1"
	},
	{
		106002,
		200,
		"4:320:1"
	},
	{
		106002,
		300,
		"4:96003:1"
	},
	{
		106002,
		400,
		"4:96003:1"
	},
	{
		106002,
		500,
		"4:96003:1"
	},
	{
		106003,
		100,
		"4:96004:1"
	},
	{
		106003,
		200,
		"4:96004:1"
	},
	{
		106003,
		300,
		"4:96004:1"
	},
	{
		106003,
		400,
		"4:96004:1"
	},
	{
		106003,
		500,
		"4:96004:1"
	},
	{
		106003,
		600,
		"4:96004:1"
	},
	{
		106003,
		800,
		"4:510158:100"
	},
	{
		106004,
		60,
		"4:96003:1"
	},
	{
		106004,
		120,
		"4:96003:1"
	},
	{
		106004,
		200,
		"4:320:1"
	},
	{
		106004,
		300,
		"4:96003:1"
	},
	{
		106004,
		400,
		"4:96003:1"
	},
	{
		106004,
		500,
		"4:96003:1"
	},
	{
		106005,
		100,
		"4:96004:1"
	},
	{
		106005,
		200,
		"4:96004:1"
	},
	{
		106005,
		300,
		"4:96004:1"
	},
	{
		106005,
		400,
		"4:96004:1"
	},
	{
		106005,
		500,
		"4:96004:1"
	},
	{
		106005,
		600,
		"4:96004:1"
	},
	{
		106005,
		800,
		"4:510158:100"
	}
}
local t_excellent_class_score_new = {
	[106001] = {
		[100] = dataList[1],
		[200] = dataList[2],
		[300] = dataList[3],
		[400] = dataList[4],
		[500] = dataList[5]
	},
	[106002] = {
		[60] = dataList[6],
		[120] = dataList[7],
		[200] = dataList[8],
		[300] = dataList[9],
		[400] = dataList[10],
		[500] = dataList[11]
	},
	[106003] = {
		[100] = dataList[12],
		[200] = dataList[13],
		[300] = dataList[14],
		[400] = dataList[15],
		[500] = dataList[16],
		[600] = dataList[17],
		[800] = dataList[18]
	},
	[106004] = {
		[60] = dataList[19],
		[120] = dataList[20],
		[200] = dataList[21],
		[300] = dataList[22],
		[400] = dataList[23],
		[500] = dataList[24]
	},
	[106005] = {
		[100] = dataList[25],
		[200] = dataList[26],
		[300] = dataList[27],
		[400] = dataList[28],
		[500] = dataList[29],
		[600] = dataList[30],
		[800] = dataList[31]
	}
}

t_excellent_class_score_new.dataList = dataList

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

return t_excellent_class_score_new
