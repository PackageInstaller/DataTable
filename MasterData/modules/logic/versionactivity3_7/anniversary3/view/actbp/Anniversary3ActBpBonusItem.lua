-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpBonusItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpBonusItem", package.seeall)

local Anniversary3ActBpBonusItem = class("Anniversary3ActBpBonusItem", LuaCompBase)

function Anniversary3ActBpBonusItem:init(go)
	self.go = go
	self._gofree = gohelper.findChild(self.go, "go_free")
	self._gofreenode = gohelper.findChild(self.go, "go_free/go_freenode")
	self._gofreeitem = gohelper.findChild(self.go, "go_free/go_freenode/go_item")
	self._gofreecanget = gohelper.findChild(self.go, "go_free/go_freenode/go_canget")
	self._gofreehasget = gohelper.findChild(self.go, "go_free/go_freehasget")
	self._gofreelock = gohelper.findChild(self.go, "go_free/go_freelock")
	self._gofreeunlock = gohelper.findChild(self.go, "go_free/go_freeunlock")
	self._gopay = gohelper.findChild(self.go, "go_pay")
	self._gopaynode = gohelper.findChild(self.go, "go_pay/go_paynode")
	self._gopaycanget = gohelper.findChild(self.go, "go_pay/go_paynode/go_canget")
	self._gopayitem = gohelper.findChild(self.go, "go_pay/go_paynode/itemlist/go_item")
	self._gopayhasget = gohelper.findChild(self.go, "go_pay/go_payhasget")
	self._gopayhasget2 = gohelper.findChild(self.go, "go_pay/go_payhasget/get2")
	self._gopaylock = gohelper.findChild(self.go, "go_pay/go_paylock")
	self._gopaylock2 = gohelper.findChild(self.go, "go_pay/go_paylock/lock2")
	self._gopayunlock = gohelper.findChild(self.go, "go_pay/go_payunlock")
	self._gopayunlock2 = gohelper.findChild(self.go, "go_pay/go_payunlock/unlock2")
	self._btngetfree = gohelper.findChildButtonWithAudio(self.go, "btn_getfree")
	self._btngetpay = gohelper.findChildButtonWithAudio(self.go, "btn_getpay")
	self._txtlv = gohelper.findChildText(self.go, "txt_lv")

	self:_init()
	self:_addEvents()
end

function Anniversary3ActBpBonusItem:_init()
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

function Anniversary3ActBpBonusItem:_addEvents()
	self._btngetfree:AddClickListener(self._onbtngetfreeOnClick, self)
	self._btngetpay:AddClickListener(self._onbtngetpayOnClick, self)
end

function Anniversary3ActBpBonusItem:_removeEvents()
	self._btngetfree:RemoveClickListener()
	self._btngetpay:RemoveClickListener()
end

function Anniversary3ActBpBonusItem:_onbtngetfreeOnClick()
	local level = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)
	local canGetFree = level >= self._config.level

	if not canGetFree then
		return
	end

	if self._mo then
		local hasGetFree = self._mo.hasGetFreeBonus

		if hasGetFree then
			return
		end

		Activity233Rpc.instance:sendGetAct233BpBonusRequest(self._actId, self._config.level, false)
	end
end

function Anniversary3ActBpBonusItem:_onbtngetpayOnClick()
	local level = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)
	local hasPay = Anniversary3ActBpModel.instance:isPremiumPayed(self._bpId, self._actId)
	local canGetPay = level >= self._config.level and hasPay

	if not canGetPay then
		return
	end

	if self._mo then
		local hasGetPay = self._mo.hasGetPayBonus

		if hasGetPay then
			return
		end

		Activity233Rpc.instance:sendGetAct233BpBonusRequest(self._actId, self._config.level, true)
	end
end

function Anniversary3ActBpBonusItem:refresh(co)
	self._config = co
	self._mo = Anniversary3ActBpModel.instance:getActBpBonusInfo(self._config.level, self._bpId, self._actId)

	if self._mo then
		local hasGetFree = self._mo.hasGetFreeBonus
		local level = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)
		local canGetFree = level >= self._config.level

		gohelper.setActive(self._gofreelock, not canGetFree)

		if self._canGetFree ~= nil and not self._canGetFree and canGetFree and not hasGetFree then
			gohelper.setActive(self._gofreeunlock, canGetFree)
		end

		self._canGetFree = canGetFree

		gohelper.setActive(self._gofreehasget, canGetFree and hasGetFree)
		gohelper.setActive(self._gofreecanget, canGetFree and not hasGetFree)
		gohelper.setActive(self._btngetfree, canGetFree and not hasGetFree)

		local freeBonusList = GameUtil.splitString2(self._config.freeBonus, true)

		self:_setBonus(freeBonusList, self._freeBonusList, self._gofreeitem, self._onbtngetfreeOnClick, canGetFree, hasGetFree)

		if self._mo then
			local hasGetPay = self._mo.hasGetPayBonus
			local hasPay = Anniversary3ActBpModel.instance:isPremiumPayed(self._bpId, self._actId)
			local canGetPay = canGetFree and hasPay
			local payBonusList = GameUtil.splitString2(self._config.payBonus, true)

			gohelper.setActive(self._gopaylock, not canGetPay)

			if self._canGetPay ~= nil and not self._canGetPay and canGetPay and not hasGetPay then
				gohelper.setActive(self._gopayunlock, canGetPay)
			end

			self._canGetPay = canGetPay

			gohelper.setActive(self._gopayhasget, canGetPay and hasGetPay)
			gohelper.setActive(self._gopaycanget, canGetPay and not hasGetPay)
			gohelper.setActive(self._btngetpay, canGetPay and not hasGetPay)
			gohelper.setActive(self._gopaylock2, #payBonusList == 2)
			gohelper.setActive(self._gopayhasget2, #payBonusList == 2)
			gohelper.setActive(self._gopayunlock2, #payBonusList == 2)
			self:_setBonus(payBonusList, self._payBonusList, self._gopayitem, self._onbtngetpayOnClick, canGetPay, hasGetPay)

			self._txtlv.text = string.format(luaLang("rank_level_display1"), self._config.level)

			local isKeyBonus = self._config.keyBonus >= 1

			SLFramework.UGUI.GuiHelper.SetColor(self._txtlv, isKeyBonus and "#FD7536" or "#DFBC7A")
		end
	end
end

function Anniversary3ActBpBonusItem:_setBonus(itemList, itemIconList, itemPrefab, clickCb, canGet, hasGet)
	for i, one in ipairs(itemList) do
		local itemIcon = itemIconList[i]

		if not itemIcon then
			local itemParentGO = gohelper.cloneInPlace(itemPrefab)

			gohelper.setActive(itemParentGO, true)

			itemIcon = IconMgr.instance:getCommonPropItemIcon(itemParentGO)

			table.insert(itemIconList, itemIcon)
		end

		itemIcon:setMOValue(one[1], one[2], one[3], nil, true)

		if one[1] == MaterialEnum.MaterialType.Equip then
			itemIcon._equipIcon._overrideLoadIconFunc(itemIcon._equipIcon, EquipHelper.getEquipDefaultIconLoadPath, itemIcon._equipIcon)
			itemIcon._equipIcon:_loadIconImage()
		end

		if canGet and not hasGet then
			itemIcon:customOnClickCallback(clickCb, self)
		else
			itemIcon:customOnClickCallback(nil, nil)
		end

		itemIcon:setCountFontSize(46)
		itemIcon:setScale(0.6)
		itemIcon:SetCountLocalY(43.6)
		itemIcon:SetCountBgHeight(40)
		itemIcon:SetCountBgScale(1, 1.3, 1)
		itemIcon:showStackableNum()
		itemIcon:setHideLvAndBreakFlag(true)
		itemIcon:hideEquipLvAndBreak(true)
		itemIcon:isShowCount(one[1] ~= MaterialEnum.MaterialType.HeroSkin)

		if hasGet then
			itemIcon:setAlpha(0.45, 0.8)
		else
			itemIcon:setAlpha(1, 1)
		end

		gohelper.setActive(itemIcon.go.transform.parent.gameObject, true)

		local goHasGet = gohelper.findChild(itemIcon.go.transform.parent.gameObject, "#goHasGet")

		gohelper.setActive(goHasGet, canGet and hasGet)
	end

	for i = #itemList + 1, #itemIconList do
		local itemIcon = itemIconList[i]

		gohelper.setActive(itemIcon.go.transform.parent.gameObject, false)
	end
end

function Anniversary3ActBpBonusItem:destroy()
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

return Anniversary3ActBpBonusItem
