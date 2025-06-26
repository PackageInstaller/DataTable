-- chunkname: @IQIGame\\UIExternalApi\\MagicTowerSystemMissionUIApi.lua

MagicTowerSystemMissionUIApi = BaseLangApi:Extend()

function MagicTowerSystemMissionUIApi:Init()
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("TaskItemProgressText", self.GetTaskItemProgressText)
	self:RegisterApi("TaskItemPercentText", self.GetTaskItemPercentText)
	self:RegisterApi("TaskItemFunctionBtnText", self.GetTaskItemFunctionBtnText)
end

function MagicTowerSystemMissionUIApi:GetTitleText()
	return self:GetCfgText(3600034)
end

function MagicTowerSystemMissionUIApi:GetTaskItemProgressText(finishNum, targetNum)
	return string.format("%s/%s", finishNum, targetNum)
end

function MagicTowerSystemMissionUIApi:GetTaskItemPercentText(finishNum, targetNum)
	local percent = math.floor(finishNum / targetNum * 100)

	return string.format("%s%%", percent)
end

function MagicTowerSystemMissionUIApi:GetTaskItemFunctionBtnText(state)
	if state == 1 then
		return self:GetCfgText(3700201)
	elseif state == 2 then
		return self:GetCfgText(3600032)
	elseif state == 3 then
		return self:GetCfgText(3600033)
	end
end

MagicTowerSystemMissionUIApi:Init()
