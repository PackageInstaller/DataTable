-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_campaign_invite_type_prize.lua

module("logicconfig.config.t_campaign_invite_type_prize", package.seeall)

local title = {
	needCount = 4,
	prizeId = 2,
	prize = 5,
	type = 3,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		95001,
		1,
		1,
		1,
		"8:1:1",
		""
	},
	{
		95002,
		1,
		2,
		1,
		"8:1:1",
		""
	},
	{
		95003,
		1,
		3,
		1,
		"8:1:1",
		""
	},
	{
		95004,
		1,
		4,
		1,
		"8:1:1",
		""
	},
	{
		95005,
		1,
		1,
		1,
		"8:25:1200",
		""
	},
	{
		95005,
		2,
		2,
		1,
		"8:25:1200",
		""
	},
	{
		95006,
		1,
		1,
		1,
		"8:25:1200",
		""
	},
	{
		95006,
		2,
		2,
		1,
		"8:25:1200",
		""
	},
	{
		95007,
		1,
		1,
		1,
		"8:25:1200",
		""
	},
	{
		95007,
		2,
		2,
		1,
		"4:400002:100",
		""
	},
	{
		95008,
		1,
		1,
		1,
		"8:25:1200",
		""
	},
	{
		95008,
		2,
		2,
		1,
		"4:90312:1",
		""
	}
}
local t_campaign_invite_type_prize = {
	[95001] = {
		dataList[1]
	},
	[95002] = {
		dataList[2]
	},
	[95003] = {
		dataList[3]
	},
	[95004] = {
		dataList[4]
	},
	[95005] = {
		dataList[5],
		dataList[6]
	},
	[95006] = {
		dataList[7],
		dataList[8]
	},
	[95007] = {
		dataList[9],
		dataList[10]
	},
	[95008] = {
		dataList[11],
		dataList[12]
	}
}

t_campaign_invite_type_prize.dataList = dataList

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

return t_campaign_invite_type_prize
