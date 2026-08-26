-- chunkname: @modules/logic/battlepass/view/BpSPBonusKeyItem.lua

module("modules.logic.battlepass.view.BpSPBonusKeyItem", package.seeall)

local BpSPBonusKeyItem = class("BpSPBonusKeyItem", ListScrollCell)

function BpSPBonusKeyItem:init(go)
	self.go = go
	self._txtLevel = gohelper.findChildText(self.go, "#txtLevel")
	self._freeItemGO = gohelper.findChild(self.go, "free/freenode/#goItem")
	self._payItemGO = gohelper.findChild(self.go, "pay/paynode/#goItem")
	self._freeHasGet = gohelper.findChild(self.go, "free/#goHasGet")
	self._payHasGet = gohelper.findChild(self.go, "pay/#goHasGet")
	self.freelock = gohelper.findChild(self.go, "free/freelock/lock")
	self.paylock = gohelper.findChild(self.go, "pay/paylock/lock1")
	self.paylock2 = gohelper.findChild(self.go, "pay/paylock/lock2")
	self._payHasGet1 = gohelper.findChild(self.go, "pay/#goHasGet/get1")
	self._payHasGet2 = gohelper.findChild(self.go, "pay/#goHasGet/get2")
	self._getcanvasGroup1 = gohelper.onceAddComponent(self._payHasGet1, typeof(UnityEngine.CanvasGroup))
	self._getcanvasGroup2 = gohelper.onceAddComponent(self._payHasGet2, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(self._freeItemGO, false)
	gohelper.setActive(self._payItemGO, false)

	self._freeBonusList = {}
	self._payBonusList = {}
	self._selectBonusList = {}
end

function BpSPBonusKeyItem:addEvents()
	self.addEventCb(self, BpController.instance, BpEvent.onSelectBonusGet, self._refreshSelect, self)
end

function BpSPBonusKeyItem:removeEvents()
	self.removeEventCb(self, BpController.instance, BpEvent.onSelectBonusGet, self._refreshSelect, self)
end

function BpSPBonusKeyItem:onUpdateMO(mo)
	self.mo = mo
	self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_level"), self.mo.level)

	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local canGet = level >= self.mo.level
	local canGetFree = level >= self.mo.level
	local canGetPay = level >= self.mo.level
	local hasGetFree = self.mo.hasGetSpfreeBonus
	local hasGetPay = self.mo.hasGetSpPayBonus
	local hasGetSelect = BpBonusModel.instance:isGetSelectBonus(self.mo.level)
	local levelCO = BpConfig.instance:getBonusCO(BpModel.instance.id, self.mo.level)
	local freeBonusSp = GameUtil.splitString2(levelCO.spFreeBonus, true)
	local payBonusSp = GameUtil.splitString2(levelCO.spPayBonus, true)
	local selectBonus = GameUtil.splitString2(levelCO.selfSelectPayItem, true) or {}

	self:_setBonus(freeBonusSp, self._freeBonusList, self._freeItemGO, self._onFreeItemIconClick, canGet, hasGetFree)
	self:_setBonus(payBonusSp, self._payBonusList, self._payItemGO, self._onPayItemIconClick, canGet, hasGetPay)
	self:_setBonus(selectBonus, self._selectBonusList, self._payItemGO, self._onselectItemIconClick, canGetPay, hasGetSelect, true)

	if #selectBonus > 0 then
		if #payBonusSp > 0 then
			self._getcanvasGroup1.alpha = canGetPay and hasGetPay and 1 or 0
			self._getcanvasGroup2.alpha = hasGetSelect and 1 or 0
		else
			self._getcanvasGroup1.alpha = hasGetSelect and 1 or 0
		end
	else
		self._getcanvasGroup1.alpha = 1
		self._getcanvasGroup2.alpha = 1
	end

	gohelper.setActive(self._freeHasGet, canGetFree and hasGetFree)
	gohelper.setActive(self._payHasGet, canGetPay and hasGetPay or hasGetSelect)
	gohelper.setActive(self.freelock, not canGetFree)
	gohelper.setActive(self.paylock, not canGetPay)
	gohelper.setActive(self.paylock2, not canGetPay and #payBonusSp + #selectBonus == 2)
	gohelper.setActive(self._payHasGet2, #payBonusSp + #selectBonus == 2)
end

function BpSPBonusKeyItem:_setBonus(itemSp, itemIconList, itemPrefab, clickCb, canGet, hasGet, isCustomCall)
	for i, one in ipairs(itemSp) do
		local itemIcon = itemIconList[i]

		if not itemIcon then
			local itemParentGO = gohelper.cloneInPlace(itemPrefab)

			gohelper.setActive(itemParentGO, true)

			itemIcon = IconMgr.instance:getCommonPropItemIcon(itemParentGO)

			table.insert(itemIconList, itemIcon)
		end

		gohelper.setAsFirstSibling(itemIcon.go)
		itemIcon:setMOValue(one[1], one[2], one[3], nil, true)

		if one[1] == MaterialEnum.MaterialType.Equip then
			itemIcon._equipIcon._overrideLoadIconFunc(itemIcon._equipIcon, EquipHelper.getEquipDefaultIconLoadPath, itemIcon._equipIcon)
			itemIcon._equipIcon:_loadIconImage()
		end

		itemIcon:setCountFontSize(46)
		itemIcon:setScale(0.6)

		local itemSize, x, y = BpConfig.instance:getItemShowSize(one[1], one[2])

		itemIcon:setItemIconScale(itemSize)
		itemIcon:setItemOffset(x, y)
		itemIcon:SetCountLocalY(43.6)
		itemIcon:SetCountBgHeight(40)
		itemIcon:SetCountBgScale(1, 1.3, 1)
		itemIcon:showStackableNum()
		itemIcon:setHideLvAndBreakFlag(true)
		itemIcon:hideEquipLvAndBreak(true)

		if isCustomCall then
			itemIcon:customOnClickCallback(clickCb, self)
		else
			itemIcon:customOnClickCallback(nil, nil)
		end

		if hasGet then
			itemIcon:setAlpha(0.45, 0.8)
		else
			itemIcon:setAlpha(1, 1)
		end

		itemIcon:isShowCount(one[1] ~= MaterialEnum.MaterialType.HeroSkin and not isCustomCall)
		gohelper.setActive(itemIcon.go.transform.parent.gameObject, true)
	end

	for i = #itemSp + 1, #itemIconList do
		local itemIcon = itemIconList[i]

		gohelper.setActive(itemIcon.go.transform.parent.gameObject, false)
	end
end

function BpSPBonusKeyItem:_onselectItemIconClick()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function BpSPBonusKeyItem:_onFreeItemIconClick()
	return
end

function BpSPBonusKeyItem:_onPayItemIconClick()
	return
end

function BpSPBonusKeyItem:_refreshSelect(level)
	if level ~= self.mo.level then
		return
	end

	self:onUpdateMO(self.mo)
end

function BpSPBonusKeyItem:onDestroyView()
	if self._freeBonusList then
		for _, itemIcon in pairs(self._freeBonusList) do
			itemIcon:onDestroy()
		end

		self._freeBonusList = nil
	end

	if self._payBonusList then
		for _, itemIcon in pairs(self._payBonusList) do
			itemIcon:onDestroy()
		end

		self._payBonusList = nil
	end
end

return BpSPBonusKeyItem
