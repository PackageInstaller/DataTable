-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BpBonusItem.lua

module("modules.logic.turnback.view.turnback3.Turnback3BpBonusItem", package.seeall)

local Turnback3BpBonusItem = class("Turnback3BpBonusItem", ListScrollCell)

function Turnback3BpBonusItem:init(go)
	self.go = go
	self._freeItemGO = gohelper.findChild(self.go, "free/freenode/#goItem")
	self._freeCanGet = gohelper.findChild(self.go, "free/freenode/#goCanGet")
	self._payItemGO = gohelper.findChild(self.go, "pay/paynode/#goItem")
	self._payCanGet = gohelper.findChild(self.go, "pay/paynode/#goCanGet")
	self._freeHasGet = gohelper.findChild(self.go, "free/freenode/#goHasGet")
	self._payHasGet = gohelper.findChild(self.go, "pay/paynode/#goHasGet")
	self._gofreecanget = gohelper.findChild(self.go, "free/freenode/canget")
	self._gopaycanget = gohelper.findChild(self.go, "pay/paynode/canget")
	self.freelock = gohelper.findChild(self.go, "free/freenode/freelock")
	self.paylock = gohelper.findChild(self.go, "pay/paynode/paylock")
	self.freeAnim = gohelper.findChildComponent(self.go, "free", typeof(UnityEngine.Animator))
	self.payAnim = gohelper.findChildComponent(self.go, "pay", typeof(UnityEngine.Animator))
	self.freeUnLockGo = gohelper.findChild(self.go, "free/freenode/unlock")
	self.payUnLockGo = gohelper.findChild(self.go, "pay/paynode/unlock")
	self._payHasGet2 = gohelper.findChild(self.go, "payStatus/#goHasGet/get2")
	self._btnGetFree = gohelper.findChildButtonWithAudio(self.go, "#btn_getfree")
	self._btnGetPay = gohelper.findChildButtonWithAudio(self.go, "#btn_getpay")
end

function Turnback3BpBonusItem:addEventListeners()
	self._btnGetFree:AddClickListener(self._onClickReward, self)
	self._btnGetPay:AddClickListener(self._onClickReward, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshTaskRewardItem, self._onReplyBack, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshItem, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.succbuydoublereward, self)
end

function Turnback3BpBonusItem:removeEventListeners()
	self._btnGetFree:RemoveClickListener()
	self._btnGetPay:RemoveClickListener()
end

function Turnback3BpBonusItem:_onClickReward()
	TurnbackRpc.instance:sendAcceptAllTurnbackBonusPointRequest(TurnbackModel.instance:getCurTurnbackId())
end

function Turnback3BpBonusItem:_initItem(config, isLast)
	self.config = config
	self.index = config.id
	self._isLast = isLast

	local freeBonus = not string.nilorempty(config.bonus) and string.splitToNumber(config.bonus, "#")
	local extraBonus = not string.nilorempty(config.extraBonus) and string.splitToNumber(config.extraBonus, "#")

	self._freeItem = self._freeItem or IconMgr.instance:getCommonPropItemIcon(self._freeItemGO)
	self._payItem = self._payItem or IconMgr.instance:getCommonPropItemIcon(self._payItemGO)

	self:_initItemInfo(self._freeItem, freeBonus)
	self:_initItemInfo(self._payItem, extraBonus)

	if self._isLast then
		self._txtLevel = gohelper.findChildText(self.go, "Levelbg/#txtLevel")
		self._txtLevel.text = self.config.needPoint
	end

	self.addEventCb(self, self.parentView.viewContainer, TurnbackEvent.TapViewOpenAnimBegin, self.checkPlayAnim, self)
	self:refreshItem()
end

function Turnback3BpBonusItem:_initItemInfo(item, bonusCo)
	item:setMOValue(bonusCo[1], bonusCo[2], bonusCo[3], nil, true)
	item:setCountFontSize(46)

	if bonusCo[1] == MaterialEnum.MaterialType.Equip then
		item._equipIcon._overrideLoadIconFunc(item._equipIcon, EquipHelper.getEquipDefaultIconLoadPath, item._equipIcon)
		item._equipIcon:_loadIconImage()
	end
end

function Turnback3BpBonusItem:refreshItem()
	self.hasGetState = false

	local curActiveCount = TurnbackModel.instance:getCurrentPointId(self._turnbackId)
	local canGet = curActiveCount >= self.config.needPoint
	local hasDouble = TurnbackModel.instance:getBuyDoubleBonus()
	local HasGetTaskBonus = TurnbackModel.instance:getCurHasGetTaskBonus()

	for _, v in ipairs(HasGetTaskBonus) do
		if v == self.index then
			self.hasGetState = true

			break
		end
	end

	local hasGetfreeBonus = self.hasGetState

	if self.hasGetState then
		local hasGetPayBonus = hasDouble

		if hasGetfreeBonus or hasGetPayBonus then
			if hasGetfreeBonus then
				self.freeAnim:Play(UIAnimationName.Idle)
				gohelper.setActive(self.freeUnLockGo, false)
			end

			if hasGetPayBonus then
				self.payAnim:Play(UIAnimationName.Idle)
				gohelper.setActive(self.payUnLockGo, false)
			end
		end

		gohelper.setActive(self.freelock, not canGet)
		gohelper.setActive(self.paylock, not canGet or not hasDouble)
		gohelper.setActive(self._freeCanGet, canGet and not self.hasGetState)
		gohelper.setActive(self._gofreecanget, canGet and not self.hasGetState)
		gohelper.setActive(self._btnGetFree.gameObject, canGet and not self.hasGetState)
		gohelper.setActive(self._payCanGet, canGet and not self.hasGetState and hasDouble)
		gohelper.setActive(self._gopaycanget, canGet and not self.hasGetState and hasDouble)
		gohelper.setActive(self._btnGetPay.gameObject, canGet and not self.hasGetState and hasDouble)
		gohelper.setActive(self._freeHasGet, hasGetfreeBonus)
		gohelper.setActive(self._payHasGet, hasGetPayBonus)
	end
end

function Turnback3BpBonusItem:_onReplyBack()
	self:refreshItem()
end

function Turnback3BpBonusItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView and not self.hasGetState then
		self:refreshItem()
	end
end

function Turnback3BpBonusItem:onUpdateMO(mo)
	self.mo = mo
end

function Turnback3BpBonusItem:checkPlayAnim()
	local curActiveCount = TurnbackModel.instance:getCurrentPointId(self._turnbackId)
	local canGet = curActiveCount >= self.config.needPoint and not self.hasGetState
	local hasDouble = TurnbackModel.instance:getBuyDoubleBonus()

	if canGet then
		self:playUnLockAnim(true, hasDouble)
	end
end

function Turnback3BpBonusItem:playUnLockAnim(freeAnim, payAnim)
	if freeAnim then
		local freePlayer = SLFramework.AnimatorPlayer.Get(self.freeAnim.gameObject)

		self.playAnim(self, freePlayer, UIAnimationName.Unlock, self.endFreeAnim, self)
		gohelper.setActive(self.freeUnLockGo, true)
		gohelper.setActive(self._gofreecanget, true)
	end

	if payAnim then
		local payPlayer = SLFramework.AnimatorPlayer.Get(self.payAnim.gameObject)

		self.playAnim(self, payPlayer, UIAnimationName.Unlock, self.endPayAnim, self)
		gohelper.setActive(self.payUnLockGo, true)
		gohelper.setActive(self._gopaycanget, true)
	end
end

function Turnback3BpBonusItem:playAnim(animCom, animName, callback, caller)
	animCom:Stop()

	if not animCom.isActiveAndEnabled then
		callback(caller)

		return
	end

	animCom:Play(animName, callback, caller)
end

function Turnback3BpBonusItem:endFreeAnim()
	self.freeAnim:Play(UIAnimationName.Idle)
end

function Turnback3BpBonusItem:endPayAnim()
	self.payAnim:Play(UIAnimationName.Idle)
end

function Turnback3BpBonusItem:endFreeUnLockAnim()
	gohelper.setActive(self.freeUnLockGo, false)
end

function Turnback3BpBonusItem:endPayUnLockAnim()
	gohelper.setActive(self.payUnLockGo, false)
end

function Turnback3BpBonusItem:endUnLockAnim()
	self.freeAnim:Play(UIAnimationName.Idle)
	self.payAnim:Play(UIAnimationName.Idle)
	gohelper.setActive(self.freeUnLockGo, false)
	gohelper.setActive(self.payUnLockGo, false)
end

function Turnback3BpBonusItem:succbuydoublereward()
	gohelper.setActive(self._gofreecanget, false)
	gohelper.setActive(self._gopaycanget, false)
	self:refreshItem()
end

return Turnback3BpBonusItem
