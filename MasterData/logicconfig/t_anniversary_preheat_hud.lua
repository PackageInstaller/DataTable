-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_preheat_hud.lua

module("logicconfig.config.t_anniversary_preheat_hud", package.seeall)

local title = {
	jumpTo = 5,
	txtDesc = 4,
	endTime = 7,
	showPicPath = 3,
	Id = 2,
	offlineTip = 8,
	activityId = 1,
	startTime = 6
}
local dataList = {
	{
		141001,
		1,
		"board_znq_06",
		"周年神宠\n活跃得",
		"func#9&&report_behavior#200871",
		"2022-04-01T05:00:00",
		"2022-05-01T05:00:00",
		"活动将于4月1日开启，周年宠蜜蕊可活跃得！"
	},
	{
		141001,
		2,
		"board_znq_10",
		"通灵师极\n活跃得",
		"func#9&&report_behavior#200872",
		"2022-04-01T05:00:00",
		"2022-05-01T05:00:00",
		"活动将于4月15日开启，新职业通灵师极活跃得！"
	},
	{
		141001,
		3,
		"board_znq_08",
		"光明王皮肤\n签到得",
		"func#9&&report_behavior#200873",
		"2022-04-01T05:00:00",
		"2022-05-01T05:00:00",
		"活动将于4月1日开启，签到得光明王皮肤！"
	},
	{
		141001,
		4,
		"board_znq_05",
		"周年七大特权\n人人享",
		"func#9&&report_behavior#200874",
		"2022-04-01T05:00:00",
		"2022-05-01T05:00:00",
		"活动将于4月1日开启，周年特权金钻卡免费体验、星神5换1等7大特权！"
	},
	{
		141001,
		5,
		"board_znq_03",
		"完美养成\n活跃得",
		"func#9&&report_behavior#200875",
		"2022-04-01T05:00:00",
		"2022-05-01T05:00:00",
		"活动将于4月1日开启，一套完美养成道具活跃得！"
	},
	{
		141001,
		6,
		"board_znq_09",
		"200抽\n签到得",
		"func#9&&report_behavior#200876",
		"2022-04-01T05:00:00",
		"2022-05-01T05:00:00",
		"活动将于4月1日开启，签到送神唤券&神炼石等共计200抽！"
	},
	{
		141001,
		7,
		"board_znq_07",
		"无烬圣龙\n挑战得",
		"func#9&&report_behavior#200877",
		"2022-04-01T05:00:00",
		"2022-05-01T05:00:00",
		"活动将于4月1日开启，无烬圣龙挑战得！"
	},
	{
		141001,
		8,
		"board_znq_04",
		"周年竞技赛\n新玩法",
		"func#9&&report_behavior#200878",
		"2022-04-01T05:00:00",
		"2022-05-01T05:00:00",
		"活动将于4月1日开启，畅玩新玩法周年竞技赛！"
	}
}
local t_anniversary_preheat_hud = {
	[141001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_anniversary_preheat_hud.dataList = dataList

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

return t_anniversary_preheat_hud
