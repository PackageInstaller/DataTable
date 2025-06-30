-- chunkname: @IQIGame\\Module\\WorldMap\\WorldMapComponentData.lua

local WorldMapComponentData = {}
local ActionClass = require("IQIGame/Module/WorldMap/WorldMapComponentActionData")

function WorldMapComponentData.New(cfgComponent, componentPod, actionsPod)
	local o = Clone(WorldMapComponentData)

	o:Initialize(cfgComponent, componentPod, actionsPod)

	return o
end

function WorldMapComponentData:Initialize(cfgComponent, componentPod, actionsPod)
	self.cfgComponent = cfgComponent
	self.cid = cfgComponent.Id
	self.pos = Vector3.zero
	self.roomCid = self.cfgComponent.RoomId

	if cfgComponent.Location and #cfgComponent.Location == 3 then
		self.pos = Vector3.New(cfgComponent.Location[1], cfgComponent.Location[2], cfgComponent.Location[3])
	end

	self:ReloadPodData(componentPod)

	self.actionList = {}

	for i, v in pairs(CfgWorldRoomActionTable) do
		if v.CompId == self.cid then
			self.actionList[i] = ActionClass.New(v, actionsPod[i] and actionsPod[i] or nil)
			WorldMapModule.componentsActionDataList[i] = self.actionList[i]
		end
	end
end

function WorldMapComponentData:GetCfg()
	return self.cfgComponent
end

function WorldMapComponentData:GetActionList()
	return self.actionList
end

function WorldMapComponentData:RemoveOnActionList(actionId)
	self.actionList[actionId] = nil
end

function WorldMapComponentData:AddOnActionList(actionId, actionData)
	self.actionList[actionId] = actionData
end

function WorldMapComponentData:GetActive()
	if self.status then
		return self.status == Constant.WorldMapStatus.Show
	end

	local state = false

	if self.cfgComponent.ShowType == 1 then
		state = ConditionModule.CheckConditionIsAllPass(self:GetCfg().UnlockCondition)
	elseif self.cfgComponent.ShowType == 2 then
		state = ConditionModule.CheckConditionIsAllPass(self:GetCfg().UnlockCondition) and self:GetActionCount() > 0
	else
		state = ConditionModule.CheckConditionIsAllPass(self:GetCfg().UnlockCondition)
	end

	return state
end

function WorldMapComponentData:GetActionCount()
	local count = 0

	for _, v in pairs(self.actionList) do
		if v:CheckCanAct() then
			count = count + 1
		end
	end

	return count
end

function WorldMapComponentData:ReloadPodData(componentPod)
	if not componentPod then
		return
	end

	self.cid = componentPod.cid

	if self.roomCid ~= componentPod.roomCid then
		local currentRoomData = WorldMapModule.GetRoomDataWithRoomID(self.roomCid)

		if currentRoomData then
			currentRoomData:RemoveOnComponentList(self.cid)
		end

		local targetRoomData = WorldMapModule.GetRoomDataWithRoomID(componentPod.roomCid)

		if targetRoomData then
			targetRoomData:AddOnComponentList(self.roomCid, self)
		end
	end

	self.roomCid = componentPod.roomCid

	if componentPod.status and componentPod.status ~= 0 then
		self.status = componentPod.status
	end

	if componentPod.vectorPOD then
		self.pos = componentPod.vectorPOD
	end
end

return WorldMapComponentData
