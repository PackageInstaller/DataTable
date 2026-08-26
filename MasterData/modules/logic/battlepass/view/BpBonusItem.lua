-- chunkname: @modules/logic/battlepass/view/BpBonusItem.lua

module("modules.logic.battlepass.view.BpBonusItem", package.seeall)

local BpBonusItem = class("BpBonusItem", ListScrollCell)

function BpBonusItem:init(go)
	self.go = go
	self._txtLevel = gohelper.findChildText(self.go, "#txtLevel")
	self._freeItemGO = gohelper.findChild(self.go, "free/freenode/#goItem")
	self._freeCanGet = gohelper.findChild(self.go, "free/freenode/#goCanGet")
	self._payItemGO = gohelper.findChild(self.go, "pay/paynode/Item/#goItem")
	self._payCanGet = gohelper.findChild(self.go, "pay/paynode/#goCanGet")

	gohelper.setActive(self._freeItemGO, false)
	gohelper.setActive(self._payItemGO, false)

	self._freeLockMask = gohelper.findChild(self.go, "freeStatus/#goLockMask")
	self._freeHasGet = gohelper.findChild(self.go, "freeStatus/#goHasGet")
	self._payLockMask = gohelper.findChild(self.go, "payStatus/#goLockMask")
	self._payHasGet = gohelper.findChild(self.go, "payStatus/#goHasGet")
	self.freelock = gohelper.findChild(self.go, "freelock/lock")
	self.paylock = gohelper.findChild(self.go, "paylock/lock")
	self.paylock2 = gohelper.findChild(self.go, "paylock/lock2")
	self.freeAnim = gohelper.findChildComponent(self.go, "free", typeof(UnityEngine.Animator))
	self.freeUnLockGo = gohelper.findChild(self.go, "freeunlock")
	self.payAnim = gohelper.findChildComponent(self.go, "pay", typeof(UnityEngine.Animator))
	self.payUnLockGo = gohelper.findChild(self.go, "payunlock")
	self.payUnLockGo1 = gohelper.findChild(self.go, "payunlock/unlock1")
	self.payUnLockGo2 = gohelper.findChild(self.go, "payunlock/unlock2")
	self._payHasGet2 = gohelper.findChild(self.go, "payStatus/#goHasGet/get2")
	self._goCanGetLv = gohelper.findChild(self.go, "#go_canGetLv")
	self._animGo1 = gohelper.findChild(self.go, "free/freenode/#goCanGet/bg/#vx_effect")
	self._animGo2 = gohelper.findChild(self.go, "pay/paynode/#goCanGet/image/#vx_effect")
	self._btnGetFree = gohelper.findChildButtonWithAudio(self.go, "#btn_getfree")
	self._btnGetPay = gohelper.findChildButtonWithAudio(self.go, "#btn_getpay")
	self._freeBonusList = {}
	self._payBonusList = {}
	self._payGetEffect = self:getUserDataTb_()

	self:showAnim()
end

function BpBonusItem:addEventListeners()
	self._btnGetFree:AddClickListener(self._onFreeItemIconClick, self)
	self._btnGetPay:AddClickListener(self._onPayItemIconClick, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnViewOpenFinish, self.showAnim, self)
end

function BpBonusItem:removeEventListeners()
	self._btnGetFree:RemoveClickListener()
	self._btnGetPay:RemoveClickListener()
	self.removeEventCb(self, BpController.instance, BpEvent.OnViewOpenFinish, self.showAnim, self)
end

function BpBonusItem:onUpdateMO(mo)
	if not self.mo or mo.id ~= self.mo.id then
		self:checkPlayAnim()
	elseif mo.hasGetfreeBonus or mo.hasGetPayBonus then
		if mo.hasGetfreeBonus then
			self.freeAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(self.freeUnLockGo, false)
		end

		if mo.hasGetPayBonus then
			self.payAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(self.payUnLockGo, false)
		end
	end

	self.mo = mo
	self._txtLevel.text = self.mo.level .. luaLang("level")

	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local canGetFree = level >= self.mo.level
	local canGetPay = level >= self.mo.level and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay
	local hasGetFree = self.mo.hasGetfreeBonus
	local hasGetPay = self.mo.hasGetPayBonus
	local levelCO = BpConfig.instance:getBonusCO(BpModel.instance.id, self.mo.level)
	local freeBonusSp = GameUtil.splitString2(levelCO.freeBonus, true)
	local payBonusSp = GameUtil.splitString2(levelCO.payBonus, true)

	self:_setBonus(freeBonusSp, self._freeBonusList, self._freeItemGO, self._onFreeItemIconClick, canGetFree, hasGetFree)
	self:_setBonus(payBonusSp, self._payBonusList, self._payItemGO, self._onPayItemIconClick, canGetPay, hasGetPay)
	gohelper.setActive(self._freeLockMask, false)
	gohelper.setActive(self._freeHasGet, canGetFree and hasGetFree)
	gohelper.setActive(self._payLockMask, false)
	gohelper.setActive(self._payHasGet, canGetPay and hasGetPay)
	gohelper.setActive(self.freelock, not canGetFree)
	gohelper.setActive(self.paylock, not canGetPay)
	gohelper.setActive(self.paylock2, not canGetPay and #payBonusSp == 2)
	gohelper.setActive(self._payHasGet2, #payBonusSp == 2)
	gohelper.setActive(self.payUnLockGo2, #payBonusSp == 2)
	gohelper.setActive(self._freeCanGet, canGetFree and not hasGetFree)
	gohelper.setActive(self._payCanGet, canGetPay and not hasGetPay)
	gohelper.setActive(self._btnGetFree, canGetFree and not hasGetFree)
	gohelper.setActive(self._btnGetPay, canGetPay and not hasGetPay)

	for i = 1, #self._payBonusList do
		self._payGetEffect[i] = self._payGetEffect[i] or gohelper.findChild(self._payBonusList[i].go.transform.parent.gameObject, "#vx_get_down")
	end

	for i = 1, #self._payGetEffect do
		gohelper.setActive(self._payGetEffect[i], canGetPay and not hasGetPay)
	end

	local canGetLvBonus = canGetFree and not hasGetFree or canGetPay and not hasGetPay

	gohelper.setActive(self._goCanGetLv, canGetLvBonus)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtLevel, canGetLvBonus and "#FD7536" or "#DFBC7A")
end

function BpBonusItem:showAnim()
	if BpModel.instance.isViewLoading then
		return
	end

	gohelper.setActive(self._animGo1, true)
	gohelper.setActive(self._animGo2, true)
end

function BpBonusItem:_setBonus(itemSp, itemIconList, itemPrefab, clickCb, canGet, hasGet)
	for i, one in ipairs(itemSp) do
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

		local itemSize, x, y = BpConfig.instance:getItemShowSize(one[1], one[2])

		itemIcon:setItemIconScale(itemSize)
		itemIcon:setItemOffset(x, y)
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

	for i = #itemSp + 1, #itemIconList do
		local itemIcon = itemIconList[i]

		gohelper.setActive(itemIcon.go.transform.parent.gameObject, false)
	end
end

function BpBonusItem:checkPlayAnim()
	if not BpModel.instance.animData then
		self:endUnLockAnim()
	else
		self:endUnLockAnim()

		local preLv = BpModel.instance.animData.fromLv
		local nowLv = BpModel.instance.animData.toLv
		local prePayLv = BpModel.instance.animData.fromPayLv
		local index = self._index

		self:playUnLockAnim(preLv < index and index <= nowLv, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay and prePayLv < index and index <= nowLv)
	end
end

function BpBonusItem:playUnLockAnim(freeAnim, payAnim)
	if freeAnim then
		local freePlayer = SLFramework.AnimatorPlayer.Get(self.freeAnim.gameObject)

		self.playAnim(self, freePlayer, UIAnimationName.Open, self.endFreeAnim, self)
		gohelper.setActive(self.freeUnLockGo, true)

		local freeUnLockPlayer = SLFramework.AnimatorPlayer.Get(self.freeUnLockGo)

		self.playAnim(self, freeUnLockPlayer, UIAnimationName.Open, self.endFreeUnLockAnim, self)
	end

	if payAnim then
		local payPlayer = SLFramework.AnimatorPlayer.Get(self.payAnim.gameObject)

		self.playAnim(self, payPlayer, UIAnimationName.Open, self.endPayAnim, self)
		gohelper.setActive(self.payUnLockGo, true)

		local payUnLockPlayer = SLFramework.AnimatorPlayer.Get(self.payUnLockGo)

		self.playAnim(self, payUnLockPlayer, UIAnimationName.Open, self.endPayUnLockAnim, self)
	end
end

function BpBonusItem:playAnim(animCom, animName, callback, caller)
	animCom:Stop()

	if not animCom.isActiveAndEnabled then
		callback(caller)

		return
	end

	animCom:Play(animName, callback, caller)
end

function BpBonusItem:endFreeAnim()
	self.freeAnim:Play(UIAnimationName.Idle)
end

function BpBonusItem:endPayAnim()
	self.payAnim:Play(UIAnimationName.Idle)
end

function BpBonusItem:endFreeUnLockAnim()
	gohelper.setActive(self.freeUnLockGo, false)
end

function BpBonusItem:endPayUnLockAnim()
	gohelper.setActive(self.payUnLockGo, false)
end

function BpBonusItem:endUnLockAnim()
	self.freeAnim:Play(UIAnimationName.Idle)
	self.payAnim:Play(UIAnimationName.Idle)
	gohelper.setActive(self.freeUnLockGo, false)
	gohelper.setActive(self.payUnLockGo, false)
end

function BpBonusItem:_onFreeItemIconClick()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local canGetFree = level >= self.mo.level
	local hasGetFree = self.mo.hasGetfreeBonus

	if canGetFree and not hasGetFree then
		BpRpc.instance:sendGetBpBonusRequest(self.mo.level, false)
	end
end

function BpBonusItem:_onPayItemIconClick()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local canGetPay = level >= self.mo.level and BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay
	local hasGetPay = self.mo.hasGetPayBonus

	if canGetPay and not hasGetPay then
		BpRpc.instance:sendGetBpBonusRequest(self.mo.level, true)
	end
end

function BpBonusItem:onDestroyView()
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

return BpBonusItem
