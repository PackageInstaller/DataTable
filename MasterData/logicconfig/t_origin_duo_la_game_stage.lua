-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_duo_la_game_stage.lua

module("logicconfig.config.t_origin_duo_la_game_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 3,
	gamePlanId = 6,
	showPicPath = 5,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		597001,
		1,
		"2026-05-29T05:00:00",
		"4:510802:4",
		"mengzhidui/emoji_mengzhidui_16",
		1
	},
	{
		597001,
		2,
		"2026-05-29T05:00:00",
		"4:510802:4",
		"mengzhidui/emoji_mengzhidui_16",
		2
	},
	{
		597001,
		3,
		"2026-05-29T05:00:00",
		"4:510802:4",
		"mengzhidui/emoji_mengzhidui_14",
		3
	},
	{
		597001,
		4,
		"2026-05-29T05:00:00",
		"4:510802:4",
		"mengzhidui/emoji_mengzhidui_14",
		4
	},
	{
		597001,
		5,
		"2026-05-29T05:00:00",
		"4:510802:4",
		"mengzhidui/emoji_mengzhidui_14",
		5
	},
	{
		597001,
		6,
		"2026-05-30T05:00:00",
		"4:510802:6",
		"mengzhidui/emoji_mengzhidui_03",
		6
	},
	{
		597001,
		7,
		"2026-05-30T05:00:00",
		"4:510802:6",
		"mengzhidui/emoji_mengzhidui_03",
		7
	},
	{
		597001,
		8,
		"2026-05-30T05:00:00",
		"4:510802:6",
		"mengzhidui/emoji_mengzhidui_12",
		8
	},
	{
		597001,
		9,
		"2026-05-30T05:00:00",
		"4:510802:6",
		"mengzhidui/emoji_mengzhidui_12",
		9
	},
	{
		597001,
		10,
		"2026-05-30T05:00:00",
		"4:510802:6",
		"mengzhidui/emoji_mengzhidui_12",
		10
	},
	{
		597001,
		11,
		"2026-05-31T05:00:00",
		"4:510802:10",
		"mengzhidui/emoji_mengzhidui_02",
		11
	},
	{
		597001,
		12,
		"2026-05-31T05:00:00",
		"4:510802:10",
		"mengzhidui/emoji_mengzhidui_02",
		12
	},
	{
		597001,
		13,
		"2026-05-31T05:00:00",
		"4:510802:10",
		"mengzhidui/emoji_mengzhidui_13",
		13
	},
	{
		597001,
		14,
		"2026-05-31T05:00:00",
		"4:510802:10",
		"mengzhidui/emoji_mengzhidui_13",
		14
	},
	{
		597001,
		15,
		"2026-05-31T05:00:00",
		"4:510802:10",
		"mengzhidui/emoji_mengzhidui_13",
		15
	}
}
local t_origin_duo_la_game_stage = {
	[597001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_origin_duo_la_game_stage.dataList = dataList

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

return t_origin_duo_la_game_stage
