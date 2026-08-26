-- chunkname: @modules/logic/rouge/view/RougeCollectionBagItem.lua

module("modules.logic.rouge.view.RougeCollectionBagItem", package.seeall)

local RougeCollectionBagItem = class("RougeCollectionBagItem", UserDataDispose)

function RougeCollectionBagItem:onInitView(parentViewInst, viewGO)
	self:__onInit()

	self.parentViewInst = parentViewInst
	self.viewGO = viewGO
	self._gopos = gohelper.findChild(self.viewGO, "go_pos")
	self._txtname = gohelper.findChildText(self.viewGO, "right/txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "right/Scroll View/Viewport/Content/txt_desc")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_detail")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_equip")
	self._goselectframe = gohelper.findChild(self.viewGO, "#go_selectframe")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionBagItem:_editableInitView()
	self:AddDragListeners()
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)

	self._canvasgroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)

	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.Failed2PlaceSlotCollection, self.failed2PlaceSlotCollection, self)
	self.addEventCb(self, RougeCollectionEnchantController.instance, RougeEvent.UpdateCollectionEnchant, self._updateCollectionEnchant, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.UpdateCollectionAttr, self.updateCollectionAttr, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.SwitchCollectionInfoType, self._onSwitchCollectionInfoType, self)
	self.addEventCb(self, RougeCollectionChessController.instance, RougeEvent.SelectCollection, self._selectCollection, self)
end

function RougeCollectionBagItem:AddDragListeners()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.viewGO)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
end

function RougeCollectionBagItem:releaseDragListeners()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
		self._drag:RemoveDragListener()

		self._drag = nil
	end
end

function RougeCollectionBagItem:_btndetailOnClick()
	local params = {
		useCloseBtn = false,
		collectionId = self._mo.id,
		viewPosition = RougeEnum.CollectionTipPos.Bag,
		source = RougeEnum.OpenCollectionTipSource.BagArea
	}

	RougeController.instance:openRougeCollectionTipView(params)
	RougeCollectionChessController.instance:selectCollection(self._mo.id)
end

function RougeCollectionBagItem:_btnequipOnClick()
	RougeCollectionChessController.instance:autoPlaceCollection2SlotArea(self._mo.id)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

function RougeCollectionBagItem:_onDragBegin(param, pointerEventData)
	local canDrag = RougeCollectionHelper.isCanDragCollection()

	self._isDraging = canDrag

	if not canDrag then
		return
	end

	self:setCanvasGroupVisible(false)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnBeginDragCollection, self._mo, pointerEventData)
end

function RougeCollectionBagItem:_onDrag(param, pointerEventData)
	if not self._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnDragCollection, pointerEventData)
end

function RougeCollectionBagItem:_onDragEnd(param, pointerEventData)
	if not self._isDraging then
		return
	end

	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.OnEndDragCollection, pointerEventData)
end

local collectionIconWidth, collectionIconHeight = 160, 160

function RougeCollectionBagItem:onUpdateMO(mo)
	self._mo = mo

	if not self._itemIcon then
		local setting = ViewMgr.instance:getSetting(ViewName.RougeCollectionChessView)
		local itemIconGO = self.parentViewInst:getResInst(setting.otherRes[1], self._gopos, "itemicon")

		self._itemIcon = RougeCollectionEnchantIconItem.New(itemIconGO)

		self._itemIcon:setCollectionIconSize(collectionIconWidth, collectionIconHeight)
	end

	self._itemIcon:onUpdateMO(self._mo)

	local enchantCfgIds = self._mo:getAllEnchantCfgId()

	self._txtname.text = RougeCollectionConfig.instance:getCollectionName(self._mo.cfgId, enchantCfgIds)

	self:refreshCollectionDesc()
	gohelper.setActive(self._goselectframe, false)
	self:setItemVisible(true)
end

function RougeCollectionBagItem:refreshCollectionDesc()
	if not self._mo then
		return
	end

	local showTypes = RougeCollectionDescHelper.getShowDescTypesWithoutText()
	local extraParams = RougeCollectionDescHelper.getExtraParams_KeepAllActive()

	RougeCollectionDescHelper.setCollectionDescInfos4(self._mo.id, self._txtdesc, showTypes, extraParams)
end

function RougeCollectionBagItem:setItemVisible(isVisible)
	gohelper.setActive(self.viewGO, isVisible)
	self:setCanvasGroupVisible(isVisible)
end

function RougeCollectionBagItem:setCanvasGroupVisible(isVisible)
	self._canvasgroup.alpha = isVisible and 1 or 0
	self._canvasgroup.interactable = isVisible
	self._canvasgroup.blocksRaycasts = isVisible
end

function RougeCollectionBagItem:failed2PlaceSlotCollection(collectionId)
	if self._mo and self._mo.id == collectionId then
		self:setItemVisible(true)
	end
end

function RougeCollectionBagItem:_selectCollection()
	if self._mo then
		local collectionId = self._mo.id
		local isSelect = RougeCollectionBagListModel.instance:isCollectionSelect(collectionId)

		gohelper.setActive(self._goselectframe, isSelect)
	end
end

function RougeCollectionBagItem:updateCollectionAttr(updateCollectionId)
	if self._mo then
		if self._mo == updateCollectionId then
			self:refreshCollectionDesc()
		end
	end
end

function RougeCollectionBagItem:_onSwitchCollectionInfoType()
	self:refreshCollectionDesc()
end

function RougeCollectionBagItem:_updateCollectionEnchant(collectionId)
	if not self._mo or self._mo.id ~= collectionId then
		return
	end

	self:refreshCollectionDesc()
end

function RougeCollectionBagItem:reset()
	self._mo = nil
	self._isDraging = false

	self:setItemVisible(false)
end

function RougeCollectionBagItem:destroy()
	self:releaseDragListeners()

	if self._itemIcon then
		self._itemIcon:destroy()

		self._itemIcon = nil
	end

	self._btndetail:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self:__onDispose()
end

return RougeCollectionBagItem
