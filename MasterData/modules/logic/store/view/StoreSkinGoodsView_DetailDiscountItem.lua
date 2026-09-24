-- chunkname: @modules/logic/store/view/StoreSkinGoodsView_DetailDiscountItem.lua

local ti = table.insert

module("modules.logic.store.view.StoreSkinGoodsView_DetailDiscountItem", package.seeall)

local StoreSkinGoodsView_DetailDiscountItem = class("StoreSkinGoodsView_DetailDiscountItem", RougeSimpleItemBase)

function StoreSkinGoodsView_DetailDiscountItem:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinGoodsView_DetailDiscountItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function StoreSkinGoodsView_DetailDiscountItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function StoreSkinGoodsView_DetailDiscountItem:_btnclickOnClick()
	local p = self:parent()

	p:onClickDetailDiscountItem(self)
end

function StoreSkinGoodsView_DetailDiscountItem:onDestroyView()
	GameUtil.onDestroyViewMember_SImage(self, "_icon")
	StoreSkinGoodsView_DetailDiscountItem.super.onDestroyView(self)
end

function StoreSkinGoodsView_DetailDiscountItem:ctor(...)
	StoreSkinGoodsView_DetailDiscountItem.super.ctor(self, ...)
end

local kUIEffectTypeStr = "Coffee.UIEffects.UIEffect"

function StoreSkinGoodsView_DetailDiscountItem:_editableInitView()
	StoreSkinGoodsView_DetailDiscountItem.super._editableInitView(self)

	self._emptyGo = gohelper.findChild(self.viewGO, "empty")
	self._hasGo = gohelper.findChild(self.viewGO, "has")
	self._txtdiscount1 = gohelper.findChildText(self._hasGo, "cost/#txt_discount_1")
	self._txtdiscount2 = gohelper.findChildText(self._hasGo, "cost/#txt_discount_2")
	self._bg = gohelper.findChild(self._hasGo, "bg")
	self._iconbg = gohelper.findChild(self._hasGo, "iconbg")
	self._icon = gohelper.findChildSingleImage(self._hasGo, "go_icon")
	self._topRight = gohelper.findChild(self._hasGo, "topRight")
	self._selecticonbg = gohelper.findChild(self._topRight, "empty")
	self._selecticon = gohelper.findChild(self._topRight, "selecticon")
	self._lockicon = gohelper.findChild(self._topRight, "lockicon")
	self._gang = gohelper.findChild(self._hasGo, "cost/gang")
	self._gangTxt = gohelper.findChildText(self._gang, "")
	self._txtdiscount1.text = ""
	self._txtdiscount2.text = ""
	self._uiEffectCmpList = self:getUserDataTb_()

	ti(self._uiEffectCmpList, self._bg:GetComponent(kUIEffectTypeStr))
	ti(self._uiEffectCmpList, self._iconbg:GetComponent(kUIEffectTypeStr))
	ti(self._uiEffectCmpList, self._icon:GetComponent(kUIEffectTypeStr))
	ti(self._uiEffectCmpList, self._selecticonbg:GetComponent(kUIEffectTypeStr))
	ti(self._uiEffectCmpList, self._selecticon:GetComponent(kUIEffectTypeStr))
	ti(self._uiEffectCmpList, self._lockicon:GetComponent(kUIEffectTypeStr))
	self:_setActive_selecticon(false)
	self:_setActive_lockicon(false)
	self:_setActive_gang(false)
	self:_setActive_empty(true)
	self:_setGreyscale(false)
end

function StoreSkinGoodsView_DetailDiscountItem:onSelect(isSelect)
	if self:bEmpty() then
		return
	end

	if self:bGreyscale() then
		return
	end

	if self:bLockSelectState() then
		return
	end

	self:_setAsSelected(isSelect)
end

function StoreSkinGoodsView_DetailDiscountItem:_setAsSelected(isSelect)
	self:setSelectedSlient(isSelect)
	self:_setActive_selecticon(isSelect)

	local bLockSelectState = self:bLockSelectState()
	local bForceSelected = self:bForceSelected()

	if bForceSelected and bLockSelectState then
		-- block empty
	else
		gohelper.setActive(self._selecticon, isSelect)
	end
end

function StoreSkinGoodsView_DetailDiscountItem:setData(mo)
	StoreSkinGoodsView_DetailDiscountItem.super.setData(self, mo)

	local bEmpty = self:bEmpty()

	self:_setActive_empty(bEmpty)

	if not bEmpty then
		local bGreyscale = self:bGreyscale()
		local bLockSelectState = self:bLockSelectState()
		local bForceSelected = self:bForceSelected()

		if bForceSelected then
			self:_setAsSelected(true)
		end

		self:_setActive_lockicon(bLockSelectState)
		self:_setGreyscale(bGreyscale)

		if bForceSelected and bLockSelectState then
			gohelper.setActive(self._selecticon, false)
		end

		local _, iconUrl = ItemModel.instance:getItemConfigAndIcon(mo.itemType, mo.itemId, true)

		self._icon:LoadImage(iconUrl, self._loadImageFinish, self)

		local bShowGang = 0

		if mo.rmbReduction then
			self:_setDiscount1Str("-" .. tostring(mo.rmbReduction))

			bShowGang = bShowGang + 1
		else
			self:_setDiscount1Str("")
		end

		if mo.coinReduction then
			self:_setDiscount2Str(tostring(-mo.coinReduction))

			bShowGang = bShowGang + 1
		else
			self:_setDiscount2Str("")
		end

		self:_setActive_gang(bShowGang == 2)
	end
end

function StoreSkinGoodsView_DetailDiscountItem:_loadImageFinish(mo)
	return
end

function StoreSkinGoodsView_DetailDiscountItem:_setActive_empty(bEmpty)
	gohelper.setActive(self._emptyGo, bEmpty)
	gohelper.setActive(self._hasGo, not bEmpty)
end

function StoreSkinGoodsView_DetailDiscountItem:_setActive_selecticon(bActive)
	gohelper.setActive(self._bg, bActive)
end

function StoreSkinGoodsView_DetailDiscountItem:_setActive_lockicon(bActive)
	gohelper.setActive(self._lockicon, bActive)
end

function StoreSkinGoodsView_DetailDiscountItem:_setActive_gang(bActive)
	gohelper.setActive(self._gang, bActive)
end

function StoreSkinGoodsView_DetailDiscountItem:_setDiscount2Str(str)
	if str == "" then
		gohelper.setActive(self._txtdiscount2, false)

		return
	end

	gohelper.setActive(self._txtdiscount2, true)

	self._txtdiscount2.text = str
end

function StoreSkinGoodsView_DetailDiscountItem:_setDiscount1Str(str)
	if str == "" then
		gohelper.setActive(self._txtdiscount1, false)

		return
	end

	gohelper.setActive(self._txtdiscount1, true)

	self._txtdiscount1.text = str
end

local kWhite = "#C76436"
local kGrey = "#818181"

function StoreSkinGoodsView_DetailDiscountItem:_setGreyscale(bGreyscale)
	UIColorHelper.set(self._txtdiscount1, (bGreyscale or nil) and (kGrey or kWhite))
	UIColorHelper.set(self._txtdiscount2, (bGreyscale or nil) and (kGrey or kWhite))
	UIColorHelper.set(self._gangTxt, (bGreyscale or nil) and (kGrey or kWhite))
	self:_setGreyscale_uiEffectCmpList(bGreyscale)
end

function StoreSkinGoodsView_DetailDiscountItem:_setGreyscale_uiEffectCmpList(bGreyscale)
	for _, cmp in pairs(self._uiEffectCmpList) do
		if cmp then
			cmp.enabled = not not bGreyscale
		end
	end
end

function StoreSkinGoodsView_DetailDiscountItem:bEmpty()
	return not self._mo
end

function StoreSkinGoodsView_DetailDiscountItem:bGreyscale()
	if self:bEmpty() then
		return false
	end

	return self._mo.bGreyscale
end

function StoreSkinGoodsView_DetailDiscountItem:bLockSelectState()
	if self:bEmpty() then
		return false
	end

	return self._mo.bLockSelectState
end

function StoreSkinGoodsView_DetailDiscountItem:bForceSelected()
	if self:bEmpty() then
		return false
	end

	return self._mo.bForceSelected
end

function StoreSkinGoodsView_DetailDiscountItem:mo()
	if self:bEmpty() then
		return nil
	end

	return self._mo
end

return StoreSkinGoodsView_DetailDiscountItem
