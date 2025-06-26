-- chunkname: @IQIGame\\Module\\WorldMap\\WorldMapComponentActionData.lua

local WorldMapComponentActionData = {}

function WorldMapComponentActionData.New(cfgAction, actionPod)
	local o = Clone(WorldMapComponentActionData)

	o:Initialize(cfgAction, actionPod)

	return o
end

function WorldMapComponentActionData:Initialize(cfgAction, actionPod)
	self.cfgAction = cfgAction
	self.cid = self.cfgAction.Id
	self.status = 0
	self.compCid = self.cfgAction.CompId

	self:ReloadPodsData(actionPod)
end

function WorldMapComponentActionData:GetCfg()
	return self.cfgAction
end

function WorldMapComponentActionData:CheckCanAct()
	if self:GetCfg().ActionTag == Constant.RPGActionTagType.Saunter or self:GetCfg().ActionTag == Constant.RPGActionTagType.RandomChest then
		return self.status == Constant.WorldMapStatus.Show
	end

	if self.status and self.status ~= 0 then
		return self.status == Constant.WorldMapStatus.Show
	end

	if self:GetCfg().TriggerTimesMax ~= 0 and WorldMapModule.GetActionFinishedCount(self.cid) >= self:GetCfg().TriggerTimesMax then
		return false
	end

	return ConditionModule.CheckConditionIsAllPass(self:GetCfg().UnlockCondition)
end

function WorldMapComponentActionData:GetIsTag()
	return self.cfgAction.IconType ~= 0
end

function WorldMapComponentActionData:CheckIsActiveTag()
	if self.cfgAction.IconType == 0 then
		return false
	end

	if not self:CheckCanAct() then
		return false
	end

	if self:GetCfg().TriggerTimesMax ~= 0 and WorldMapModule.GetActionFinishedCount(self.cid) >= self:GetCfg().TriggerTimesMax then
		return false
	end

	return true
end

function WorldMapComponentActionData:GetRoomId()
	if not self.compCid then
		return
	end

	local comData = WorldMapModule.GetComponentDataWithId(self.compCid)

	if not comData then
		return
	end

	return comData.roomCid
end

function WorldMapComponentActionData:ReloadPodsData(actionPod)
	if not actionPod then
		return
	end

	self.cid = actionPod.cid

	if self.compCid ~= actionPod.compCid then
		local currentComponentData = WorldMapModule.GetComponentDataWithId(self.compCid)

		if currentComponentData then
			currentComponentData:RemoveOnActionList(self.cid)
		end

		local targetComponentData = WorldMapModule.GetComponentDataWithId(actionPod.compCid)

		if targetComponentData then
			targetComponentData:AddOnActionList(self.cid, self)
		end
	end

	self.compCid = actionPod.compCid

	if actionPod.status and actionPod.status ~= 0 then
		self.status = actionPod.status
	end
end

return WorldMapComponentActionData
