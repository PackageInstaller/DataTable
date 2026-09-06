-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_red.lua

module("logicconfig.config.t_tutor_system_red", package.seeall)

local title = {
	redType = 1,
	isUse = 3,
	masterRedId = 2
}
local dataList = {
	{
		1,
		"-289",
		false
	},
	{
		2,
		"-290",
		true
	},
	{
		3,
		"-291",
		false
	},
	{
		4,
		"-292",
		true
	},
	{
		5,
		"-293",
		false
	},
	{
		6,
		"-294",
		false
	}
}
local t_tutor_system_red = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_tutor_system_red.dataList = dataList

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

return t_tutor_system_red
