-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_zdl_prize.lua

module("logicconfig.config.t_tutor_system_zdl_prize", package.seeall)

local title = {
	zdl = 2,
	prizeId = 1,
	prize = 3
}
local dataList = {
	{
		1,
		100000,
		"4:90499:1"
	},
	{
		2,
		200000,
		"4:90145:2"
	},
	{
		3,
		400000,
		"4:510719:1"
	},
	{
		4,
		600000,
		"4:510720:1"
	},
	{
		5,
		800000,
		"4:510721:1"
	}
}
local t_tutor_system_zdl_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_tutor_system_zdl_prize.dataList = dataList

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

return t_tutor_system_zdl_prize
