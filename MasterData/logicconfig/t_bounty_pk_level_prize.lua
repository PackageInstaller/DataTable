-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bounty_pk_level_prize.lua

module("logicconfig.config.t_bounty_pk_level_prize", package.seeall)

local title = {
	sumPrize = 3,
	seasonId = 1,
	sumBounty = 2
}
local dataList = {
	{
		1,
		10000,
		"104:2:100#10:37001:1000#8:1:20000"
	},
	{
		1,
		20000,
		"104:2:100#10:37001:1000#8:1:20000"
	},
	{
		1,
		30000,
		"104:2:100#10:37001:1000#8:1:20000"
	},
	{
		1,
		40000,
		"104:2:100#10:37001:1000#8:1:20000"
	},
	{
		1,
		50000,
		"104:2:100#10:37001:1000#8:1:20000"
	}
}
local t_bounty_pk_level_prize = {
	{
		[10000] = dataList[1],
		[20000] = dataList[2],
		[30000] = dataList[3],
		[40000] = dataList[4],
		[50000] = dataList[5]
	}
}

t_bounty_pk_level_prize.dataList = dataList

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

return t_bounty_pk_level_prize
