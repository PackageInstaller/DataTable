-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_packet_red.lua

module("logicconfig.config.t_family_packet_red", package.seeall)

local title = {
	people = 5,
	name = 2,
	dailyLimit = 6,
	packetType = 1,
	num = 4,
	prize = 3
}
local dataList = {
	{
		1,
		"至尊红包",
		"104:2",
		1000,
		20,
		1
	},
	{
		2,
		"豪华红包",
		"104:2",
		150,
		10,
		3
	},
	{
		3,
		"普通红包",
		"104:2",
		25,
		5,
		5
	}
}
local t_family_packet_red = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_family_packet_red.dataList = dataList

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

return t_family_packet_red
