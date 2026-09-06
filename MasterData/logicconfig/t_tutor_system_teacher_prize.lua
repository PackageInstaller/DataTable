-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_teacher_prize.lua

module("logicconfig.config.t_tutor_system_teacher_prize", package.seeall)

local title = {
	prizeId = 1,
	prize = 3,
	number = 2
}
local dataList = {
	{
		1,
		1,
		"8:30:500"
	},
	{
		2,
		2,
		"8:30:500#2:44:1"
	},
	{
		3,
		3,
		"8:30:1000"
	},
	{
		4,
		4,
		"8:30:1000"
	}
}
local t_tutor_system_teacher_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_tutor_system_teacher_prize.dataList = dataList

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

return t_tutor_system_teacher_prize
