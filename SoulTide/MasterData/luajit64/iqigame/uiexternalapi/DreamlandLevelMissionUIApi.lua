-- chunkname: @IQIGame\\UIExternalApi\\DreamlandLevelMissionUIApi.lua

DreamlandLevelMissionUIApi = BaseLangApi:Extend()

function DreamlandLevelMissionUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TaskItemProgressText", self.GetTaskItemProgressText)
	self:RegisterApi("TaskItemPercentText", self.GetTaskItemPercentText)
	self:RegisterApi("TaskItemFunctionBtnText", self.GetTaskItemFunctionBtnText)
end

function DreamlandLevelMissionUIApi:GetTitleText()
	return self:GetCfgText(3700202)
end

function DreamlandLevelMissionUIApi:GetTaskItemProgressText(finishNum, targetNum)
	return string.format("(%s/%s)", finishNum, targetNum)
end

function DreamlandLevelMissionUIApi:GetTaskItemPercentText(finishNum, targetNum)
	local percent = math.floor(finishNum / targetNum * 100)

	return string.format("%s%%", percent)
end

function DreamlandLevelMissionUIApi:GetTaskItemFunctionBtnText(state)
	if state == 1 then
		return self:GetCfgText(3700201)
	elseif state == 2 then
		return self:GetCfgText(3600032)
	elseif state == 3 then
		return self:GetCfgText(3600033)
	end
end

DreamlandLevelMissionUIApi:Init()
