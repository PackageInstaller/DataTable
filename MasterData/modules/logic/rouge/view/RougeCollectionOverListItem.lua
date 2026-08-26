-- chunkname: @modules/logic/rouge/view/RougeCollectionOverListItem.lua

module("modules.logic.rouge.view.RougeCollectionOverListItem", package.seeall)

local RougeCollectionOverListItem = class("RougeCollectionOverListItem", ListScrollCellExtend)

function RougeCollectionOverListItem:onInitView()
	self._goicon = gohelper.findChild(self.viewGO, "#go_icon")
	self._txtdec = gohelper.findChildText(self.viewGO, "#txt_dec")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionOverListItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function RougeCollectionOverListItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RougeCollectionOverListItem:_btnclickOnClick()
	local params = {
		interactable = false,
		collectionId = self._mo.id,
		viewPosition = RougeEnum.CollectionTipViewPlacePos,
		source = RougeEnum.OpenCollectionTipSource.SlotArea
	}

	RougeController.instance:openRougeCollectionTipView(params)
end

function RougeCollectionOverListItem:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function RougeCollectionOverListItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function RougeCollectionOverListItem:refreshUI()
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(self._mo.cfgId)

	if collectionCfg then
		self:refreshCollectionIcon()

		local enchantCfgIds = self._mo:getAllEnchantCfgId()

		self._txtname.text = RougeCollectionConfig.instance:getCollectionName(self._mo.cfgId, enchantCfgIds)

		local showTypes = RougeCollectionDescHelper.getShowDescTypesWithoutText()
		local extraParams = RougeCollectionDescHelper.getExtraParams_KeepAllActive()

		RougeCollectionDescHelper.setCollectionDescInfos4(self._mo.id, self._txtdec, showTypes, extraParams)
	end
end

local collectionIconWidth, collectionIconHeight = 160, 160

function RougeCollectionOverListItem:refreshCollectionIcon()
	if not self._itemIcon then
		local setting = ViewMgr.instance:getSetting(ViewName.RougeCollectionOverView)
		local itemIconGO = self._view:getResInst(setting.otherRes[1], self._goicon, "itemicon")

		self._itemIcon = RougeCollectionEnchantIconItem.New(itemIconGO)

		self._itemIcon:setCollectionIconSize(collectionIconWidth, collectionIconHeight)
	end

	self._itemIcon:onUpdateMO(self._mo)
end

function RougeCollectionOverListItem:getAnimator()
	return self._animator
end

function RougeCollectionOverListItem:onDestroyView()
	if self._itemIcon then
		self._itemIcon:destroy()

		self._itemIcon = nil
	end
end

return RougeCollectionOverListItem
