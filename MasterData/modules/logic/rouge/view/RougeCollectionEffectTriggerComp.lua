-- chunkname: @modules/logic/rouge/view/RougeCollectionEffectTriggerComp.lua

module("modules.logic.rouge.view.RougeCollectionEffectTriggerComp", package.seeall)

local RougeCollectionEffectTriggerComp = class("RougeCollectionEffectTriggerComp", BaseView)

function RougeCollectionEffectTriggerComp:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionEffectTriggerComp:addEvents()
	return
end

function RougeCollectionEffectTriggerComp:removeEvents()
	return
end

function RougeCollectionEffectTriggerComp:_editableInitView()
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, self.placeCollection2SlotAreaSucc, self)

	self._poolComp = self.viewContainer:getRougePoolComp()
	self._effectTab = self:getUserDataTb_()
	self._collectionMap = self:getUserDataTb_()
end

function RougeCollectionEffectTriggerComp:onOpenFinish()
	local isNeedTrigger = RougeCollectionModel.instance:checkHasTmpTriggerEffectInfo()

	if not isNeedTrigger then
		return
	end

	self:init()
end

local placeTriggerEffectDuraion = 2

function RougeCollectionEffectTriggerComp:placeCollection2SlotAreaSucc(collectionMO)
	if not collectionMO then
		return
	end

	local collectionId = collectionMO.id
	local centerSlotPos = collectionMO:getCenterSlotPos()
	local rotation = collectionMO:getRotation()
	local collectionCfgId = collectionMO.cfgId
	local effectShapeCfg = RougeCollectionConfig.instance:getRotateEditorParam(collectionCfgId, rotation, RougeEnum.CollectionEditorParamType.Effect)
	local flow = FlowSequence.New()

	flow:addWork(FunctionWork.New(function()
		self:recycleEffectGOs(collectionId, RougeEnum.CollectionArtType.Place)
		self:recycleEffectGOs(collectionId, RougeEnum.CollectionArtType.Effect)
	end))
	flow:addWork(FunctionWork.New(self.shapeTriggerForeachCollectionCells, self, collectionMO))
	flow:addWork(FunctionWork.New(function()
		self:playCellEffect(collectionId, effectShapeCfg, centerSlotPos, RougeEnum.CollectionArtType.Effect)
	end))
	flow:addWork(WorkWaitSeconds.New(placeTriggerEffectDuraion))
	flow:addWork(FunctionWork.New(function()
		self:recycleEffectGOs(collectionId, RougeEnum.CollectionArtType.Place)
		self:recycleEffectGOs(collectionId, RougeEnum.CollectionArtType.Effect)
	end))
	flow:start()
end

function RougeCollectionEffectTriggerComp:shapeTriggerForeachCollectionCells(collectionMO)
	RougeCollectionHelper.foreachCollectionCells(collectionMO, self.collectionCellsEffectExcuteFunc, self, RougeEnum.CollectionArtType.Place)
end

function RougeCollectionEffectTriggerComp:playCellEffect(collectionId, shapeCfg, centerSlotPos, artType)
	self:recycleEffectGOs(collectionId, artType)

	for _, cellOffset in ipairs(shapeCfg) do
		local slotPos = RougeCollectionHelper.getCollectionCellSlotPos(centerSlotPos, cellOffset)

		self:playSlotCellEffect(collectionId, slotPos, artType)
	end
end

function RougeCollectionEffectTriggerComp:recycleEffectGOs(collectionId, effectType)
	if self._effectTab then
		local effects = self._effectTab[collectionId]

		if effects and effects[effectType] then
			local effectCount = #effects[effectType]

			for i = effectCount, 1, -1 do
				local effectGO = effects[effectType][i]

				self._poolComp:recycleEffectItem(effectType, effectGO)
				table.remove(effects[effectType], i)
			end
		end
	end
end

function RougeCollectionEffectTriggerComp:checkIsSlotPosInSlotArea(posX, posY)
	local slotAreaSize = RougeCollectionModel.instance:getCurSlotAreaSize()

	if posX >= 0 and posX < slotAreaSize.col and posY >= 0 and posY < slotAreaSize.row then
		return true
	end
end

local triggerEffectPlayDuration = 1.5

function RougeCollectionEffectTriggerComp:init()
	local triggerInfos = RougeCollectionModel.instance:getTmpCollectionTriggerEffectInfo()

	if not triggerInfos then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeCollectionEffectTriggerComp_PlayEffect")

	for _, triggerInfo in ipairs(triggerInfos) do
		self:excuteActiveEffect(triggerInfo)
	end

	TaskDispatcher.cancelTask(self._endUIBlock, self)
	TaskDispatcher.runDelay(self._endUIBlock, self, triggerEffectPlayDuration)
end

function RougeCollectionEffectTriggerComp:_endUIBlock()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeCollectionEffectTriggerComp_PlayEffect")
end

function RougeCollectionEffectTriggerComp:excuteActiveEffect(triggerInfo)
	local effectShowType = triggerInfo.showType

	self:executeEffectCmd(triggerInfo, effectShowType)
end

function RougeCollectionEffectTriggerComp:executeEffectCmd(triggerInfo, effectShowType)
	if not triggerInfo then
		return
	end

	local excuteFunc = self:tryGetExecuteEffectFunc(effectShowType)

	if not excuteFunc then
		logError(string.format("无法找到肉鸽造物效果表现执行方法,效果id = %s, 造物uid = %s", effectShowType, triggerInfo.trigger.id))

		return
	end

	excuteFunc(self, triggerInfo)
end

function RougeCollectionEffectTriggerComp:tryGetExecuteEffectFunc(effectId)
	self._effectExcuteFuncTab = self._effectExcuteFuncTab or {
		[RougeEnum.EffectTriggerType.Engulf] = self.engulfEffectFunc,
		[RougeEnum.EffectTriggerType.LevelUp] = self.levelUpEffectFunc
	}

	return self._effectExcuteFuncTab[effectId]
end

function RougeCollectionEffectTriggerComp:levelUpEffectFunc(triggerInfo)
	local effectCollections = triggerInfo.removeCollections
	local triggerCollection = triggerInfo.trigger

	if effectCollections then
		for _, effectCollection in ipairs(effectCollections) do
			self:levelupEffectCollectionFunc(triggerCollection, effectCollection)
		end
	end
end

function RougeCollectionEffectTriggerComp:levelupEffectCollectionFunc(triggerCollection, effectCollection)
	if not triggerCollection or not effectCollection then
		return
	end

	local startSlotPos, endSlotPos = RougeCollectionHelper.getTwoCollectionConnectCell(triggerCollection, effectCollection)

	if not startSlotPos or not endSlotPos then
		return
	end

	local flow = FlowSequence.New()
	local flowParallel = FlowParallel.New()

	flowParallel:addWork(FunctionWork.New(self.levelupTriggerForeachCollectionCells, self, triggerCollection))
	flowParallel:addWork(FunctionWork.New(self.levelupTriggerForeachCollectionCells, self, effectCollection))
	flowParallel:addWork(FunctionWork.New(function()
		self:drawTriggerLine(triggerCollection, effectCollection, RougeEnum.CollectionArtType.LevelUPTrigger2)
	end))
	flow:addWork(flowParallel)
	flow:addWork(WorkWaitSeconds.New(triggerEffectPlayDuration))
	flow:addWork(FunctionWork.New(function()
		self:recycleEffectGOs(triggerCollection.id, RougeEnum.CollectionArtType.LevelUPTrigger1)
	end))
	flow:addWork(FunctionWork.New(function()
		self:recycleEffectGOs(effectCollection.id, RougeEnum.CollectionArtType.LevelUPTrigger1)
	end))
	flow:addWork(FunctionWork.New(function()
		self:recycleEffectGOs(triggerCollection.id, RougeEnum.CollectionArtType.LevelUPTrigger2)
	end))
	flow:start()
end

function RougeCollectionEffectTriggerComp:levelupTriggerForeachCollectionCells(collectionMO)
	RougeCollectionHelper.foreachCollectionCells(collectionMO, self.collectionCellsEffectExcuteFunc, self, RougeEnum.CollectionArtType.LevelUPTrigger1)
end

function RougeCollectionEffectTriggerComp:collectionCellsEffectExcuteFunc(collectionMO, row, col, artType)
	local leftTopPos = collectionMO:getLeftTopPos()
	local slotPos = Vector2(leftTopPos.x + col - 1, leftTopPos.y + row - 1)

	self:playSlotCellEffect(collectionMO.id, slotPos, artType)
end

function RougeCollectionEffectTriggerComp:drawTriggerLine(startCollection, endCollection, artType)
	local startSlotPos, endSlotPos = RougeCollectionHelper.getTwoCollectionConnectCell(startCollection, endCollection)

	if not startSlotPos or not endSlotPos then
		return
	end

	local direction = self:getDrawLineDirection(startSlotPos, endSlotPos)
	local linePlacePosX, linePlacePosY = RougeCollectionHelper.slotPos2AnchorPos(startSlotPos)
	local effectItem = self:getAndSaveEffectItem(startCollection.id, artType)

	recthelper.setAnchor(effectItem.transform, linePlacePosX, linePlacePosY)
	gohelper.setActive(effectItem.gameObject, true)
	self:setLineDirection(effectItem, direction)
end

function RougeCollectionEffectTriggerComp:getDrawLineDirection(startSlotPos, endSlotPos)
	if not startSlotPos or not endSlotPos then
		return
	end

	if endSlotPos.y > startSlotPos.y then
		return RougeEnum.SlotCellDirection.Bottom
	elseif endSlotPos.y < startSlotPos.y then
		return RougeEnum.SlotCellDirection.Top
	elseif endSlotPos.x > startSlotPos.x then
		return RougeEnum.SlotCellDirection.Right
	else
		return RougeEnum.SlotCellDirection.Left
	end
end

function RougeCollectionEffectTriggerComp:setLineDirection(effectItem, direction)
	if not effectItem then
		return
	end

	local childCount = effectItem.transform.childCount

	for i = childCount, 1, -1 do
		gohelper.setActive(effectItem.transform:GetChild(i - 1).gameObject, false)
	end

	local tran = direction == RougeEnum.SlotCellDirection.Left and effectItem.transform:Find("left") or direction == RougeEnum.SlotCellDirection.Right and effectItem.transform:Find("right") or direction == RougeEnum.SlotCellDirection.Top and effectItem.transform:Find("top") or effectItem.transform:Find("down")

	if tran then
		gohelper.setActive(tran.gameObject, true)
	end
end

function RougeCollectionEffectTriggerComp:playSlotCellEffect(collectionId, slotPos, artType)
	if not collectionId or not slotPos or not artType then
		return
	end

	local isInSlotArea = self:checkIsSlotPosInSlotArea(slotPos.x, slotPos.y)

	if not isInSlotArea then
		return
	end

	local effectItem = self:getAndSaveEffectItem(collectionId, artType)
	local anchorPosX, anchorPosY = RougeCollectionHelper.slotPos2AnchorPos(slotPos)

	gohelper.setActive(effectItem, true)
	recthelper.setAnchor(effectItem.transform, anchorPosX, anchorPosY)
end

function RougeCollectionEffectTriggerComp:getAndSaveEffectItem(collectionId, artType)
	if not collectionId or not artType then
		return
	end

	local effectGO = self._poolComp:getEffectItem(artType)

	if self._effectTab then
		local effectItems = self._effectTab[collectionId]
		local effects = effectItems and effectItems[artType]

		if not effects then
			self._effectTab = self._effectTab or self:getUserDataTb_()
			self._effectTab[collectionId] = self._effectTab[collectionId] or self:getUserDataTb_()
			self._effectTab[collectionId][artType] = self:getUserDataTb_()
		end

		table.insert(self._effectTab[collectionId][artType], effectGO)

		return effectGO
	end
end

function RougeCollectionEffectTriggerComp:setCollectionsVisible(collectionIds, isVisible)
	if not collectionIds then
		return
	end

	for _, collectionId in pairs(collectionIds) do
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.SetCollectionVisible, collectionId, isVisible)
	end
end

function RougeCollectionEffectTriggerComp:getOrCreateTmpCollection(collectionMO)
	local collectionItem = self._collectionMap[collectionMO.id]

	if not collectionItem then
		collectionItem = self._poolComp:getCollectionItem(RougeCollectionDragItem.__cname)

		collectionItem:onUpdateMO(collectionMO)
		collectionItem:setShapeCellsVisible(false)
		collectionItem:setHoleToolVisible(true)
		collectionItem:setShowTypeFlagVisible(true)

		self._collectionMap[collectionMO.id] = collectionItem
	end

	return collectionItem
end

function RougeCollectionEffectTriggerComp:resetTmpCollection(collectionId)
	local collectionItem = self._collectionMap[collectionId]

	if not collectionItem then
		return
	end

	collectionItem:reset()
end

function RougeCollectionEffectTriggerComp:engulfEffectFunc(triggerInfo)
	local effectCollections = triggerInfo.removeCollections
	local triggerCollection = triggerInfo.trigger

	if effectCollections then
		for _, effectCollection in ipairs(effectCollections) do
			self:engulfEffectCollectionFunc(triggerCollection, effectCollection)
		end
	end
end

function RougeCollectionEffectTriggerComp:engulfEffectCollectionFunc(triggerCollection, effectCollection)
	if not triggerCollection or not effectCollection then
		return
	end

	local startSlotPos, endSlotPos = RougeCollectionHelper.getTwoCollectionConnectCell(triggerCollection, effectCollection)

	if not startSlotPos or not endSlotPos then
		return
	end

	local flow = FlowSequence.New()
	local flowParallel = FlowParallel.New()

	flowParallel:addWork(FunctionWork.New(self.engulfTriggerForeachCollectionCells, self, triggerCollection))
	flowParallel:addWork(FunctionWork.New(self.engulfTriggerForeachCollectionCells, self, effectCollection))
	flowParallel:addWork(FunctionWork.New(function()
		self:playEngulfCollection(effectCollection, triggerCollection)
	end))
	flowParallel:addWork(FunctionWork.New(function()
		self:drawTriggerLine(effectCollection, triggerCollection, RougeEnum.CollectionArtType.EngulfTrigger2)
	end))
	flow:addWork(flowParallel)
	flow:addWork(WorkWaitSeconds.New(triggerEffectPlayDuration))
	flow:addWork(FunctionWork.New(function()
		self:recycleEffectGOs(triggerCollection.id, RougeEnum.CollectionArtType.EngulfTrigger1)
	end))
	flow:addWork(FunctionWork.New(function()
		self:recycleEffectGOs(effectCollection.id, RougeEnum.CollectionArtType.EngulfTrigger1)
	end))
	flow:addWork(FunctionWork.New(function()
		self:recycleEffectGOs(effectCollection.id, RougeEnum.CollectionArtType.EngulfTrigger2)
	end))
	flow:addWork(FunctionWork.New(self.resetTmpCollection, self, effectCollection.id))
	flow:start()
end

function RougeCollectionEffectTriggerComp:engulfTriggerForeachCollectionCells(collectionMO)
	RougeCollectionHelper.foreachCollectionCells(collectionMO, self.collectionCellsEffectExcuteFunc, self, RougeEnum.CollectionArtType.EngulfTrigger1)
end

function RougeCollectionEffectTriggerComp:playEngulfCollection(startCollection, endCollection)
	if not startCollection or not endCollection then
		return
	end

	local tmpCollection = self:getOrCreateTmpCollection(startCollection)
	local startSlotPos, endSlotPos = RougeCollectionHelper.getTwoCollectionConnectCell(startCollection, endCollection)

	if not startSlotPos or not endSlotPos then
		return
	end

	local direction = self:getDrawLineDirection(startSlotPos, endSlotPos)
	local animStateName = self:getEngulfCollectionAnimStateName(direction)

	tmpCollection:playAnim(animStateName)
	tmpCollection:setCollectionInteractable(false)
end

function RougeCollectionEffectTriggerComp:getEngulfCollectionAnimStateName(direction)
	return direction == RougeEnum.SlotCellDirection.Left and "left" or direction == RougeEnum.SlotCellDirection.Right and "right" or direction == RougeEnum.SlotCellDirection.Top and "top" or "down"
end

function RougeCollectionEffectTriggerComp:onClose()
	RougeCollectionModel.instance:clearTmpCollectionTriggerEffectInfo()
	self:_endUIBlock()
end

function RougeCollectionEffectTriggerComp:onDestroyView()
	if self._collectionMap then
		for _, collectionItem in pairs(self._collectionMap) do
			collectionItem:destroy()
		end
	end

	self._poolComp = nil

	TaskDispatcher.cancelTask(self._endUIBlock, self)
end

return RougeCollectionEffectTriggerComp
