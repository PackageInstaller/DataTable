-- chunkname: @modules/logic/rouge/view/RougeCollectionEffectActiveComp.lua

module("modules.logic.rouge.view.RougeCollectionEffectActiveComp", package.seeall)

local RougeCollectionEffectActiveComp = class("RougeCollectionEffectActiveComp", BaseView)

function RougeCollectionEffectActiveComp:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionEffectActiveComp:addEvents()
	return
end

function RougeCollectionEffectActiveComp:removeEvents()
	return
end

function RougeCollectionEffectActiveComp:_editableInitView()
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, self.onBeginDragCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, self.deleteSlotCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.UpdateSlotCollectionEffect, self.updateSomeSlotCollectionEffect, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.RotateSlotCollection, self.onRotateSlotCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, self.failed2PlaceSlotCollection, self)

	self._poolComp = self.viewContainer:getRougePoolComp()
	self._effectTab = self:getUserDataTb_()
	self._activeEffectMap = {}
end

function RougeCollectionEffectActiveComp:onOpenFinish()
	self:init()
end

function RougeCollectionEffectActiveComp:init()
	local slotCollections = RougeCollectionModel.instance:getSlotAreaCollection()

	self:updateSomeSlotCollectionEffect(slotCollections)
end

function RougeCollectionEffectActiveComp:updateSomeSlotCollectionEffect(slotCollections)
	if slotCollections then
		for _, collectionMO in ipairs(slotCollections) do
			self:recycleCollectionEffects(collectionMO.id)
		end

		for _, collectionMO in ipairs(slotCollections) do
			self:updateSlotCollectionEffect(collectionMO.id)
		end

		self:playNeedTriggerAudio()
	end
end

function RougeCollectionEffectActiveComp:updateSlotCollectionEffect(collectionId)
	self:excuteActiveEffect(collectionId)
end

function RougeCollectionEffectActiveComp:excuteActiveEffect(collectionId)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		return
	end

	local isInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionId)

	if not isInSlotArea then
		return
	end

	for _, effectType in pairs(RougeEnum.EffectActiveType) do
		local effectMOs = collectionMO:getEffectShowTypeRelations(effectType)
		local isActive = collectionMO:isEffectActive(effectType)

		self:executeEffectCmd(effectMOs, collectionMO, effectType, isActive)
	end
end

function RougeCollectionEffectActiveComp:executeEffectCmd(effectMOs, collectionMO, effectType, isActive)
	if not effectMOs or not collectionMO then
		return
	end

	local excuteFunc = self:tryGetExecuteEffectFunc(effectType)

	if not excuteFunc then
		logError(string.format("无法找到肉鸽造物效果表现执行方法,效果id = %s, 造物uid = %s", effectType, collectionMO.id))

		return
	end

	for _, effectMO in ipairs(effectMOs) do
		excuteFunc(self, collectionMO, effectMO, isActive)
	end
end

function RougeCollectionEffectActiveComp:tryGetExecuteEffectFunc(effectType)
	self._effectExcuteFuncTab = self._effectExcuteFuncTab or {
		[RougeEnum.EffectActiveType.Electric] = self.electricEffectFunc,
		[RougeEnum.EffectActiveType.Engulf] = self.engulfEffectFunc,
		[RougeEnum.EffectActiveType.LevelUp] = self.levelUpEffectFunc
	}

	return self._effectExcuteFuncTab[effectType]
end

function RougeCollectionEffectActiveComp:electricEffectFunc(collectionMO, effectMO, isActive)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, collectionMO.id, RougeEnum.EffectActiveType.Electric, isActive)

	if isActive then
		self:try2PlayEffectActiveAudio(collectionMO.id, nil, RougeEnum.EffectActiveType.Electric, AudioEnum.UI.ElectricEffect)
		RougeCollectionHelper.foreachCollectionCells(collectionMO, self.electircTypeCellFunc, self)
	end

	self:updateActiveEffectInfo(collectionMO.id, RougeEnum.EffectActiveType.Electric, isActive)
end

function RougeCollectionEffectActiveComp:electircTypeCellFunc(collectionMO, row, col)
	local leftTopPos = collectionMO:getLeftTopPos()
	local slotPos = Vector2(leftTopPos.x + col - 1, leftTopPos.y + row - 1)
	local anchorPosX, anchorPosY = RougeCollectionHelper.slotPos2AnchorPos(slotPos)
	local electricItem = self._poolComp:getEffectItem(RougeEnum.CollectionArtType.Lighting)

	gohelper.setActive(electricItem, true)
	recthelper.setAnchor(electricItem.transform, anchorPosX, anchorPosY)
	self:saveEffectGO(collectionMO.id, RougeEnum.CollectionArtType.Lighting, electricItem)
end

function RougeCollectionEffectActiveComp:levelUpEffectFunc(collectionMO, effectMO, isActive)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, collectionMO.id, RougeEnum.EffectActiveType.LevelUp, isActive)

	if isActive then
		local trueIds = effectMO:getTrueCollectionIds()

		self:try2PlayEffectActiveAudio(collectionMO.id, trueIds, RougeEnum.EffectActiveType.LevelUp, AudioEnum.UI.LevelUpEffect)

		if trueIds then
			for _, trueId in ipairs(trueIds) do
				local effectCollection = RougeCollectionModel.instance:getCollectionByUid(trueId)

				self:levelupTypeTrueIdFunc(effectCollection, collectionMO)
				self:updateActiveEffectInfo(trueId, RougeEnum.EffectActiveType.LevelUp, isActive)
			end
		end
	end

	self:updateActiveEffectInfo(collectionMO.id, RougeEnum.EffectActiveType.LevelUp, isActive)
end

function RougeCollectionEffectActiveComp:levelupTypeTrueIdFunc(startCollection, endCollection)
	local startSlotPos, endSlotPos = RougeCollectionHelper.getTwoCollectionConnectCell(startCollection, endCollection)

	if not startSlotPos or not endSlotPos then
		return
	end

	local startId = startCollection.id
	local endId = endCollection.id

	self:drawLineConnectTwoCollection(startId, startSlotPos, endId, endSlotPos, RougeEnum.CollectionArtType.LevelUpLine)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, startId, RougeEnum.EffectActiveType.LevelUp, true)
end

function RougeCollectionEffectActiveComp:drawLineConnectTwoCollection(startId, startSlotPos, endId, endSlotPos, lineType)
	local effectItem = self._poolComp:getEffectItem(lineType)
	local startAnchorPosX, startAnchorPosY = RougeCollectionHelper.slotPos2AnchorPos(startSlotPos)

	gohelper.setActive(effectItem, true)
	recthelper.setAnchor(effectItem.transform, startAnchorPosX, startAnchorPosY)

	local startPosition = effectItem.transform.position
	local realStartPosX, realStartPosY = recthelper.rectToRelativeAnchorPos2(startPosition, self.viewGO.transform)
	local endAnchorPosX, endAnchorPosY = RougeCollectionHelper.slotPos2AnchorPos(endSlotPos)

	recthelper.setAnchor(effectItem.transform, endAnchorPosX, endAnchorPosY)

	local endPosition = effectItem.transform.position
	local realEndPosX, realEndPosY = recthelper.rectToRelativeAnchorPos2(endPosition, self.viewGO.transform)
	local lineIcon = gohelper.findChildImage(effectItem, "line")

	self:setLinePosition(lineIcon, realStartPosX, realStartPosY, realEndPosX, realEndPosY)

	local lineupIcon = gohelper.findChildImage(effectItem, "lineup")

	self:setLinePosition(lineupIcon, realStartPosX, realStartPosY, realEndPosX, realEndPosY)

	local godot = gohelper.findChild(effectItem, "#dot")
	local godotPosX, godotPosY = recthelper.rectToRelativeAnchorPos2(startPosition, effectItem.transform)

	recthelper.setAnchor(godot.transform, godotPosX, godotPosY)
	self:saveEffectGO(startId, lineType, effectItem)
	self:saveEffectGO(endId, lineType, effectItem)
end

function RougeCollectionEffectActiveComp:setLinePosition(lineIcon, startPosX, startPosY, endStartPosX, endStartPosY)
	local startVec = Vector4(startPosX, startPosY, 0, 0)
	local endVec = Vector4(endStartPosX, endStartPosY, 0, 0)

	lineIcon.material:SetVector("_StartVec", startVec)
	lineIcon.material:SetVector("_EndVec", endVec)
end

function RougeCollectionEffectActiveComp:engulfEffectFunc(activeCollection, effectMO, isActive)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, activeCollection.id, RougeEnum.EffectActiveType.Engulf, isActive)

	if isActive then
		local trueIds = effectMO:getTrueCollectionIds()

		self:try2PlayEffectActiveAudio(activeCollection.id, trueIds, RougeEnum.EffectActiveType.Engulf, AudioEnum.UI.EngulfEffect)

		if trueIds then
			for _, trueId in ipairs(trueIds) do
				local effectCollection = RougeCollectionModel.instance:getCollectionByUid(trueId)

				self:engulfTypeTrueIdFunc(activeCollection, effectCollection)
				self:updateActiveEffectInfo(trueId, RougeEnum.EffectActiveType.Engulf, isActive)
			end
		end
	end

	self:updateActiveEffectInfo(activeCollection.id, RougeEnum.EffectActiveType.Engulf, isActive)
end

function RougeCollectionEffectActiveComp:engulfTypeTrueIdFunc(activeCollection, effectCollection)
	local startSlotPos, endSlotPos = RougeCollectionHelper.getTwoCollectionConnectCell(activeCollection, effectCollection)

	if not startSlotPos or not endSlotPos then
		return
	end

	local startId = activeCollection.id
	local endId = effectCollection.id

	self:drawLineConnectTwoCollection(startId, startSlotPos, endId, endSlotPos, RougeEnum.CollectionArtType.EngulfLine)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateActiveEffect, effectCollection.id, RougeEnum.EffectActiveType.Engulf, true)
end

function RougeCollectionEffectActiveComp:saveEffectGO(collectionId, effectType, effectGO)
	if self._effectTab then
		local collectionEffects = self._effectTab[collectionId]
		local effects = collectionEffects and collectionEffects[effectType]

		if not effects then
			self._effectTab = self._effectTab or self:getUserDataTb_()
			self._effectTab[collectionId] = self._effectTab[collectionId] or self:getUserDataTb_()
			self._effectTab[collectionId][effectType] = self:getUserDataTb_()
		end

		table.insert(self._effectTab[collectionId][effectType], effectGO)
	end
end

function RougeCollectionEffectActiveComp:recycleEffectGOs(collectionId, effectType)
	if self._effectTab then
		local effects = self._effectTab[collectionId]

		if effects and effects[effectType] then
			local effectGOs = effects[effectType]

			for i = #effectGOs, 1, -1 do
				local effectGO = effectGOs[i]

				table.remove(effectGOs, i)
				self._poolComp:recycleEffectItem(effectType, effectGO)
			end
		end
	end
end

function RougeCollectionEffectActiveComp:onBeginDragCollection(collectionMO)
	if not collectionMO then
		return
	end

	self:recycleCollectionEffects(collectionMO.id)
	self:updateCollectionActiveEffectInfo(collectionMO.id)
end

function RougeCollectionEffectActiveComp:onRotateSlotCollection(collectionMO)
	if not collectionMO then
		return
	end

	self:recycleCollectionEffects(collectionMO.id)
	self:updateCollectionActiveEffectInfo(collectionMO.id)
end

function RougeCollectionEffectActiveComp:setCollectionEffectsVisible(collectionId, isVisible)
	if self._effectTab then
		if not self._effectTab then
			return
		end

		for effectType, _ in pairs(self._effectTab) do
			if self._effectTab then
				if self._effectTab and self._effectTab[effectType] then
					for _, effectGO in pairs(self._effectTab[effectType]) do
						if effectGO then
							gohelper.setActive(effectGO, isVisible)
						end
					end
				end
			end
		end
	end
end

function RougeCollectionEffectActiveComp:try2PlayEffectActiveAudio(collectionId, relationIds, effectType, audioId)
	local hasActive = self:isCollectionHasActiveEffect(collectionId, effectType)

	if hasActive and relationIds then
		for _, relationId in ipairs(relationIds) do
			hasActive = self:isCollectionHasActiveEffect(relationId, effectType)

			if not hasActive then
				break
			end
		end
	end

	if not hasActive then
		self._needTriggerAudioMap = self._needTriggerAudioMap or {}
		self._needTriggerAudioMap[audioId] = true
	end
end

function RougeCollectionEffectActiveComp:playNeedTriggerAudio()
	if self._needTriggerAudioMap then
		for audioId, isNeed in pairs(self._needTriggerAudioMap) do
			if isNeed then
				AudioMgr.instance:trigger(audioId)
			end

			self._needTriggerAudioMap[audioId] = nil
		end
	end
end

function RougeCollectionEffectActiveComp:updateActiveEffectInfo(collectionId, effectType, isActive)
	if isActive then
		self._activeEffectMap = self._activeEffectMap or {}
		self._activeEffectMap[collectionId] = self._activeEffectMap[collectionId] or {}
		self._activeEffectMap[collectionId][effectType] = isActive
	elseif self._activeEffectMap then
		local activeEffects = self._activeEffectMap[collectionId]

		if activeEffects then
			activeEffects[effectType] = isActive
		end
	end
end

function RougeCollectionEffectActiveComp:isCollectionHasActiveEffect(collectionId, effectType)
	if self._activeEffectMap then
		local collectionEffects = self._activeEffectMap[collectionId]

		return collectionEffects and collectionEffects[effectType]
	end
end

function RougeCollectionEffectActiveComp:failed2PlaceSlotCollection(collectionId)
	local isInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionId)

	if not isInSlotArea then
		return
	end

	self:updateSlotCollectionEffect(collectionId)
end

function RougeCollectionEffectActiveComp:recycleCollectionEffects(collectionId)
	if self._effectTab then
		if not self._effectTab then
			return
		end

		for effectType, _ in pairs(self._effectTab) do
			self:recycleEffectGOs(collectionId, effectType)
		end
	end
end

function RougeCollectionEffectActiveComp:updateCollectionActiveEffectInfo(collectionId)
	if not collectionId then
		return
	end

	for _, activeType in pairs(RougeEnum.EffectActiveType) do
		self:updateActiveEffectInfo(collectionId, activeType, false)
	end
end

function RougeCollectionEffectActiveComp:deleteSlotCollection(collectionId)
	self:recycleCollectionEffects(collectionId)
	self:updateCollectionActiveEffectInfo(collectionId)
end

function RougeCollectionEffectActiveComp:onDestroyView()
	self._poolComp = nil
end

return RougeCollectionEffectActiveComp
