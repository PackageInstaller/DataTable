-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scratch_lottery_cochannel_replacement.lua

module("logicconfig.config.t_scratch_lottery_cochannel_replacement", package.seeall)

local title = {
	bigPrizePlanId = 3,
	display = 4,
	activityId = 1,
	cochannelId = 2
}
local dataList = {
	{
		257048,
		{
			6
		},
		{
			13,
			14,
			15
		},
		{
			1202105,
			1403803,
			1604003,
			1802103,
			1603202,
			1603404,
			1503201,
			1602606,
			1800102,
			1202001,
			1602401,
			1402301,
			1401602,
			1601602,
			1601002,
			1101103,
			1700201,
			1600102
		}
	},
	{
		257051,
		{
			6
		},
		{
			13,
			14,
			15
		},
		{
			1702701,
			1202105,
			1403803,
			1604003,
			1802103,
			1603202,
			1603404,
			1503201,
			1602606,
			1800102,
			1202001,
			1602401,
			1402301,
			1401602,
			1601602,
			1601002,
			1101103,
			1700201,
			1600102
		}
	}
}
local t_scratch_lottery_cochannel_replacement = {
	[257048] = {
		[{
			6
		}] = dataList[1]
	},
	[257051] = {
		[{
			6
		}] = dataList[2]
	}
}

t_scratch_lottery_cochannel_replacement.dataList = dataList

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

return t_scratch_lottery_cochannel_replacement
