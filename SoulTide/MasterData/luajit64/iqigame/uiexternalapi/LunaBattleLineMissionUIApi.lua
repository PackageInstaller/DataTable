-- chunkname: @IQIGame\\UIExternalApi\\LunaBattleLineMissionUIApi.lua

LunaBattleLineMissionUIApi = BaseLangApi:Extend()

function LunaBattleLineMissionUIApi:Init()
	self:RegisterApi("TaskItemProgressText", self.GetTaskItemProgressText)
	self:RegisterApi("TaskItemFunctionBtnText", self.GetTaskItemFunctionBtnText)
	self:RegisterApi("TitleText", self.GetTitleText)
	self:RegisterApi("WorldTaskNameText", self.GetWorldTaskNameText)
	self:RegisterApi("WorldTaskProgressText", self.GetWorldTaskProgressText)
end

function LunaBattleLineMissionUIApi:GetTaskItemProgressText(finishNum, targetNum)
	return string.format("%s/%s", finishNum, targetNum)
end

function LunaBattleLineMissionUIApi:GetTaskItemFunctionBtnText(state)
	if state == 1 then
		return self:GetCfgText(3600031)
	elseif state == 2 then
		return self:GetCfgText(3600032)
	elseif state == 3 then
		return self:GetCfgText(3600033)
	end
end

function LunaBattleLineMissionUIApi:GetTitleText()
	return self:GetCfgText(3600034)
end

function LunaBattleLineMissionUIApi:GetWorldTaskNameText(finishNum, targetNum, targetDesc)
	return string.format(self:GetCfgText(3600035), finishNum, targetNum)
end

function LunaBattleLineMissionUIApi:GetWorldTaskProgressText(finishNum, targetNum)
	return math.floor(finishNum / targetNum * 100) .. "%"
end

LunaBattleLineMissionUIApi:Init()
