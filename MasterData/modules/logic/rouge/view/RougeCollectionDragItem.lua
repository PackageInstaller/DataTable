-- chunkname: @modules/logic/rouge/view/RougeCollectionDragItem.lua

module("modules.logic.rouge.view.RougeCollectionDragItem", package.seeall)

local RougeCollectionDragItem = class("RougeCollectionDragItem", RougeCollectionSizeBagItem)

function RougeCollectionDragItem:onInit(createGOName, parentView)
	self:createCollectionGO(createGOName, parentView)
	RougeCollectionDragItem.super.onInit(self, self.viewGO)

	self._gocenter = gohelper.findChild(self.viewGO, "go_center")
	self._simageiconeffect = gohelper.findChildSingleImage(self.viewGO, "go_center/simage_icon/icon_effect")
	self._godisconnect = gohelper.findChild(self.viewGO, "go_center/go_disconnect")
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._animator.enabled = false
	self._activeEffectMap = {}

	self:setAnimatorEnabled(false)
	self:setShowTypeFlagVisible(false)
	self:setPivot(0, 1)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.UpdateActiveEffect, self.updateActiveEffectTag, self)
end

function RougeCollectionDragItem:createCollectionGO(createGOName, parentView)
	local prefab = parentView._gochessitem

	if prefab then
		self.viewGO = gohelper.cloneInPlace(prefab, createGOName)
		self.viewGO.transform.anchorMin = Vector2.New(0.5, 0.5)
		self.viewGO.transform.anchorMax = Vector2.New(0.5, 0.5)
		self.viewGO.transform.pivot = Vector2.New(0.5, 0.5)

		gohelper.setActive(self.viewGO, true)
	end
end

function RougeCollectionDragItem:getCollectionTransform()
	return self.viewGO and self.viewGO.transform
end

function RougeCollectionDragItem:setPivot(pivotX, pivotY)
	self.viewGO.transform.pivot = Vector2(pivotX, pivotY)
end

function RougeCollectionDragItem:onUpdateMO(collectionMO)
	RougeCollectionDragItem.super.onUpdateMO(self, collectionMO)
	self:updateCollectionPosition()

	local iconUrl = RougeCollectionHelper.getCollectionIconUrl(self._mo.cfgId)

	self._simageiconeffect:LoadImage(iconUrl)
	self:_selectCollection()
end

function RougeCollectionDragItem:onUpdateRotateAngle()
	RougeCollectionDragItem.super.onUpdateRotateAngle(self)
	self:updateElectirDisconnnectFlagPos()
end

function RougeCollectionDragItem:updateCollectionRotation(angle)
	transformhelper.setLocalRotation(self._gocenter.transform, 0, 0, angle)
end

function RougeCollectionDragItem:refreshSlotCell(obj, cellPos, index)
	self:setCellAnchor(obj, cellPos, index)
	self:checkAndPlaceAroundLine(obj, cellPos)
end

function RougeCollectionDragItem:setParent(parentTran)
	if not parentTran or self._curParentTran == parentTran then
		return
	end

	self.viewGO.transform:SetParent(parentTran)

	self._curParentTran = parentTran
end

function RougeCollectionDragItem:setShowTypeFlagVisible(isVisible)
	self._isElectriDisconnect = isVisible and self._activeEffectMap[RougeEnum.EffectActiveType.Electric] == false

	local isLevelUpActive = isVisible and self._activeEffectMap[RougeEnum.EffectActiveType.LevelUp]
	local isEngulfActive = isVisible and self._activeEffectMap[RougeEnum.EffectActiveType.Engulf]

	gohelper.setActive(self._simageiconeffect.gameObject, isLevelUpActive or isEngulfActive)
	gohelper.setActive(self._godisconnect, self._isElectriDisconnect)
	self:updateElectirDisconnnectFlagPos()
end

RougeCollectionDragItem.BaseElectricDisconnectFlagPosX = 0

function RougeCollectionDragItem:updateElectirDisconnnectFlagPos()
	if not self._isElectriDisconnect then
		return
	end

	local rotation = self._mo:getRotation()
	local rotationMatrix = RougeCollectionConfig.instance:getShapeMatrix(self._mo.cfgId, rotation)
	local firstRow = rotationMatrix[1]
	local emptyCellCount = 0

	for i = 1, #firstRow do
		if firstRow[i] then
			local isCell = firstRow[i] > 0

			if isCell then
				emptyCellCount = i - 1

				break
			end
		end
	end

	local flagOffset = emptyCellCount * RougeCollectionHelper.CollectionSlotCellSize.x
	local flagAnchorPosX = RougeCollectionDragItem.BaseElectricDisconnectFlagPosX + flagOffset

	recthelper.setAnchorX(self._godisconnect.transform, flagAnchorPosX)
end

function RougeCollectionDragItem:updateActiveEffectTag(collectionId, effectActiveType, isActive)
	if self._mo and collectionId == self._mo.id then
		self._activeEffectMap = self._activeEffectMap or {}
		self._activeEffectMap[effectActiveType] = isActive

		self:setShowTypeFlagVisible(true)
	end
end

function RougeCollectionDragItem:setSelectFrameVisible(isSelect)
	RougeCollectionDragItem.super.setSelectFrameVisible(self, isSelect)
	self:setShapeCellsVisible(isSelect)
end

function RougeCollectionDragItem:setAnimatorEnabled(isEnabled)
	self._animator.enabled = isEnabled
end

function RougeCollectionDragItem:playAnim(animStateName)
	self:setAnimatorEnabled(true)
	self._animator:Play(animStateName, 0, 0)
end

function RougeCollectionDragItem:reset()
	RougeCollectionDragItem.super.reset(self)
	transformhelper.setLocalRotation(self._gocenter.transform, 0, 0, 0)
	self:setAnimatorEnabled(false)
	self:setShowTypeFlagVisible(false)
	gohelper.setActive(self._simageiconeffect.gameObject, false)
	tabletool.clear(self._activeEffectMap)
end

function RougeCollectionDragItem:destroy()
	RougeCollectionDragItem.super.destroy(self)
end

return RougeCollectionDragItem
