-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_impression_stickers_fix_rank.lua

module("logicconfig.config.t_impression_stickers_fix_rank", package.seeall)

local title = {
	startTime = 4,
	name = 3,
	bgUrl = 6,
	endTime = 5,
	stickerId = 1,
	fixTarget = 2
}
local dataList = {
	{
		1,
		"a2025crpt",
		"斐希司印象贴",
		"2025-01-01T05:00:00",
		"2025-12-31T23:59:59",
		"board_tc320"
	},
	{
		8,
		"16040",
		"神曜敖九印象贴",
		"2025-09-04T16:00:00",
		"2026-09-04T23:59:59",
		"board_tc419"
	},
	{
		18,
		"17029",
		"源起龙主印象贴",
		"2026-04-30T05:00:00",
		"2027-04-30T05:00:00",
		"board_tc_516"
	},
	{
		21,
		"16048",
		"源起双生龙印象贴",
		"2026-08-14T05:00:00",
		"2027-08-14T05:00:00",
		"board_tc_549"
	}
}
local t_impression_stickers_fix_rank = {
	dataList[1],
	[8] = dataList[2],
	[18] = dataList[3],
	[21] = dataList[4]
}

t_impression_stickers_fix_rank.dataList = dataList

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

return t_impression_stickers_fix_rank
