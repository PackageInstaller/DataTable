-- chunkname: @modules/logic/rouge/view/RougeCollectionChessPlaceComp.lua

module("modules.logic.rouge.view.RougeCollectionChessPlaceComp", package.seeall)

local RougeCollectionChessPlaceComp = class("RougeCollectionChessPlaceComp", BaseView)

function RougeCollectionChessPlaceComp:onInitView()
	self._btnclosetipArea = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_closetipArea")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gochessContainer = gohelper.findChild(self.viewGO, "chessboard/#go_chessContainer")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	self._godragContainer = gohelper.findChild(self.viewGO, "chessboard/#go_dragContainer")
	self._gocellModel = gohelper.findChild(self.viewGO, "chessboard/#go_cellModel")
	self._gochessitem = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer/#go_chessitem")
	self._goraychessitem = gohelper.findChild(self.viewGO, "chessboard/#go_raychessitem")
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")
	self._scrollbag = gohelper.findChildScrollRect(self.viewGO, "#scroll_bag")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/#go_Content")
	self._gocollectionItem = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/#go_Content/#go_collectionItem")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._gosingleTipsContent = gohelper.findChild(self.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	self._gosingleAttributeItem = gohelper.findChild(self.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionChessPlaceComp:addEvents()
	return
end

function RougeCollectionChessPlaceComp:removeEvents()
	return
end

function RougeCollectionChessPlaceComp:_editableInitView()
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.Start2CheckAndPlace, self.try2PlaceCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.PlaceCollection2SlotArea, self.placeCollection2SlotAreaWithAudio, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.OnBeginDragCollection, self._onBeginDragCollection, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.DeleteSlotCollection, self.deleteSlotCollection, self)
	self.addEventCb(self, RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, self.updateEnchantInfo, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, self.placeCollection2OriginPos, self)

	self._poolComp = self.viewContainer:getRougePoolComp()
	self._placeCollectionMap = self:getUserDataTb_()
	self._placeHoleIndexMap = {}
end

function RougeCollectionChessPlaceComp:onOpen()
	self:placeAllBagCollections()
end

function RougeCollectionChessPlaceComp:onUpdateParam()
	return
end

function RougeCollectionChessPlaceComp:placeAllBagCollections()
	local collections = RougeCollectionModel.instance:getSlotAreaCollection()

	if collections then
		for _, collectionMO in ipairs(collections) do
			self:placeCollection2SlotArea(collectionMO)
		end
	end
end

function RougeCollectionChessPlaceComp:placeCollection2SlotAreaWithAudio(collectionMO)
	self:placeCollection2SlotArea(collectionMO)
	AudioMgr.instance:trigger(AudioEnum.UI.PlaceSlotCollection)
end

function RougeCollectionChessPlaceComp:placeCollection2SlotArea(collectionMO)
	if not collectionMO then
		return
	end

	self:revertErrorCollection(collectionMO.id)

	local collectionItem = self:getOrCreateCollectionItem(collectionMO.id)

	collectionItem:onUpdateMO(collectionMO)
	collectionItem:setHoleToolVisible(true)
	collectionItem:setShowTypeFlagVisible(true)
	collectionItem:setParent(self._gocellModel.transform, false)
end

function RougeCollectionChessPlaceComp:getOrCreateCollectionItem(collectionId)
	local collectionItem = self._placeCollectionMap[collectionId]

	if not collectionItem then
		collectionItem = self._poolComp:getCollectionItem(RougeCollectionDragItem.__cname)
		self._placeCollectionMap[collectionId] = collectionItem
	end

	return collectionItem
end

function RougeCollectionChessPlaceComp:_onBeginDragCollection(collectionMO)
	local collectionId = collectionMO and collectionMO.id

	self:revertErrorCollection(collectionId)

	local collectionItem = self._placeCollectionMap[collectionId]

	if collectionItem then
		collectionItem:setItemVisible(false)
	end
end

function RougeCollectionChessPlaceComp:revertErrorCollection(newCollectionId)
	if self._errorItemId and self._errorItemId > 0 and self._errorItemId ~= newCollectionId then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, self._errorItemId)

		self._errorItemId = nil
	end
end

function RougeCollectionChessPlaceComp:try2PlaceCollection(collectionMO, dragCollectionPos)
	if not collectionMO then
		return
	end

	self:revertErrorCollection(collectionMO.id)

	local collectionCfgId = collectionMO.cfgId
	local centerSlotPos = collectionMO:getCenterSlotPos()
	local rotation = collectionMO:getRotation()
	local leftTopPos = collectionMO:getLeftTopPos()
	local isInSlotArea = RougeCollectionHelper.checkIsCollectionSlotArea(collectionCfgId, leftTopPos, rotation)
	local isUnremovable = RougeCollectionHelper.isUnremovableCollection(collectionCfgId)

	if not isInSlotArea then
		if isUnremovable then
			local collectionName = RougeCollectionConfig.instance:getCollectionName(collectionCfgId)

			GameFacade.showToast(ToastEnum.RougeUnRemovableCollection, collectionName)
			RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, collectionMO.id)
		else
			self:removeCollectionFromSlotArea(collectionMO)
		end

		return
	end

	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)
	local isEnchant = collectionCfg and collectionCfg.type == RougeEnum.CollectionType.Enchant

	if isEnchant and not isUnremovable then
		local placeCollectionId = RougeCollectionModel.instance:getSlotFilledCollectionId(centerSlotPos.x, centerSlotPos.y)
		local isSucc = self:tryPlaceEnchant2Collection(placeCollectionId, collectionMO.id)

		if isSucc then
			return
		end
	end

	local hasSpace2Put = self:checkHasSpace2Place(collectionMO, centerSlotPos, rotation)

	if hasSpace2Put then
		RougeCollectionChessController.instance:placeCollection2SlotArea(collectionMO.id, leftTopPos, rotation)
	else
		local collectionItem = self:getOrCreateCollectionItem(collectionMO.id)

		collectionItem:onUpdateMO(collectionMO)
		collectionItem:setShapeCellsVisible(true)
		collectionItem:setSelectFrameVisible(true)
		collectionItem:setParent(self._gocellModel.transform, false)

		self._errorItemId = collectionMO.id

		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.NullSpace2PlaceCollection, collectionMO)
	end
end

function RougeCollectionChessPlaceComp:placeCollection2OriginPos(collectionId, isDelete)
	local collectionItem = self._placeCollectionMap[collectionId]
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if collectionItem and collectionMO then
		local isInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionId)

		if isInSlotArea and not isDelete then
			collectionItem:onUpdateMO(collectionMO)
			collectionItem:setShapeCellsVisible(false)
		else
			self._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, collectionItem)

			self._placeCollectionMap[collectionId] = nil
		end
	end
end

function RougeCollectionChessPlaceComp:checkHasSpace2Place(collectionMO, centerSlotPos, rotation)
	local hasSpace2Put = true

	if collectionMO then
		local collectionCfgId = collectionMO:getCollectionCfgId()
		local shapeCfg = RougeCollectionConfig.instance:getRotateEditorParam(collectionCfgId, rotation, RougeEnum.CollectionEditorParamType.Shape)

		if shapeCfg then
			for _, cellPos in ipairs(shapeCfg) do
				local posBaseCenterX = cellPos.x + centerSlotPos.x
				local posBaseCenterY = centerSlotPos.y - cellPos.y
				local isInSlotArea = self:isInSlotAreaSize(posBaseCenterX, posBaseCenterY)
				local filledCollectionId = RougeCollectionModel.instance:getSlotFilledCollectionId(posBaseCenterX, posBaseCenterY)
				local isFilledCollection = filledCollectionId and filledCollectionId > 0 and filledCollectionId ~= collectionMO.id

				if not isInSlotArea or isFilledCollection then
					hasSpace2Put = false

					break
				end
			end
		end
	end

	return hasSpace2Put
end

function RougeCollectionChessPlaceComp:isInSlotAreaSize(posX, posY)
	local slotAreaSize = RougeCollectionModel.instance:getCurSlotAreaSize()

	if posX >= 0 and posX < slotAreaSize.row and posY >= 0 and posY < slotAreaSize.col then
		return true
	end
end

function RougeCollectionChessPlaceComp:removeCollectionFromSlotArea(collectionMO)
	if not collectionMO then
		return
	end

	local collectionId = collectionMO:getCollectionId()
	local isInSlotArea = RougeCollectionModel.instance:isCollectionPlaceInSlotArea(collectionId)

	if isInSlotArea then
		RougeCollectionChessController.instance:deselectCollection()
		RougeCollectionChessController.instance:removeCollectionFromSlotArea(collectionId)
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.Failed2PlaceSlotCollection, collectionId, true)
end

function RougeCollectionChessPlaceComp:tryPlaceEnchant2Collection(collectionId, enchantId)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO or not enchantId or collectionId == enchantId then
		return
	end

	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionMO.cfgId)

	if not collectionCfg then
		return
	end

	local isEnchantCollection = collectionCfg.type == RougeEnum.CollectionType.Enchant

	if not collectionCfg.holeNum then
		local holeNum = 0

		if isEnchantCollection or holeNum <= 0 then
			return
		end

		local targetHoleIndex = self:getCollectionNextPlaceHole(collectionId)

		if targetHoleIndex and targetHoleIndex > 0 then
			AudioMgr.instance:trigger(AudioEnum.UI.CollectionEnchant)
			RougeCollectionEnchantController.instance:trySendRogueCollectionEnchantRequest(collectionId, enchantId, targetHoleIndex)
			self:updateCollectionNextPlaceHole(collectionId)

			return true
		end
	end
end

function RougeCollectionChessPlaceComp:deleteSlotCollection(collectionId)
	if self._placeCollectionMap then
		if self._placeCollectionMap then
			self._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, self._placeCollectionMap)

			self._placeCollectionMap[collectionId] = nil
		end

		if self._placeHoleIndexMap and self._placeHoleIndexMap[collectionId] then
			self._placeHoleIndexMap[collectionId] = nil
		end
	end
end

function RougeCollectionChessPlaceComp:updateEnchantInfo(collectionId)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		return
	end

	local enchantIds = collectionMO:getAllEnchantId()

	if not enchantIds then
		return
	end

	for _, enchantId in pairs(enchantIds) do
		if self._placeCollectionMap then
			if self._placeCollectionMap then
				self._poolComp:recycleCollectionItem(RougeCollectionDragItem.__cname, self._placeCollectionMap)

				self._placeCollectionMap[enchantId] = nil
			end
		end
	end
end

function RougeCollectionChessPlaceComp:getPlaceCollectionItem(collectionId)
	return self._placeCollectionMap and self._placeCollectionMap[collectionId]
end

function RougeCollectionChessPlaceComp:getCollectionNextPlaceHole(collectionId)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		return
	end

	local nextHoleIndex
	local allEnchantIds = collectionMO:getAllEnchantId()

	if allEnchantIds then
		for holeIndex, _ in ipairs(allEnchantIds) do
			local isEnchant = collectionMO:isEnchant(holeIndex)

			if not isEnchant then
				nextHoleIndex = holeIndex

				break
			end
		end
	end

	nextHoleIndex = nextHoleIndex or self._placeHoleIndexMap[collectionId] or 1
	self._placeHoleIndexMap[collectionId] = nextHoleIndex

	return nextHoleIndex
end

function RougeCollectionChessPlaceComp:updateCollectionNextPlaceHole(collectionId)
	local collectionMO = RougeCollectionModel.instance:getCollectionByUid(collectionId)

	if not collectionMO then
		return
	end

	local nextHoleIndex = self._placeHoleIndexMap[collectionId]

	if nextHoleIndex then
		local collectionCfgId = collectionMO.cfgId
		local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)

		if collectionCfg then
			if not collectionCfg.holeNum then
				local holeNum = 0

				nextHoleIndex = (nextHoleIndex + 1) % holeNum

				if nextHoleIndex <= 0 then
					nextHoleIndex = holeNum
				end

				self._placeHoleIndexMap[collectionId] = nextHoleIndex
			end
		end
	end
end

function RougeCollectionChessPlaceComp:onClose()
	return
end

function RougeCollectionChessPlaceComp:onDestroyView()
	self._poolComp = nil

	if self._placeCollectionMap then
		for _, collectionItem in pairs(self._placeCollectionMap) do
			collectionItem:destroy()
		end
	end
end

return RougeCollectionChessPlaceComp
