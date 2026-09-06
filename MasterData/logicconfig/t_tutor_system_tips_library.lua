-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_tips_library.lua

module("logicconfig.config.t_tutor_system_tips_library", package.seeall)

local title = {
	value = 2,
	key = 1,
	sceneType = 3
}
local dataList = {
	{
		"14",
		"恭喜你收徒成功，与徒弟一起踏上快乐之旅吧",
		2
	},
	{
		"13",
		"恭喜你拜师成功，与师傅一起踏上快乐之旅吧",
		2
	},
	{
		"12",
		"师徒系统中，有同门学生进来啦",
		2
	},
	{
		"11",
		"已有学生和你解除师徒关系",
		2
	},
	{
		"10",
		"师徒关系解散，请重新拜师",
		2
	},
	{
		"9",
		"天下无不散的筵席，你的同门学生已经离开",
		2
	},
	{
		"8",
		"解除关系成功",
		2
	},
	{
		"7",
		"解除关系成功",
		2
	},
	{
		"6",
		"在你的循循教诲下，已有学生完成出师",
		1
	},
	{
		"5",
		"恭喜你出师成功！以后的路要自己走咯~",
		2
	},
	{
		"4",
		"已有同门学生出师，努力追赶他吧",
		2
	},
	{
		"3",
		"收到收徒请求，请前往师徒系统查看",
		1
	},
	{
		"2",
		"收到拜师请求，请前往师徒系统查看",
		1
	},
	{
		"1",
		"未发送",
		0
	},
	{
		"0",
		"已发送",
		0
	},
	{
		"-29901",
		"系统关系不存在",
		2
	},
	{
		"-29902",
		"当前不是学生",
		2
	},
	{
		"-29903",
		"任务未找到",
		2
	},
	{
		"-29904",
		"任务未完成",
		2
	},
	{
		"-29905",
		"老师未发布该成长任务",
		2
	},
	{
		"-29906",
		"请先领取前置奖励",
		2
	},
	{
		"-29907",
		"未满足成立师徒的条件",
		2
	},
	{
		"-29908",
		"不能邀请自己",
		2
	},
	{
		"-29909",
		"当前玩家战力已超过限制或已完成出师",
		2
	},
	{
		"-29910",
		"当前未达到规定战力",
		2
	},
	{
		"-29911",
		"老师方学生数量已满",
		2
	},
	{
		"-29912",
		"关系已解除",
		2
	},
	{
		"-29913",
		"12小时后才能解除师徒关系",
		2
	},
	{
		"-29914",
		"精灵已经在放置中",
		2
	},
	{
		"-29915",
		"我的好友列表已满",
		2
	},
	{
		"-29916",
		"对方的好友列表已满",
		2
	}
}
local t_tutor_system_tips_library = {
	["14"] = dataList[1],
	["13"] = dataList[2],
	["12"] = dataList[3],
	["11"] = dataList[4],
	["10"] = dataList[5],
	["9"] = dataList[6],
	["8"] = dataList[7],
	["7"] = dataList[8],
	["6"] = dataList[9],
	["5"] = dataList[10],
	["4"] = dataList[11],
	["3"] = dataList[12],
	["2"] = dataList[13],
	["1"] = dataList[14],
	["0"] = dataList[15],
	["-29901"] = dataList[16],
	["-29902"] = dataList[17],
	["-29903"] = dataList[18],
	["-29904"] = dataList[19],
	["-29905"] = dataList[20],
	["-29906"] = dataList[21],
	["-29907"] = dataList[22],
	["-29908"] = dataList[23],
	["-29909"] = dataList[24],
	["-29910"] = dataList[25],
	["-29911"] = dataList[26],
	["-29912"] = dataList[27],
	["-29913"] = dataList[28],
	["-29914"] = dataList[29],
	["-29915"] = dataList[30],
	["-29916"] = dataList[31]
}

t_tutor_system_tips_library.dataList = dataList

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

return t_tutor_system_tips_library
