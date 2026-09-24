-- chunkname: @modules/logic/college/defines/CollegeStatEnum.lua

module("modules.logic.college.defines.CollegeStatEnum", package.seeall)

local CollegeStatEnum = _M
local StatEnum = StatEnum

CollegeStatEnum.EventName = {
	College_ButtonClick = "college_button_click",
	College_CloseView = "college_exit_interface",
	College_MapElement = "map_element",
	College_Exit = "Exit_college"
}
CollegeStatEnum.EventProperties = {
	College_Time = "time",
	College_Stage = "college_stage",
	College_Location = "college_location",
	College_ElementId = "mapelementid",
	College_UseTime = "useTime",
	College_ButtonName = "button_name",
	College_Building = "college_building",
	College_Currency = "college_currency",
	College_ActorList = "college_actor_list",
	College_Actor = "college_actor",
	College_InterfaceName = "interface_name",
	College_Round = "totalround"
}
CollegeStatEnum.PropertyTypes = {
	[CollegeStatEnum.EventProperties.College_Stage] = StatEnum.Type.Number,
	[CollegeStatEnum.EventProperties.College_Round] = StatEnum.Type.Number,
	[CollegeStatEnum.EventProperties.College_Actor] = StatEnum.Type.Array,
	[CollegeStatEnum.EventProperties.College_Currency] = StatEnum.Type.Array,
	[CollegeStatEnum.EventProperties.College_Building] = StatEnum.Type.Array,
	[CollegeStatEnum.EventProperties.College_Location] = StatEnum.Type.Array,
	[CollegeStatEnum.EventProperties.College_UseTime] = StatEnum.Type.Number,
	[CollegeStatEnum.EventProperties.College_InterfaceName] = StatEnum.Type.String,
	[CollegeStatEnum.EventProperties.College_ButtonName] = StatEnum.Type.String,
	[CollegeStatEnum.EventProperties.College_ElementId] = StatEnum.Type.Number,
	[CollegeStatEnum.EventProperties.College_Time] = StatEnum.Type.String
}
CollegeStatEnum.ViewName = {
	Milestone = "白夜岸读会",
	Recruit = "招募界面",
	Main = "学院场景主界面",
	Main_Map = "探索地图",
	Refined = "刷新词条界面"
}
CollegeStatEnum.BtnName = {
	Milestone = "白夜岸读会",
	Explore = "探索",
	TaskDetail = "任务详情",
	CoinTips = "余光详情",
	Role = "角色",
	HideUI = "隐藏UI",
	Relation = "群像分析"
}

local function repeatError(key, val1, val2)
	logError("重复定义Key！" .. key)
end

local function repeatError2(key, val1, val2)
	if val1 == val2 then
		return
	end

	logError("Key 对应的值不一致！" .. key .. " " .. val1 .. " " .. val2)
end

local repeatKeyFunc = {
	EventName = repeatError,
	EventProperties = repeatError,
	PropertyTypes = repeatError2
}

for k, v in pairs(repeatKeyFunc) do
	local tb = StatEnum[k]

	if tb then
		for k2, v2 in pairs(CollegeStatEnum[k]) do
			if tb[k2] then
				v(k2, tb[k2], v2)
			end

			tb[k2] = v2
		end
	else
		logError("未定义的Key！" .. k)
	end
end

return CollegeStatEnum
