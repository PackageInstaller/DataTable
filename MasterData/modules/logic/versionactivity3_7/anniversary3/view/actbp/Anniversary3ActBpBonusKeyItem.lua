-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpBonusKeyItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpBonusKeyItem", package.seeall)

local Anniversary3ActBpBonusKeyItem = class("Anniversary3ActBpBonusKeyItem", LuaCompBase)

function Anniversary3ActBpBonusKeyItem:init(go)
	self.go = go
	self._gofree = gohelper.findChild(self.go, "go_free")
	self._gofreenode = gohelper.findChild(self.go, "go_free/go_freenode")
	self._gofreeitem = gohelper.findChild(self.go, "go_free/go_freenode/go_item")
	self._gofreehasget = gohelper.findChild(self.go, "go_free/go_freehasget")
	self._gofreelock = gohelper.findChild(self.go, "go_free/go_freelock")
	self._gofreeunlock = gohelper.findChild(self.go, "go_free/go_freeunlock")
	self._gopay = gohelper.findChild(self.go, "go_pay")
	self._gopaynode = gohelper.findChild(self.go, "go_pay/go_paynode")
	self._gopayitem = gohelper.findChild(self.go, "go_pay/go_paynode/go_item")
	self._gopayhasget = gohelper.findChild(self.go, "go_pay/go_payhasget")
	self._gopayhasget2 = gohelper.findChild(self.go, "go_pay/go_payhasget/get2")
	self._gopaylock = gohelper.findChild(self.go, "go_pay/go_paylock")
	self._gopaylock2 = gohelper.findChild(self.go, "go_pay/go_paylock/lock2")
	self._gopayunlock = gohelper.findChild(self.go, "go_pay/go_payunlock")
	self._gopayunlock2 = gohelper.findChild(self.go, "go_pay/go_payunlock/unlock2")
	self._txtlv = gohelper.findChildText(self.go, "txt_lv")

	self:_init()
	self:_addEvents()
end

function Anniversary3ActBpBonusKeyItem:_init()
	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
	self._bpId = Anniversary3ActBpModel.instance:getCurBpId(self._actId)

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._gofreeitem, false)
	gohelper.setActive(self._gopayitem, false)
	gohelper.setActive(self._gofreeunlock, false)
	gohelper.setActive(self._gopayunlock, false)

	self._freeBonusList = {}
	self._payBonusList = {}
end

function Anniversary3ActBpBonusKeyItem:_addEvents()
	return
end

function Anniversary3ActBpBonusKeyItem:_removeEvents()
	return
end

function Anniversary3ActBpBonusKeyItem:refresh(co)
	self._config = co
	self._mo = Anniversary3ActBpModel.instance:getActBpBonusInfo(self._config.level, self._bpId, self._actId)

	if self._mo then
		local hasGetFree = self._mo.hasGetFreeBonus
		local level = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)
		local canGetFree = level >= self._config.level

		self._canGetFree = canGetFree

		gohelper.setActive(self._gofreelock, not canGetFree)
		gohelper.setActive(self._gofreehasget, canGetFree and hasGetFree)

		local freeBonusList = GameUtil.splitString2(self._config.freeBonus, true)

		self:_setBonus(freeBonusList, self._freeBonusList, self._gofreeitem, hasGetFree)

		if self._mo then
			local hasGetPay = self._mo.hasGetPayBonus
			local hasPay = Anniversary3ActBpModel.instance:isPremiumPayed(self._bpId, self._actId)
			local canGetPay = canGetFree and hasPay
			local payBonusList = GameUtil.splitString2(self._config.payBonus, true)

			self._canGetPay = canGetPay

			gohelper.setActive(self._gopaylock, not canGetPay)
			gohelper.setActive(self._gopayhasget, canGetPay and hasGetPay)
			gohelper.setActive(self._gopaylock2, #payBonusList == 2)
			gohelper.setActive(self._gopayhasget2, #payBonusList == 2)
			gohelper.setActive(self._gopayunlock2, #payBonusList == 2)
			self:_setBonus(payBonusList, self._payBonusList, self._gopayitem, hasGetPay)

			self._txtlv.text = string.format(luaLang("rank_level_display1"), self._config.level)
		end
	end
end

function Anniversary3ActBpBonusKeyItem:_setBonus(itemSp, itemIconList, itemPrefab, hasGet)
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
		itemIcon:SetCountLocalY(43.6)
		itemIcon:SetCountBgHeight(40)
		itemIcon:SetCountBgScale(1, 1.3, 1)
		itemIcon:showStackableNum()
		itemIcon:setHideLvAndBreakFlag(true)
		itemIcon:hideEquipLvAndBreak(true)

		if hasGet then
			itemIcon:setAlpha(0.45, 0.8)
		else
			itemIcon:setAlpha(1, 1)
		end

		itemIcon:isShowCount(one[1] ~= MaterialEnum.MaterialType.HeroSkin)
		gohelper.setActive(itemIcon.go.transform.parent.gameObject, true)
	end

	for i = #itemSp + 1, #itemIconList do
		local itemIcon = itemIconList[i]

		gohelper.setActive(itemIcon.go.transform.parent.gameObject, false)
	end
end

function Anniversary3ActBpBonusKeyItem:destroy()
	self:_removeEvents()

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

return Anniversary3ActBpBonusKeyItem
