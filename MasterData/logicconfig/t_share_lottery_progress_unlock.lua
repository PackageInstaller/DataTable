-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_share_lottery_progress_unlock.lua

module("logicconfig.config.t_share_lottery_progress_unlock", package.seeall)

local title = {
	pos = 4,
	lockTips = 5,
	bgName = 7,
	needProgress = 3,
	index = 2,
	boardName = 8,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		448001,
		1,
		5000,
		{
			-334.9,
			40.6,
			1,
			13.52
		},
		"全服进度达5000\r\n解锁",
		"2.21上线\r\n美食萌主·奶龙",
		"nailonglottery/board_liandongfxcj_09",
		"activitypopup/board_tc340"
	},
	{
		448001,
		2,
		10000,
		{
			-107.6,
			98,
			1,
			-2.43
		},
		"全服进度达10000\r\n解锁",
		"2.21上线\r\n暴运迎金·暴暴龙",
		"nailonglottery/board_liandongfxcj_07",
		"activitypopup/board_tc341"
	},
	{
		448001,
		3,
		20000,
		{
			108.9,
			86.8,
			1,
			5
		},
		"全服进度达20000\r\n解锁",
		"2.28上线\r\n御金耀世·光耀圣龙",
		"nailonglottery/board_liandongfxcj_11",
		"activitypopup/board_tc343"
	},
	{
		448001,
		4,
		30000,
		{
			345.2,
			80.7,
			1,
			-9
		},
		"全服进度达30000\r\n解锁",
		"2.28上线\r\n光子元墟·光耀神女",
		"nailonglottery/board_liandongfxcj_12",
		"activitypopup/board_tc342"
	}
}
local t_share_lottery_progress_unlock = {
	[448001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_share_lottery_progress_unlock.dataList = dataList

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

return t_share_lottery_progress_unlock
