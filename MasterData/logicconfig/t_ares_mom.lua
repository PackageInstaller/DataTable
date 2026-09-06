-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ares_mom.lua

module("logicconfig.config.t_ares_mom", package.seeall)

local title = {
	itemId = 4,
	comPlanId = 2,
	redPointId = 6,
	progress = 3,
	petPrize = 5,
	challengeId = 1
}
local dataList = {
	{
		51,
		1,
		2400,
		"10:2130001",
		"100:13006:1:1",
		342
	},
	{
		127,
		2,
		2400,
		"10:2130002",
		"4:510214:100",
		520
	}
}
local t_ares_mom = {
	[51] = dataList[1],
	[127] = dataList[2]
}

t_ares_mom.dataList = dataList

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

return t_ares_mom
