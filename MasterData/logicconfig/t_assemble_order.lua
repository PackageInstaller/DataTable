-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_assemble_order.lua

module("logicconfig.config.t_assemble_order", package.seeall)

local title = {
	regressActivityId = 8,
	helpLimit = 2,
	newPlayerDay = 9,
	inviteLimit = 3,
	petId = 4,
	logoutDay = 7,
	shareUrl = 10,
	helpRegressionPrize = 6,
	timeStr = 5,
	activityId = 1
}
local dataList = {
	{
		143001,
		6,
		6,
		16008,
		"活动时间：2022.4.1 5:00 - 2022.4.29 5:00",
		"8:1:1000",
		30,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143002,
		6,
		6,
		17001,
		"活动时间：2022.7.15 5:00 - 2022.7.29 5:00",
		"8:1:1000",
		30,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143003,
		10,
		6,
		17002,
		"活动时间：2022.9.30 5:00 - 2022.10.14 5:00",
		"8:1:1000",
		30,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143004,
		10,
		6,
		17009,
		"活动时间：2022.11.25 5:00 - 2022.12.9 5:00",
		"104:2:1000#4:31:10#8:1:100000",
		30,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143005,
		10,
		6,
		1400601,
		"活动时间：2023.01.23 5:00 - 2023.02.10 5:00",
		"104:2:1000#4:31:10#8:1:100000",
		30,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143006,
		10,
		6,
		1032302,
		"活动时间：2023.07.28 5:00 - 2023.08.25 5:00",
		"104:2:1000#4:31:10#8:1:100000",
		30,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143007,
		10,
		6,
		14018,
		"活动时间：2023.11.24 5:00 - 2023.12.22 5:00",
		"104:2:1000#4:31:10#8:1:100000",
		30,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143008,
		10,
		6,
		1602401,
		"活动时间：2024.04.03 5:00 - 2024.04.30 5:00",
		"104:2:1000#4:31:10#8:1:100000",
		30,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143009,
		10,
		6,
		14026,
		"活动时间：2024.09.27 5:00 - 2024.10.25 5:00",
		"104:2:1000#4:31:10#8:1:100000",
		21,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20240403/xnsrh/?targetUserId="
	},
	{
		143010,
		10,
		6,
		12027,
		"活动时间：2025.01.24 5:00 - 2025.02.28 5:00",
		"8:25:600#104:2:1000#4:36:10",
		21,
		5,
		10,
		"http://pjaqm-h5.100bt.com/m/aqactivity/20250124/wzwj/?targetUserId="
	},
	{
		143011,
		10,
		6,
		15032,
		"活动时间：2025.04.03 5:00 - 2025.04.30 5:00",
		"8:25:600#104:2:1000#4:36:10",
		21,
		5,
		10,
		"http://pjaqm-h5.100bt.com/m/aqactivity/20250403/lyjd/?targetUserId="
	},
	{
		143012,
		10,
		6,
		15032,
		"活动时间：2025.07.18 5:00 - 2025.08.22 5:00",
		"8:25:600#104:2:1000#4:36:10",
		21,
		5,
		10,
		"http://pjaqm-h5.100bt.com/m/aqactivity/20250718/syfy/?targetUserId="
	},
	{
		143013,
		10,
		6,
		12038,
		"活动时间：2025.09.26 5:00 - 2025.10.24 5:00",
		"8:25:600#104:2:1000#4:36:10",
		21,
		5,
		10,
		"http://pjaqm-h5.100bt.com/m/aqactivity/20250926/syzf/?targetUserId="
	},
	{
		143014,
		10,
		6,
		12038,
		"活动时间：04.03 5:00 - 04.30 5:00",
		"8:25:600#104:2:1000#4:36:10",
		21,
		5,
		10,
		"https://pjaqm-h5.100bt.com/m/aqactivity/20260403/5zhounian/?targetUserId="
	}
}
local t_assemble_order = {
	[143001] = dataList[1],
	[143002] = dataList[2],
	[143003] = dataList[3],
	[143004] = dataList[4],
	[143005] = dataList[5],
	[143006] = dataList[6],
	[143007] = dataList[7],
	[143008] = dataList[8],
	[143009] = dataList[9],
	[143010] = dataList[10],
	[143011] = dataList[11],
	[143012] = dataList[12],
	[143013] = dataList[13],
	[143014] = dataList[14]
}

t_assemble_order.dataList = dataList

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

return t_assemble_order
