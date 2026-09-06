-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_level.lua

module("logicconfig.config.t_kindergarten_level", package.seeall)

local title = {
	needClassroomLv = 3,
	classStudentCount = 7,
	classCount = 4,
	pointMaxLimit = 8,
	studentLimit = 6,
	pointMinLimit = 9,
	dailyClassTimes = 5,
	activityId = 1,
	level = 2
}
local dataList = {
	{
		353001,
		1,
		1,
		1,
		4,
		100,
		10,
		20,
		1
	},
	{
		353001,
		2,
		2,
		2,
		4,
		200,
		10,
		25,
		1
	},
	{
		353001,
		3,
		3,
		2,
		4,
		300,
		15,
		30,
		1
	},
	{
		353001,
		4,
		4,
		3,
		4,
		450,
		15,
		40,
		1
	},
	{
		353001,
		5,
		5,
		3,
		4,
		600,
		20,
		50,
		1
	},
	{
		353001,
		6,
		6,
		4,
		4,
		800,
		20,
		60,
		1
	},
	{
		353001,
		7,
		7,
		4,
		4,
		1200,
		30,
		80,
		1
	}
}
local t_kindergarten_level = {
	[353001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_kindergarten_level.dataList = dataList

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

return t_kindergarten_level
