-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiaonuoplacerank.lua

module("logicconfig.config.t_xiaonuoplacerank", package.seeall)

local title = {
	startRank = 1,
	prize = 3,
	endRank = 2
}
local dataList = {
	{
		1,
		3,
		"8:11:2000#104:2:100#8:1:50000"
	},
	{
		4,
		10,
		"8:11:1500#104:2:80#8:1:30000"
	},
	{
		11,
		50,
		"8:11:1000#104:2:60#8:1:20000"
	},
	{
		51,
		100,
		"8:11:800#104:2:50#8:1:10000"
	}
}
local t_xiaonuoplacerank = {
	dataList[1],
	[4] = dataList[2],
	[11] = dataList[3],
	[51] = dataList[4]
}

t_xiaonuoplacerank.dataList = dataList

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

return t_xiaonuoplacerank
