-- chunkname: @modules/logic/battlepass/view/BpSPBonusItem.lua

module("modules.logic.battlepass.view.BpSPBonusItem", package.seeall)

local BpSPBonusItem = class("BpSPBonusItem", ListScrollCell)

function BpSPBonusItem:init(go)
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
	self._payHasGet1 = gohelper.findChild(self.go, "payStatus/#goHasGet/get1")
	self._payHasGet2 = gohelper.findChild(self.go, "payStatus/#goHasGet/get2")
	self._getcanvasGroup1 = gohelper.onceAddComponent(self._payHasGet1, typeof(UnityEngine.CanvasGroup))
	self._getcanvasGroup2 = gohelper.onceAddComponent(self._payHasGet2, typeof(UnityEngine.CanvasGroup))
	self._goCanGetLv = gohelper.findChild(self.go, "#go_canGetLv")
	self._animGo1 = gohelper.findChild(self.go, "free/freenode/#goCanGet/bg/#vx_effect")
	self._animGo2 = gohelper.findChild(self.go, "pay/paynode/#goCanGet/image/#vx_effect")
	self._btnGetFree = gohelper.findChildButtonWithAudio(self.go, "#btn_getfree")
	self._btnGetPay = gohelper.findChildButtonWithAudio(self.go, "#btn_getpay")
	self._freeBonusList = {}
	self._payBonusList = {}
	self._selectBonusList = {}
	self._payGetEffect = self:getUserDataTb_()
	self._selectBonusEffect = self:getUserDataTb_()

	self:showAnim()
end

function BpSPBonusItem:addEventListeners()
	self._btnGetFree:AddClickListener(self._onFreeItemIconClick, self)
	self._btnGetPay:AddClickListener(self._onPayItemIconClick, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnViewOpenFinish, self.showAnim, self)
	self.addEventCb(self, BpController.instance, BpEvent.onSelectBonusGet, self._refreshSelect, self)
end

function BpSPBonusItem:removeEventListeners()
	self._btnGetFree:RemoveClickListener()
	self._btnGetPay:RemoveClickListener()
	self.removeEventCb(self, BpController.instance, BpEvent.OnViewOpenFinish, self.showAnim, self)
	self.removeEventCb(self, BpController.instance, BpEvent.onSelectBonusGet, self._refreshSelect, self)
end

function BpSPBonusItem:onUpdateMO(mo)
	if not self.mo or mo.id ~= self.mo.id then
		self:checkPlayAnim()
	elseif mo.hasGetSpfreeBonus or mo.hasGetSpPayBonus then
		if mo.hasGetSpfreeBonus then
			self.freeAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(self.freeUnLockGo, false)
		end

		if mo.hasGetSpPayBonus then
			self.payAnim:Play(UIAnimationName.Idle)
			gohelper.setActive(self.payUnLockGo, false)
		end
	end

	self.mo = mo
	self._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("bp_sp_level"), self.mo.level)

	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local canGetFree = level >= self.mo.level
	local canGetPay = level >= self.mo.level
	local hasGetFree = self.mo.hasGetSpfreeBonus
	local hasGetPay = self.mo.hasGetSpPayBonus
	local hasGetSelect = BpBonusModel.instance:isGetSelectBonus(self.mo.level)
	local levelCO = BpConfig.instance:getBonusCO(BpModel.instance.id, self.mo.level)
	local freeBonusSp = GameUtil.splitString2(levelCO.spFreeBonus, true)
	local payBonusSp = GameUtil.splitString2(levelCO.spPayBonus, true)
	local selectBonus = GameUtil.splitString2(levelCO.selfSelectPayItem, true) or {}

	self:_setBonus(freeBonusSp, self._freeBonusList, self._freeItemGO, self._onFreeItemIconClick, canGetFree, hasGetFree)
	self:_setBonus(payBonusSp, self._payBonusList, self._payItemGO, self._onPayItemIconClick, canGetPay, hasGetPay)
	self:_setBonus(selectBonus, self._selectBonusList, self._payItemGO, self._onselectItemIconClick, canGetPay, hasGetSelect, true)
	gohelper.setActive(self._freeLockMask, false)
	gohelper.setActive(self._freeHasGet, canGetFree and hasGetFree)
	gohelper.setActive(self._payLockMask, false)
	gohelper.setActive(self._payHasGet, canGetPay and hasGetPay or hasGetSelect)
	gohelper.setActive(self._payHasGet2, #payBonusSp + #selectBonus == 2)
	gohelper.setActive(self.freelock, not canGetFree)
	gohelper.setActive(self.paylock, not canGetPay)
	gohelper.setActive(self.paylock2, not canGetPay and #payBonusSp + #selectBonus == 2)
	gohelper.setActive(self.payUnLockGo2, #payBonusSp + #selectBonus == 2)
	gohelper.setActive(self._freeCanGet, canGetFree and not hasGetFree)
	gohelper.setActive(self._payCanGet, canGetPay and (not hasGetPay or not hasGetSelect and not string.nilorempty(levelCO.selfSelectPayItem)))
	gohelper.setActive(self._btnGetFree, canGetFree and not hasGetFree)
	gohelper.setActive(self._btnGetPay, canGetPay and not hasGetPay)

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

	for i = 1, #self._payBonusList do
		self._payGetEffect[i] = self._payGetEffect[i] or gohelper.findChild(self._payBonusList[i].go.transform.parent.gameObject, "#vx_get_down")
	end

	for i = 1, #self._selectBonusList do
		self._selectBonusEffect[i] = self._selectBonusEffect[i] or gohelper.findChild(self._selectBonusList[i].go.transform.parent.gameObject, "#vx_get_down")
	end

	for i = 1, #self._payGetEffect do
		gohelper.setActive(self._payGetEffect[i], canGetPay and not hasGetPay)
	end

	for i = 1, #self._selectBonusEffect do
		gohelper.setActive(self._selectBonusEffect[i], hasGetSelect)
	end

	local canGetLvBonus = canGetFree and not hasGetFree or canGetPay and not hasGetPay

	gohelper.setActive(self._goCanGetLv, canGetLvBonus)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtLevel, canGetLvBonus and "#FD7536" or "#DFBC7A")
end

function BpSPBonusItem:showAnim()
	if BpModel.instance.isViewLoading then
		return
	end

	gohelper.setActive(self._animGo1, true)
	gohelper.setActive(self._animGo2, true)
end

function BpSPBonusItem:_setBonus(itemSp, itemIconList, itemPrefab, clickCb, canGet, hasGet, isCustomCall)
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

		if canGet and not hasGet or isCustomCall then
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

function BpSPBonusItem:_refreshSelect(level)
	if level ~= self.mo.level then
		return
	end

	self:onUpdateMO(self.mo)
end

function BpSPBonusItem:checkPlayAnim()
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

function BpSPBonusItem:playUnLockAnim(freeAnim, payAnim)
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

function BpSPBonusItem:playAnim(animCom, animName, callback, caller)
	animCom:Stop()

	if not animCom.isActiveAndEnabled then
		callback(caller)

		return
	end

	animCom:Play(animName, callback, caller)
end

function BpSPBonusItem:endFreeAnim()
	self.freeAnim:Play(UIAnimationName.Idle)
end

function BpSPBonusItem:endPayAnim()
	self.payAnim:Play(UIAnimationName.Idle)
end

function BpSPBonusItem:endFreeUnLockAnim()
	gohelper.setActive(self.freeUnLockGo, false)
end

function BpSPBonusItem:endPayUnLockAnim()
	gohelper.setActive(self.payUnLockGo, false)
end

function BpSPBonusItem:endUnLockAnim()
	self.freeAnim:Play(UIAnimationName.Idle)
	self.payAnim:Play(UIAnimationName.Idle)
	gohelper.setActive(self.freeUnLockGo, false)
	gohelper.setActive(self.payUnLockGo, false)
end

function BpSPBonusItem:_onFreeItemIconClick()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local canGetFree = level >= self.mo.level
	local hasGetFree = self.mo.hasGetSpfreeBonus

	if canGetFree and not hasGetFree then
		BpRpc.instance:sendGetBpBonusRequest(self.mo.level, false, true)
	end
end

function BpSPBonusItem:_onPayItemIconClick()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local canGetPay = level >= self.mo.level
	local hasGetPay = self.mo.hasGetSpPayBonus

	if canGetPay and not hasGetPay then
		BpRpc.instance:sendGetBpBonusRequest(self.mo.level, true, true, self._onGetBonus, self)
	end
end

function BpSPBonusItem:_onGetBonus(cmd, resultCode, msg)
	if resultCode == 0 then
		local levelCO = BpConfig.instance:getBonusCO(BpModel.instance.id, self.mo.level)
		local hasGetSelect = BpBonusModel.instance:isGetSelectBonus(self.mo.level)

		if not string.nilorempty(levelCO.selfSelectPayItem) and not hasGetSelect then
			self:_onselectItemIconClick()
		end
	end
end

function BpSPBonusItem:_onselectItemIconClick()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function BpSPBonusItem:onDestroyView()
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

	if self._selectBonusList then
		for _, itemIcon in pairs(self._selectBonusList) do
			itemIcon:onDestroy()
		end

		self._selectBonusList = nil
	end
end

return BpSPBonusItem
