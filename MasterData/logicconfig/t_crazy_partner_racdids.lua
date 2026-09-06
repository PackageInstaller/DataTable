-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_crazy_partner_racdids.lua

module("logicconfig.config.t_crazy_partner_racdids", package.seeall)

local title = {
	challengeId = 1,
	raceIds = 2
}
local dataList = {
	{
		1,
		{
			90018,
			90205,
			70326
		}
	},
	{
		2,
		{
			90082,
			90130,
			97000
		}
	},
	{
		3,
		{
			90204,
			90131,
			96003
		}
	},
	{
		4,
		{
			90360,
			70313,
			96004
		}
	},
	{
		5,
		{
			90332,
			90027,
			80060
		}
	},
	{
		6,
		{
			90309,
			80129,
			90314
		}
	}
}
local t_crazy_partner_racdids = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_crazy_partner_racdids.dataList = dataList

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

return t_crazy_partner_racdids
