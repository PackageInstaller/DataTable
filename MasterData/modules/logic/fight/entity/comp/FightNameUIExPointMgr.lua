-- chunkname: @modules/logic/fight/entity/comp/FightNameUIExPointMgr.lua

module("modules.logic.fight.entity.comp.FightNameUIExPointMgr", package.seeall)

local FightNameUIExPointMgr = class("FightNameUIExPointMgr", UserDataDispose)
local HideExPointMonster = {
	[141102] = true
}

FightNameUIExPointMgr.LineCount = 6
FightNameUIExPointMgr.linePrefixX = 12
FightNameUIExPointMgr.lineTopY = 16

function FightNameUIExPointMgr:initMgr(goExPointContainer, entity)
	self:__onInit()

	self.goExPointContainer = goExPointContainer
	self.entity = entity
	self.entityId = self.entity.id
	self.pointItemList = {}
	self.hideExPoint = self:checkNeedShieldExPoint()

	if self.hideExPoint then
		gohelper.setActive(goExPointContainer, false)

		return
	end

	local entityMo = self.entity:getMO()

	self.entityConfig = entityMo:getCO()
	self.totalMaxExPoint = entityMo:getMaxExPoint()

	if not self.entityConfig then
		logError(string.format("entity 找不到配置表: entityType = %s  modelId = %s", self.entity:getMO().entityType, self.entity:getMO().modelId))
	end

	self:initGoPointPool()
	self:initExPointLine()
	self:initExPointItemList()
	self:initExtraExPointItemList()
	self:refreshPointItemCount()
	self:addCustomEvents()
	self:updateSelfExPoint()
end

local ForceShowExPointIdDict = {
	[10212131] = true,
	[10222111] = true,
	[10222131] = true,
	[10212111] = true,
	[10222121] = true,
	[10212121] = true
}

function FightNameUIExPointMgr:checkNeedShieldExPoint()
	local entityMo = self.entity:getMO()
	local modelId = entityMo and entityMo.modelId

	if modelId and ForceShowExPointIdDict[modelId] then
		return false
	end

	if HideExPointMonster[modelId] then
		return true
	end

	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]
	local bossIds = monsterGroupCO and monsterGroupCO.bossId
	local isBoss = bossIds and FightHelper.isBossId(bossIds, modelId)
	local isInBossRush = BossRushController.instance:isInBossRushFight()

	return isInBossRush and isBoss
end

function FightNameUIExPointMgr:initGoPointPool()
	self.exPointItemPool = {}
	self.extraPointItemPool = {}
	self.goPoolContainer = gohelper.create2d(self.goExPointContainer, "pointPool")

	gohelper.setActive(self.goPoolContainer, false)
end

function FightNameUIExPointMgr:initExPointLine()
	self.lineGroupList = self:getUserDataTb_()
	self.goLineGroupItem = gohelper.findChild(self.goExPointContainer, "exPointLine")

	gohelper.setActive(self.goLineGroupItem, false)

	self.initLineGroupAnchorX, self.initLineGroupAnchorY = recthelper.getAnchor(self.goLineGroupItem.transform)
end

function FightNameUIExPointMgr:addLineGroup(index)
	local go = gohelper.cloneInPlace(self.goLineGroupItem)

	gohelper.setActive(go, true)
	table.insert(self.lineGroupList, index, go)

	local transform = go:GetComponent(gohelper.Type_RectTransform)
	local anchorX, anchorY = self.initLineGroupAnchorX, self.initLineGroupAnchorY

	anchorX = anchorX + (index - 1) * FightNameUIExPointMgr.linePrefixX
	anchorY = anchorY - (index - 1) * FightNameUIExPointMgr.lineTopY

	recthelper.setAnchor(transform, anchorX, anchorY)

	return go
end

function FightNameUIExPointMgr:getLineGroup(index)
	if index < 1 then
		logError("激情点下标小于1 了？")

		return self.lineGroupList[1]
	end

	index = math.ceil(index / FightNameUIExPointMgr.LineCount)

	local goLineGroup = self.lineGroupList[index]

	goLineGroup = goLineGroup or self:addLineGroup(index)

	return goLineGroup
end

function FightNameUIExPointMgr:checkRemoveLineGroup()
	local len = #self.pointItemList
	local curLineGroupLen = #self.lineGroupList
	local lineGroupLen = math.ceil(len / FightNameUIExPointMgr.LineCount)

	while lineGroupLen < curLineGroupLen do
		local goLineGroup = self.lineGroupList[curLineGroupLen]

		table.remove(self.lineGroupList)
		gohelper.destroy(goLineGroup)

		curLineGroupLen = curLineGroupLen - 1
	end
end

function FightNameUIExPointMgr:initExPointItemList()
	self.exPointItemList = {}
	self.goPointItem = gohelper.findChild(self.goExPointContainer, "empty")

	gohelper.setActive(self.goPointItem, false)
end

function FightNameUIExPointMgr:initExtraExPointItemList()
	self.extraExPointItemList = {}

	local goExtraPointItem = gohelper.findChild(self.goExPointContainer, "extra")

	gohelper.setActive(goExtraPointItem, false)

	self.goExtraPointItem = goExtraPointItem
end

function FightNameUIExPointMgr:refreshPointItemCount()
	self:log(string.format("prePointCount : %s, exPointCount : %s, extraPointCount : %s", #self.pointItemList, #self.exPointItemList, #self.extraExPointItemList))

	for _, pointItem in ipairs(self.pointItemList) do
		if pointItem:getType() == FightNameUIExPointBaseItem.ExPointType.Normal then
			table.insert(self.exPointItemPool, pointItem)
		else
			table.insert(self.extraPointItemPool, pointItem)
		end

		pointItem:recycle(self.goPoolContainer)
	end

	tabletool.clear(self.pointItemList)
	tabletool.clear(self.exPointItemList)
	tabletool.clear(self.extraExPointItemList)

	local skillNeedPoint = self:getUniqueSkillNeedExPoint()

	self:log(string.format("totalCount : %s, skillNeedPoint : %s, extraPointCount : %s", self.totalMaxExPoint, skillNeedPoint, self.totalMaxExPoint - skillNeedPoint))

	for i = 1, self.totalMaxExPoint do
		if i <= skillNeedPoint then
			self:addPointItem(i)
		else
			self:addExtraPointItem(i)
		end
	end
end

function FightNameUIExPointMgr:addPointItem(index)
	local goLineGroup = self:getLineGroup(index)
	local pointItem

	if #self.exPointItemPool > 0 then
		pointItem = table.remove(self.exPointItemPool)

		gohelper.addChild(goLineGroup, pointItem:getPointGo())
	else
		local go = gohelper.clone(self.goPointItem, goLineGroup)

		pointItem = FightNameUIExPointItem.GetExPointItem(go)
	end

	pointItem.entityName = self.entity:getMO():getEntityName()

	table.insert(self.exPointItemList, pointItem)
	table.insert(self.pointItemList, pointItem)
	pointItem:setIndex(index)
	pointItem:setMgr(self)
end

function FightNameUIExPointMgr:removePointItem()
	local pointItem = table.remove(self.exPointItemList)

	self:assetPointItem(pointItem)

	if pointItem then
		pointItem:recycle(self.goPoolContainer)
		table.insert(self.exPointItemPool, pointItem)
	end

	tabletool.removeValue(self.pointItemList, pointItem)
	self:checkRemoveLineGroup()
end

function FightNameUIExPointMgr:addExtraPointItem(index)
	local entityMo = self.entity:getMO()

	if entityMo:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		self:addPointItem(index)

		return
	end

	local goLineGroup = self:getLineGroup(index)
	local pointItem

	if #self.extraPointItemPool > 0 then
		pointItem = table.remove(self.extraPointItemPool)

		gohelper.addChild(goLineGroup, pointItem:getPointGo())
	else
		local go = gohelper.clone(self.goExtraPointItem, goLineGroup)

		pointItem = FightNameUIExPointExtraItem.GetExtraExPointItem(go)
	end

	pointItem.entityName = self.entity:getMO():getEntityName()

	table.insert(self.extraExPointItemList, pointItem)
	table.insert(self.pointItemList, pointItem)
	pointItem:setIndex(index)
	pointItem:setMgr(self)
end

function FightNameUIExPointMgr:removeExtraPointItem()
	local entityMo = self.entity:getMO()

	if entityMo:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		self:removePointItem()

		return
	end

	local pointItem = table.remove(self.extraExPointItemList)

	self:assetPointItem(pointItem)

	if pointItem then
		pointItem:recycle(self.goPoolContainer)
		table.insert(self.extraPointItemPool, pointItem)
	end

	tabletool.removeValue(self.pointItemList, pointItem)
	self:checkRemoveLineGroup()
end

function FightNameUIExPointMgr:addCustomEvents()
	self.addEventCb(self, FightController.instance, FightEvent.AddPlayCardClientExPoint, self.addPlayCardClientExPoint, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateExPoint, self.updateExPoint, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnExpointMaxAdd, self.onExPointMaxAdd, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnBuffUpdate, self.onBuffUpdate, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnExPointChange, self.onExPointChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.MultiHpChange, self.onMultiHpChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnExSkillPointChange, self.onExSkillPointChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnStoreExPointChange, self.onStoreExPointChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.BeContract, self.onBeContract, self)
	self.addEventCb(self, FightController.instance, FightEvent.CoverPerformanceEntityData, self.onCoverPerformanceEntityData, self)
end

function FightNameUIExPointMgr:onBeContract(entityId)
	if self.entityId ~= entityId then
		return
	end

	AudioMgr.instance:trigger(20220175)

	local effectGo = gohelper.findChild(self.goExPointContainer, "#go_tianshinana")

	gohelper.setActive(effectGo, false)
	gohelper.setActive(effectGo, true)
	gohelper.setAsLastSibling(effectGo)
	self:updateSelfExPoint()
	TaskDispatcher.cancelTask(self.hideTsnnEffect, self)
	TaskDispatcher.runDelay(self.hideTsnnEffect, self, 1)
end

function FightNameUIExPointMgr:hideTsnnEffect()
	local effectGo = gohelper.findChild(self.goExPointContainer, "#go_tianshinana")

	gohelper.setActive(effectGo, false)
end

function FightNameUIExPointMgr:getClientExPoint()
	local entityMo = self.entity:getMO()

	return entityMo.exPoint + entityMo.moveCardExPoint + entityMo.playCardExPoint
end

function FightNameUIExPointMgr:getServerExPoint()
	return self.entity:getMO().exPoint
end

function FightNameUIExPointMgr:getUsedExPoint()
	return FightHelper.getPredeductionExpoint(self.entityId)
end

function FightNameUIExPointMgr:getUniqueSkillNeedExPoint()
	local skillNeedPoint = self.entity:getMO():getUniqueSkillPoint()

	self:log("大招需要激情点：" .. tostring(skillNeedPoint))

	return skillNeedPoint
end

function FightNameUIExPointMgr:getStoredExPoint()
	return self.entity:getMO():getStoredExPoint()
end

function FightNameUIExPointMgr:updateSelfExPoint()
	if self.hideExPoint then
		return
	end

	self:updateExPoint(self.entityId)
end

function FightNameUIExPointMgr:getPointCurState(pointIndex)
	local usePoint = self:getUsedExPoint()

	if usePoint > 0 then
		return self:getUsedPointCurState(pointIndex)
	else
		return self:getNoUsePointCurState(pointIndex)
	end
end

function FightNameUIExPointMgr:getUsedPointCurState(pointIndex)
	local storedPoint = self:getStoredExPoint()
	local skillNeedPoint = self:getUniqueSkillNeedExPoint()

	storedPoint = math.min(storedPoint, skillNeedPoint)

	if pointIndex <= storedPoint then
		return FightEnum.ExPointState.Stored
	end

	local clientPoint = self:getClientExPoint()
	local serverPoint = self:getServerExPoint()
	local usePoint = self:getUsedExPoint()
	local remainServerPoint = serverPoint - usePoint

	remainServerPoint = math.min(self.totalMaxExPoint, storedPoint + remainServerPoint)

	if pointIndex <= remainServerPoint then
		return FightEnum.ExPointState.Server
	end

	local remainClientPoint = clientPoint - usePoint

	remainClientPoint = math.min(self.totalMaxExPoint, storedPoint + remainClientPoint)

	if pointIndex <= remainClientPoint then
		return FightEnum.ExPointState.Client
	end

	local prePoint = math.max(remainServerPoint, remainClientPoint)
	local usingPoint = math.min(self.totalMaxExPoint, prePoint + skillNeedPoint)

	if pointIndex <= usingPoint then
		return FightEnum.ExPointState.UsingUnique
	end

	return FightEnum.ExPointState.Empty
end

function FightNameUIExPointMgr:getNoUsePointCurState(pointIndex)
	local clientPoint = self:getClientExPoint()
	local serverPoint = self:getServerExPoint()
	local storedPoint = self:getStoredExPoint()
	local skillNeedPoint = self:getUniqueSkillNeedExPoint()

	storedPoint = math.min(storedPoint, skillNeedPoint)

	if pointIndex <= storedPoint then
		return FightEnum.ExPointState.Stored
	end

	local entityMo = self.entity:getMO()
	local full = serverPoint >= entityMo:getMaxExPoint()

	if full then
		return FightEnum.ExPointState.ServerFull
	end

	local canAddPoint = FightHelper.canAddPoint(entityMo)

	if not canAddPoint then
		if pointIndex <= serverPoint then
			return FightEnum.ExPointState.Server
		end

		return FightEnum.ExPointState.Lock
	else
		if pointIndex <= serverPoint then
			return FightEnum.ExPointState.Server
		end

		if pointIndex <= clientPoint then
			return FightEnum.ExPointState.Client
		end

		return FightEnum.ExPointState.Empty
	end
end

function FightNameUIExPointMgr:updateExPoint(entityId)
	if self.entityId ~= entityId then
		return
	end

	self:log("updateExPoint")

	local usePoint = self:getUsedExPoint()

	if usePoint > 0 then
		self:_updateUsedPointStatus()
	else
		self:_updateNoUsedPointStatus()
	end

	self.preClientExPoint = self:getClientExPoint()
end

function FightNameUIExPointMgr:_updateUsedPointStatus()
	local clientPoint = self:getClientExPoint()
	local serverPoint = self:getServerExPoint()
	local usePoint = self:getUsedExPoint()
	local storedPoint = self:getStoredExPoint()
	local skillNeedPoint = self:getUniqueSkillNeedExPoint()

	storedPoint = math.min(storedPoint, skillNeedPoint)

	local refreshPointCount = 0

	for _ = 1, storedPoint do
		refreshPointCount = refreshPointCount + 1

		local pointItem = self.pointItemList[refreshPointCount]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:directSetState(FightEnum.ExPointState.Stored)
		end
	end

	local remainServerPoint = serverPoint - usePoint
	local showServerPoint = math.min(self.totalMaxExPoint, storedPoint + remainServerPoint)

	for _ = refreshPointCount + 1, showServerPoint do
		refreshPointCount = refreshPointCount + 1

		local pointItem = self.pointItemList[refreshPointCount]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:directSetState(FightEnum.ExPointState.Server)
		end
	end

	local remainClientPoint = clientPoint - usePoint
	local showClientPoint = math.min(self.totalMaxExPoint, storedPoint + remainClientPoint)

	for _ = refreshPointCount + 1, showClientPoint do
		refreshPointCount = refreshPointCount + 1

		local pointItem = self.pointItemList[refreshPointCount]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:directSetState(FightEnum.ExPointState.Client)
		end
	end

	local usingPoint = math.min(self.totalMaxExPoint, refreshPointCount + skillNeedPoint)

	for _ = refreshPointCount + 1, usingPoint do
		refreshPointCount = refreshPointCount + 1

		local pointItem = self.pointItemList[refreshPointCount]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:directSetState(FightEnum.ExPointState.UsingUnique)
		end
	end

	for i = refreshPointCount + 1, self.totalMaxExPoint do
		refreshPointCount = refreshPointCount + 1

		local pointItem = self.pointItemList[i]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:directSetState(FightEnum.ExPointState.Empty)
		end
	end
end

function FightNameUIExPointMgr:_updateNoUsedPointStatus()
	local clientPoint = self:getClientExPoint()
	local serverPoint = self:getServerExPoint()
	local storedPoint = self:getStoredExPoint()
	local skillNeedPoint = self:getUniqueSkillNeedExPoint()

	storedPoint = math.min(storedPoint, skillNeedPoint)

	local refreshPointCount = 0

	for i = 1, storedPoint do
		refreshPointCount = refreshPointCount + 1

		local pointItem = self.pointItemList[refreshPointCount]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:directSetState(FightEnum.ExPointState.Stored)
		end
	end

	for i = refreshPointCount + 1, serverPoint do
		refreshPointCount = refreshPointCount + 1

		local pointItem = self.pointItemList[refreshPointCount]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:directSetState(FightEnum.ExPointState.Server)
		end
	end

	local entityMo = self.entity:getMO()

	if serverPoint >= self.totalMaxExPoint then
		self:playFullAnim()

		return
	end

	local canAddPoint = FightHelper.canAddPoint(entityMo)

	if not canAddPoint then
		for i = refreshPointCount + 1, self.totalMaxExPoint do
			refreshPointCount = refreshPointCount + 1

			local pointItem = self.pointItemList[refreshPointCount]

			self:assetPointItem(pointItem)

			if pointItem then
				pointItem:directSetState(FightEnum.ExPointState.Lock)
			end
		end
	else
		for i = refreshPointCount + 1, clientPoint do
			refreshPointCount = refreshPointCount + 1

			local pointItem = self.pointItemList[refreshPointCount]

			self:assetPointItem(pointItem)

			if pointItem then
				pointItem:directSetState(FightEnum.ExPointState.Client)
			end
		end

		for i = refreshPointCount + 1, self.totalMaxExPoint do
			refreshPointCount = refreshPointCount + 1

			local pointItem = self.pointItemList[refreshPointCount]

			self:assetPointItem(pointItem)

			if pointItem then
				pointItem:directSetState(FightEnum.ExPointState.Empty)
			end
		end
	end
end

function FightNameUIExPointMgr:onExPointMaxAdd(entityId, offsetNum)
	if self.entityId ~= entityId then
		return
	end

	local entityMo = self.entity:getMO()
	local entityMaxPoint = entityMo:getMaxExPoint()
	local curMaxPoint = #self.pointItemList

	if entityMaxPoint == curMaxPoint then
		return
	end

	self:log("激情点上限增加")

	self.totalMaxExPoint = entityMaxPoint

	self:refreshPointItemCount()
	self:updateSelfExPoint()
end

function FightNameUIExPointMgr:onBuffUpdate(targetId, effectType, buffId)
	if targetId ~= self.entityId then
		return
	end

	self:log("更新buff")
	self:refreshPointLockStatus(effectType, buffId)
	self:checkNeedRefreshPointCount(effectType, buffId)
end

function FightNameUIExPointMgr:refreshPointLockStatus(effectType, buffId)
	local state

	if effectType == FightEnum.EffectType.BUFFADD then
		if FightBuffHelper.hasCantAddExPointFeature(buffId) then
			state = FightEnum.ExPointState.Lock
		end
	elseif effectType == FightEnum.EffectType.BUFFDEL then
		local entityMo = self.entity:getMO()

		if FightBuffHelper.hasCantAddExPointFeature(buffId) and FightHelper.canAddPoint(entityMo) then
			state = FightEnum.ExPointState.Empty
		end
	end

	if state then
		local serverPoint = self.entity:getMO().exPoint
		local storedPoint = self:getStoredExPoint()
		local start = math.max(serverPoint, storedPoint) + 1

		for i = start, self.totalMaxExPoint do
			local pointItem = self.pointItemList[i]

			self:assetPointItem(pointItem)

			if pointItem then
				pointItem:switchToState(state)
			end
		end
	end
end

function FightNameUIExPointMgr:checkNeedRefreshPointCount(effectType, buffId)
	local entityMo = self.entity:getMO()

	if effectType == FightEnum.EffectType.BUFFADD then
		local featuresSplit = entityMo:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					self:refreshPointItemCount()
					self:updateSelfExPoint()

					return
				end
			end
		end
	end

	if effectType == FightEnum.EffectType.BUFFDEL then
		local featuresSplit = entityMo:getFeaturesSplitInfoByBuffId(buffId)

		if featuresSplit then
			for _, oneFeature in ipairs(featuresSplit) do
				if oneFeature[1] == FightEnum.BuffActId.ExSkillNoConsumption then
					self:refreshPointItemCount()
					self:updateSelfExPoint()
				end
			end
		end
	end
end

function FightNameUIExPointMgr:onExPointChange(entityId, oldNum, newNum)
	if entityId ~= self.entityId then
		return
	end

	if oldNum == newNum then
		return
	end

	self:log(string.format("激情点改变 oldNum : %s, newNUm : %s", oldNum, newNum))

	if oldNum < newNum then
		self:playAddPointEffect(oldNum, newNum)
	else
		self:playRemovePointEffect(oldNum, newNum)
	end
end

function FightNameUIExPointMgr:playAddPointEffect(oldNum, newNum)
	local full = newNum >= self.entity:getMO():getMaxExPoint()
	local storedPoint = self:getStoredExPoint()

	if full then
		local addDuration = FightNameUIExPointBaseItem.AnimNameDuration[FightNameUIExPointBaseItem.AnimName.Add]
		local start = math.max(storedPoint + 1, 1)

		for i = start, oldNum do
			local pointItem = self.pointItemList[i]

			self:assetPointItem(pointItem)

			if pointItem then
				pointItem:delaySwitchToNextState(FightEnum.ExPointState.ServerFull, addDuration + 0.13 * (i - 1))
			end
		end

		start = math.max(storedPoint + 1, oldNum + 1)

		for i = start, newNum do
			local pointItem = self.pointItemList[i]

			self:assetPointItem(pointItem)

			if pointItem then
				pointItem:playAddPointEffect(FightEnum.ExPointState.ServerFull, addDuration + 0.13 * (i - 1))
			end
		end
	else
		local start = math.max(storedPoint + 1, oldNum + 1)

		for i = start, newNum do
			local pointItem = self.pointItemList[i]

			self:assetPointItem(pointItem)

			if pointItem then
				pointItem:playAddPointEffect()
			end
		end
	end
end

function FightNameUIExPointMgr:playRemovePointEffect(oldNum, newNum)
	if oldNum >= self.entity:getMO():getMaxExPoint() then
		for _, pointItem in ipairs(self.pointItemList) do
			pointItem:updateExPoint()
		end
	end

	for i = newNum + 1, oldNum do
		local pointItem = self.pointItemList[i]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:playAnim(FightNameUIExPointBaseItem.AnimName.Lost)
		end
	end
end

function FightNameUIExPointMgr:playFullAnim()
	local point = self.entity:getMO().exPoint
	local storedPoint = self:getStoredExPoint()
	local start = storedPoint + 1

	for i = start, point do
		local pointItem = self.pointItemList[self.curPlayFullIndex]

		self:assetPointItem(pointItem)

		if pointItem then
			pointItem:delaySwitchToNextState(FightEnum.ExPointState.ServerFull, 0.13 * (i - start))
		end
	end
end

function FightNameUIExPointMgr:onMultiHpChange()
	self:log("onMultiHpChange")
	self:updateSelfExPoint()
end

function FightNameUIExPointMgr:onExSkillPointChange(entityId, old, new)
	if self.entity and entityId == self.entity.id then
		self:log("大招需求激情变化")
		self:refreshPointItemCount()
		self:updateSelfExPoint()
	end
end

function FightNameUIExPointMgr:addPlayCardClientExPoint(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:log("增加客户端激情点")

	local maxPoint = self.entity:getMO():getMaxExPoint()

	if maxPoint <= self.preClientExPoint then
		self:updateSelfExPoint()

		return
	end

	local clientPoint = self:getClientExPoint()

	if clientPoint == maxPoint then
		for _, pointItem in ipairs(self.pointItemList) do
			pointItem:playAnim(FightNameUIExPointBaseItem.AnimName.Explosion)
		end
	else
		self:updateSelfExPoint()
	end
end

function FightNameUIExPointMgr:onStoreExPointChange(entityId, preNum)
	if entityId ~= self.entityId then
		return
	end

	local storedPoint = self:getStoredExPoint()

	if preNum == storedPoint then
		return
	end

	self:log("溢出激情变化")

	if preNum < storedPoint then
		FightAudioMgr.instance:playAudio(20211401)
		self:playAddStoredPointEffect(preNum, storedPoint)
	else
		FightAudioMgr.instance:playAudio(20211402)
		self:playRemoveStoredPointEffect(preNum, storedPoint)
	end
end

function FightNameUIExPointMgr:playAddStoredPointEffect(preNum, curNum)
	for i = preNum + 1, curNum do
		local pointItem = self.pointItemList[i]

		if pointItem then
			pointItem:switchToState(FightEnum.ExPointState.Stored)
		end
	end
end

function FightNameUIExPointMgr:playRemoveStoredPointEffect(preNum, curNum)
	for i = curNum + 1, preNum do
		local pointItem = self.pointItemList[i]

		if pointItem then
			pointItem:playRemoveStoredEffect()
		end
	end
end

function FightNameUIExPointMgr:assetPointItem(pointItem)
	return
end

function FightNameUIExPointMgr:log(text)
	return
end

function FightNameUIExPointMgr:onCoverPerformanceEntityData(entityId)
	if entityId == self.entityId then
		self:updateSelfExPoint()
		self:onExPointMaxAdd(entityId)
	end
end

function FightNameUIExPointMgr:beforeDestroy()
	TaskDispatcher.cancelTask(self.hideTsnnEffect, self)

	if self.pointItemList then
		for _, pointItem in ipairs(self.pointItemList) do
			pointItem:destroy()
		end
	end

	if self.exPointItemPool then
		for _, pointItem in ipairs(self.exPointItemPool) do
			pointItem:destroy()
		end
	end

	if self.extraPointItemPool then
		for _, pointItem in ipairs(self.extraPointItemPool) do
			pointItem:destroy()
		end
	end

	self.pointItemList = nil
	self.exPointItemList = nil
	self.extraExPointItemList = nil
	self.exPointItemPool = nil
	self.extraPointItemPool = nil

	self:__onDispose()
end

return FightNameUIExPointMgr
