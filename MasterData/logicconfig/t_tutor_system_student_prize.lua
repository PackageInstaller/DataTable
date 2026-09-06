-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_student_prize.lua

module("logicconfig.config.t_tutor_system_student_prize", package.seeall)

local title = {
	prizeId = 1,
	isFinishTutor = 4,
	prize = 3,
	scoreLimit = 2
}
local dataList = {
	{
		1,
		50,
		"4:31:5",
		false
	},
	{
		2,
		100,
		"104:2:500",
		false
	},
	{
		3,
		150,
		"4:31:5",
		false
	},
	{
		4,
		200,
		"4:31:5",
		false
	},
	{
		5,
		260,
		"4:510021:1",
		false
	},
	{
		6,
		300,
		"4:31:5",
		false
	},
	{
		7,
		320,
		"4:31:5",
		false
	},
	{
		8,
		340,
		"104:2:500",
		false
	},
	{
		9,
		360,
		"4:31:5",
		false
	},
	{
		10,
		380,
		"4:31:5",
		false
	},
	{
		11,
		400,
		"4:36:10",
		false
	},
	{
		12,
		420,
		"104:2:1000",
		false
	},
	{
		13,
		435,
		"4:36:10",
		false
	},
	{
		14,
		450,
		"4:70003:1",
		true
	}
}
local t_tutor_system_student_prize = {
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
	dataList[14]
}

t_tutor_system_student_prize.dataList = dataList

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

return t_tutor_system_student_prize
