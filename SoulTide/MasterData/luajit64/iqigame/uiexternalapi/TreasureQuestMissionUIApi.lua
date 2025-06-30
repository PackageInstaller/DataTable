-- chunkname: @IQIGame\\UIExternalApi\\TreasureQuestMissionUIApi.lua

TreasureQuestMissionUIApi = BaseLangApi:Extend()

function TreasureQuestMissionUIApi:Init()
	self:RegisterApi("TaskTitleText", self.GetTaskTitleText)
	self:RegisterApi("ProgressText", self.GetProgressText)
	self:RegisterApi("Item_StateText", self.GetItem_StateText)
	self:RegisterApi("Item_RewardNumText", self.GetItem_RewardNumText)
	self:RegisterApi("Item_TargetProgressText", self.GetItem_TargetProgressText)
end

function TreasureQuestMissionUIApi:GetTaskTitleText(type)
	if type == 1 then
		return self:GetCfgText(2900111)
	else
		return self:GetCfgText(2900112)
	end
end

function TreasureQuestMissionUIApi:GetProgressText(nowNum, targetNum)
	return string.format("%s/%s", nowNum, targetNum)
end

function TreasureQuestMissionUIApi:GetItem_StateText(state)
	if state == 1 then
		return self:GetCfgText(2900113)
	elseif state == 3 then
		return self:GetCfgText(2900114)
	end

	return "???"
end

function TreasureQuestMissionUIApi:GetItem_RewardNumText(num)
	return string.format("x%s", num)
end

function TreasureQuestMissionUIApi:GetItem_TargetProgressText(name, finishedNum, targetNum)
	return string.format("%s(%s/%s)", name, finishedNum, targetNum)
end

TreasureQuestMissionUIApi:Init()
