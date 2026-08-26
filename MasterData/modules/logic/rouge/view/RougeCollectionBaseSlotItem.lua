-- chunkname: @modules/logic/rouge/view/RougeCollectionBaseSlotItem.lua

module("modules.logic.rouge.view.RougeCollectionBaseSlotItem", package.seeall)

local RougeCollectionBaseSlotItem = class("RougeCollectionBaseSlotItem", UserDataDispose)

function RougeCollectionBaseSlotItem:onInit(go)
	self:__onInit()

	self.viewGO = go
	self._gocenter = gohelper.findChild(self.viewGO, "go_center")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "go_center/simage_icon")
	self._goholetool = gohelper.findChild(self.viewGO, "go_center/go_holetool")
	self._goholeitem = gohelper.findChild(self.viewGO, "go_center/go_holetool/go_holeitem")
	self._imageenchanticon = gohelper.findChild(self.viewGO, "go_center/go_holetool/go_holeitem/image_enchanticon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionBaseSlotItem:_editableInitView()
	self.addEventCb(self, RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, self.updateEnchantInfo, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.SetCollectionVisible, self.setCollectionVisibleCallBack, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, self.failed2PlaceSlotCollection, self)

	self._holeItemTab = self:getUserDataTb_()
	self._canvasgroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)

	self:setPerCellWidthAndHeight()
end

function RougeCollectionBaseSlotItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshCollectionIcon()
	self:updateItemSize()
	self:refreshAllHoles()
	self:onUpdateRotateAngle()
	self:setItemVisible(true)
	self:updateIconPosition()
	self:updateCollectionPosition()
end

function RougeCollectionBaseSlotItem:setPerCellWidthAndHeight(perCellWidth, perCellHeight)
	self._perCellWidth = perCellWidth or RougeCollectionHelper.CollectionSlotCellSize.x
	self._perCellHeight = perCellHeight or RougeCollectionHelper.CollectionSlotCellSize.y
end

function RougeCollectionBaseSlotItem:refreshCollectionIcon()
	self._collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(self._mo.cfgId)

	local iconUrl = RougeCollectionHelper.getCollectionIconUrl(self._mo.cfgId)

	self._simageicon:LoadImage(iconUrl)
	self:setIconRoateAngle()
	RougeCollectionHelper.computeAndSetCollectionIconScale(self._mo.cfgId, self._simageicon.transform, self._perCellWidth, self._perCellHeight)
end

function RougeCollectionBaseSlotItem:onUpdateRotateAngle()
	self:updateItemSize()
	self:setIconRoateAngle()
	self:updateHoleContainerPos()
end

function RougeCollectionBaseSlotItem:updateItemSize()
	local rotation = self._mo:getRotation()
	local width, height = RougeCollectionHelper.getCollectionSizeAfterRotation(self._mo.cfgId, rotation)

	width = self._perCellWidth * width
	height = self._perCellHeight * height

	recthelper.setSize(self.viewGO.transform, width, height)
end

function RougeCollectionBaseSlotItem:refreshAllHoles()
	local allEnchants = self._mo:getAllEnchantId() or {}

	gohelper.CreateObjList(self, self.refrehHole, allEnchants, self._goholetool, self._goholeitem)
	self:updateHoleContainerPos()
end

RougeCollectionBaseSlotItem.BaseHoleContainerAnchorPosX = 0

function RougeCollectionBaseSlotItem:updateHoleContainerPos()
	if not self._collectionCfg.holeNum then
		if self._collectionCfg.holeNum <= 0 then
			return
		end

		local rotation = self._mo:getRotation()
		local rotationMatrix = RougeCollectionConfig.instance:getShapeMatrix(self._mo.cfgId, rotation)
		local rowCount = tabletool.len(rotationMatrix)
		local lastRow = rotationMatrix[rowCount]
		local emptyCellCount = 0
		local lastRowCellCount = #lastRow

		for i = lastRowCellCount, 1, -1 do
			if lastRow[i] then
				local isCell = lastRow[i] > 0

				if isCell then
					emptyCellCount = lastRowCellCount - i

					break
				end
			end
		end

		local holeContainerOffset = -emptyCellCount * RougeCollectionHelper.CollectionSlotCellSize.x
		local holeAnchorPosX = RougeCollectionBaseSlotItem.BaseHoleContainerAnchorPosX + holeContainerOffset

		recthelper.setAnchorX(self._goholetool.transform, holeAnchorPosX)
	end
end

function RougeCollectionBaseSlotItem:refrehHole(obj, enchantId, index)
	local gonone = gohelper.findChild(obj, "go_none")
	local goget = gohelper.findChild(obj, "go_get")
	local hasEncahnt = enchantId and enchantId > 0

	gohelper.setActive(goget, hasEncahnt)
	gohelper.setActive(gonone, not hasEncahnt)

	self._holeItemTab[index] = self._holeItemTab[index] or obj

	if not hasEncahnt then
		return
	end

	local iconImg = gohelper.findChildSingleImage(obj, "go_get/image_enchanticon")
	local _, enchantCfgId = self._mo:getEnchantIdAndCfgId(index)
	local iconUrl = RougeCollectionHelper.getCollectionIconUrl(enchantCfgId)

	iconImg:LoadImage(iconUrl)
end

function RougeCollectionBaseSlotItem:getHoleObj(holeIndex)
	return self._holeItemTab and self._holeItemTab[holeIndex]
end

function RougeCollectionBaseSlotItem:getAllHoleObj()
	return self._holeItemTab
end

function RougeCollectionBaseSlotItem:setCollectionVisibleCallBack(collectionId, isVisible)
	if self._mo and self._mo.id == collectionId then
		self:setItemVisible(isVisible)
	end
end

function RougeCollectionBaseSlotItem:setItemVisible(isVisible)
	gohelper.setActive(self.viewGO, isVisible)
	self:setCanvasGroupVisible(isVisible)
end

function RougeCollectionBaseSlotItem:setCanvasGroupVisible(isVisible)
	self._canvasgroup.alpha = isVisible and 1 or 0

	self:setCollectionInteractable(isVisible)
end

function RougeCollectionBaseSlotItem:setCollectionInteractable(interactable)
	self._canvasgroup.interactable = interactable
	self._canvasgroup.blocksRaycasts = interactable
end

function RougeCollectionBaseSlotItem:updateEnchantInfo(collectionId)
	if not self._mo or self._mo.id ~= collectionId then
		return
	end

	local enchantIds = self._mo:getAllEnchantId()

	if not enchantIds then
		return
	end

	for holeIndex, enchantId in pairs(enchantIds) do
		local holeObj = self:getHoleObj(holeIndex)

		if holeObj then
			self:refrehHole(holeObj, enchantId, holeIndex)
		end
	end
end

function RougeCollectionBaseSlotItem:setHoleToolVisible(isVisible)
	gohelper.setActive(self._goholetool, isVisible)
end

function RougeCollectionBaseSlotItem:setIconRoateAngle()
	local rotation = self._mo:getRotation()
	local rotateAngle = RougeCollectionHelper.getRotateAngleByRotation(rotation)

	transformhelper.setLocalRotation(self._simageicon.transform, 0, 0, rotateAngle)
end

function RougeCollectionBaseSlotItem:updateIconPosition()
	local collectionCfgId = self._mo.cfgId
	local iconOffset = RougeCollectionConfig.instance:getOriginEditorParam(collectionCfgId, RougeEnum.CollectionEditorParamType.IconOffset)

	recthelper.setAnchor(self._gocenter.transform, iconOffset.x, iconOffset.y)
end

function RougeCollectionBaseSlotItem:updateCollectionPosition()
	if not self._mo or not self._mo.getLeftTopPos then
		return
	end

	local leftTopPos = self._mo:getLeftTopPos()
	local posX, posY = RougeCollectionHelper.getCollectionPlacePosition(leftTopPos, self._perCellWidth, self._perCellHeight)

	self:setCollectionPosition(posX, posY)
end

function RougeCollectionBaseSlotItem:setCollectionPosition(posX, posY)
	recthelper.setAnchor(self.viewGO.transform, posX, posY)
end

function RougeCollectionBaseSlotItem:failed2PlaceSlotCollection(collectionId)
	if self._mo and self._mo.id == collectionId then
		self:setItemVisible(true)
	end
end

function RougeCollectionBaseSlotItem:reset()
	self._mo = nil

	self:setItemVisible(false)
end

function RougeCollectionBaseSlotItem:destroy()
	self._simageicon:UnLoadImage()

	if self._holeItemTab then
		for _, obj in pairs(self._holeItemTab) do
			local iconImage = gohelper.findChildSingleImage(obj, "go_get/image_enchanticon")

			iconImage:UnLoadImage()
		end
	end

	self:__onDispose()
end

return RougeCollectionBaseSlotItem
