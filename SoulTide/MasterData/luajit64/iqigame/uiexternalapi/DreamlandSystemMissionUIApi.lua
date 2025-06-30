-- chunkname: @IQIGame\\UIExternalApi\\DreamlandSystemMissionUIApi.lua

DreamlandSystemMissionUIApi = BaseLangApi:Extend()

function DreamlandSystemMissionUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TaskItemProgressText", self.GetTaskItemProgressText)
	self:RegisterApi("TaskItemPercentText", self.GetTaskItemPercentText)
	self:RegisterApi("TaskItemFunctionBtnText", self.GetTaskItemFunctionBtnText)
end

function DreamlandSystemMissionUIApi:GetTitleText()
	return self:GetCfgText(3600034)
end

function DreamlandSystemMissionUIApi:GetTaskItemProgressText(finishNum, targetNum)
	return string.format("%s/%s", finishNum, targetNum)
end

function DreamlandSystemMissionUIApi:GetTaskItemPercentText(finishNum, targetNum)
	local percent = math.floor(finishNum / targetNum * 100)

	return string.format("%s%%", percent)
end

function DreamlandSystemMissionUIApi:GetTaskItemFunctionBtnText(state)
	if state == 1 then
		return self:GetCfgText(3700201)
	elseif state == 2 then
		return self:GetCfgText(3600032)
	elseif state == 3 then
		return self:GetCfgText(3600033)
	end
end

DreamlandSystemMissionUIApi:Init()
