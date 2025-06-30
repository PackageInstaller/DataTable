-- chunkname: @IQIGame\\UIExternalApi\\GuildMissionUIApi.lua

GuildMissionUIApi = BaseLangApi:Extend()

function GuildMissionUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("DailyTaskTitle", self.GetDailyTaskTitle)
	self:RegisterApi("WeeklyTaskTitle", self.GetWeeklyTaskTitle)
	self:RegisterApi("GetAllTaskBtnLabel", self.GetGetAllTaskBtnLabel)
	self:RegisterApi("TaskItemProgressText", self.GetTaskItemProgressText)
	self:RegisterApi("TaskItemPercentText", self.GetTaskItemPercentText)
	self:RegisterApi("TaskItemFunctionBtnText", self.GetTaskItemFunctionBtnText)
	self:RegisterApi("StateText", self.GetStateText)
	self:RegisterApi("GetAllWeeklyBtn", self.GetGetAllWeeklyBtn)
	self:RegisterApi("LookRewardBtn", self.GetLookRewardBtn)
	self:RegisterApi("TextActivePoint", self.GetTextActivePoint)
end

function GuildMissionUIApi:GetTextActivePoint(num)
	return string.format(self:GetCfgText(9100201), num)
end

function GuildMissionUIApi:GetLookRewardBtn()
	return self:GetCfgText(9100202)
end

function GuildMissionUIApi:GetGetAllWeeklyBtn()
	return self:GetCfgText(9100203)
end

function GuildMissionUIApi:GetStateText(num, maxNum)
	return string.format("%s/<color=#ccffff>%s</color>", num, maxNum)
end

function GuildMissionUIApi:GetTaskItemProgressText(finishNum, targetNum)
	return string.format("(<size=22>%s</size>/%s)", finishNum, targetNum)
end

function GuildMissionUIApi:GetTaskItemPercentText(finishNum, targetNum)
	local percent = math.floor(finishNum / targetNum * 100)

	return string.format("%s%%", percent)
end

function GuildMissionUIApi:GetTaskItemFunctionBtnText(state)
	if state == 1 then
		return self:GetCfgText(3700201)
	elseif state == 2 then
		return self:GetCfgText(3600032)
	elseif state == 3 then
		return self:GetCfgText(3600033)
	end
end

function GuildMissionUIApi:GetGetAllTaskBtnLabel()
	return self:GetCfgText(9100203)
end

function GuildMissionUIApi:GetWeeklyTaskTitle()
	return self:GetCfgText(9100204)
end

function GuildMissionUIApi:GetDailyTaskTitle()
	return self:GetCfgText(9100205)
end

function GuildMissionUIApi:GetTitleText()
	return self:GetCfgText(9100206)
end

GuildMissionUIApi:Init()
