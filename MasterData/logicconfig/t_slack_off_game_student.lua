-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_slack_off_game_student.lua

module("logicconfig.config.t_slack_off_game_student", package.seeall)

local title = {
	type = 4,
	studyPlanId = 6,
	progress = 5,
	restPlanId = 8,
	comboNeed = 10,
	studentName = 3,
	activityId = 1,
	finishedEmoji = 11,
	studyEmoji = 13,
	moodEmoji = 12,
	InspectButRestPlanId = 9,
	studyImg = 14,
	restImg = 15,
	inspectAndStudyPlanId = 7,
	studentId = 2
}
local dataList = {
	{
		442001,
		1,
		"真龙",
		"学佛",
		15,
		3,
		7,
		11,
		15,
		3,
		"icon_moyutubiao_04",
		"icon_moyutubiao_06",
		"icon_moyutubiao_03",
		"icon_moyutubiao_04",
		"icon_moyutubiao_06"
	},
	{
		442001,
		2,
		"蜜西西",
		"班花",
		15,
		4,
		8,
		12,
		16,
		3,
		"icon_moyutubiao_04",
		"icon_moyutubiao_01",
		"icon_moyutubiao_04",
		"icon_moyutubiao_04",
		"icon_moyutubiao_01"
	},
	{
		442001,
		3,
		"昆吾",
		"学霸",
		15,
		2,
		6,
		10,
		14,
		3,
		"icon_moyutubiao_04",
		"icon_moyutubiao_02",
		"icon_moyutubiao_04",
		"icon_moyutubiao_04",
		"icon_moyutubiao_02"
	},
	{
		442001,
		4,
		"无烬",
		"学渣",
		15,
		1,
		5,
		9,
		13,
		3,
		"icon_moyutubiao_04",
		"icon_moyutubiao_05",
		"icon_moyutubiao_03",
		"icon_moyutubiao_04",
		"icon_moyutubiao_05"
	}
}
local t_slack_off_game_student = {
	[442001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_slack_off_game_student.dataList = dataList

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

return t_slack_off_game_student
