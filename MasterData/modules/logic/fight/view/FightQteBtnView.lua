-- chunkname: @modules/logic/fight/view/FightQteBtnView.lua

module("modules.logic.fight.view.FightQteBtnView", package.seeall)

local FightQteBtnView = class("FightQteBtnView", FightBaseView)
local Status = {
	Full = 3,
	CanClick = 2,
	Grey = 1
}

function FightQteBtnView:onConstructor(teamType)
	self.teamType = teamType
end

function FightQteBtnView:onInitView()
	self.viewAnimator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.goGrey = gohelper.findChild(self.viewGO, "root/#go_bg/grey")
	self.goCanClick = gohelper.findChild(self.viewGO, "root/#go_bg/canclick")
	self.goFull = gohelper.findChild(self.viewGO, "root/#go_bg/full")
	self.btnClick = gohelper.findChildClick(self.viewGO, "root/#btn_click")

	self.btnClick:AddClickListener(self.onClickQte, self)

	self.goClickEffect = gohelper.findChild(self.viewGO, "root/#go_eff_click")
	self.longPressLister = SLFramework.UGUI.UILongPressListener.GetWithPath(self.viewGO, "root/#btn_click")

	self.longPressLister:SetLongPressTime({
		0.5,
		999999
	})
	self.longPressLister:AddLongPressListener(self.onLongPress, self)

	self.txtNum = gohelper.findChildText(self.viewGO, "root/#go_num/#txt_num")

	local goPoint = gohelper.findChild(self.viewGO, "root/#go_point")

	self.pointItem = gohelper.findChild(goPoint, "#go_pointitem")

	gohelper.setActive(self.pointItem, false)

	self.pointItemList = {}
	self.preStatus = Status.Grey
end

function FightQteBtnView:addEvents()
	self:com_registFightEvent(FightEvent.QTE_OnMaxChange, self.onMaxValueChange)
	self:com_registFightEvent(FightEvent.QTE_OnUpdate, self.onUpdate)
end

function FightQteBtnView:onMaxValueChange()
	self:refreshUI()
end

function FightQteBtnView:onUpdate()
	self:refreshUI()
end

function FightQteBtnView:onLongPress()
	if self:isLock() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightQteTipView)
end

FightQteBtnView.ClickWaitTime = 0.2

function FightQteBtnView:onClickQte()
	if self:isLock() then
		return
	end

	if not FightHelper.hasLiveEnemyEntity() then
		GameFacade.showToast(ToastEnum.Fight4_0NoQteEntity)

		return
	end

	if not FightHelper.hasQteEntity() then
		GameFacade.showToast(ToastEnum.Fight4_0NoQteEntity)

		return
	end

	local ops = FightDataHelper.operationDataMgr:getOpList()

	if #ops > 0 then
		GameFacade.showToast(ToastEnum.Fight4_0QTEUsedSkill)

		return
	end

	local qteInfo = self.qteDataMgr:getQteInfo(self.teamType)

	if not qteInfo then
		return
	end

	local curEnergy = qteInfo:getCurEnergy()

	if curEnergy < qteInfo:getThreshold() then
		GameFacade.showToast(ToastEnum.Fight4_0QTEEnergyNotEnough)

		return
	end

	AudioMgr.instance:trigger(400036)
	UIBlockMgr.instance:startBlock(UIBlockKey.Fight_WaitEnterQte)
	gohelper.setActive(self.goClickEffect, false)
	gohelper.setActive(self.goClickEffect, true)
	TaskDispatcher.cancelTask(self.realSendRequest, self)
	TaskDispatcher.runDelay(self.realSendRequest, self, FightQteBtnView.ClickWaitTime)
end

function FightQteBtnView:realSendRequest()
	UIBlockMgr.instance:endBlock(UIBlockKey.Fight_WaitEnterQte)
	FightRpc.instance:sendEnterQTERoundRequest()
end

function FightQteBtnView:isLock()
	if FightViewHandCard.blockOperate then
		return true
	end

	if FightDataHelper.lockOperateMgr:isLock() then
		return true
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return true
	end

	if FightGameMgr.operateMgr:isOperating() then
		return true
	end

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		return true
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.QTE) then
		return true
	end
end

function FightQteBtnView:onOpen()
	self.qteDataMgr = FightDataHelper.qteDataMgr

	self:refreshUI()
end

function FightQteBtnView:refreshUI()
	self.status = self:getCurStatus()

	local qteInfo = self.qteDataMgr:getQteInfo(self.teamType)

	if not qteInfo then
		self:hideQteView()

		return
	end

	self:showQteView()
	self:refreshBg()
	self:refreshEnergy()

	self.preStatus = self.status
end

function FightQteBtnView:refreshEnergy()
	local qteInfo = self.qteDataMgr:getQteInfo(self.teamType)
	local realMax = qteInfo:getRealMax()
	local curEnergy = qteInfo:getCurEnergy()
	local energyList = qteInfo:getEnergyList()

	for i = 1, realMax do
		local pointItem = self.pointItemList[i]

		if not pointItem then
			pointItem = self:getUserDataTb_()
			pointItem.go = gohelper.cloneInPlace(self.pointItem)
			pointItem.rectTr = pointItem.go:GetComponent(gohelper.Type_RectTransform)
			pointItem.goLight = gohelper.findChild(pointItem.go, "#image_point")
			pointItem.imageLight = pointItem.goLight:GetComponent(gohelper.Type_Image)
			pointItem.goEffectBlue = gohelper.findChild(pointItem.go, "uieff_point_blue")
			pointItem.goEffectYellow = gohelper.findChild(pointItem.go, "uieff_point_yellow")
			self.pointItemList[i] = pointItem
		end

		gohelper.setActive(pointItem.go, true)

		local anchorX, anchorY = self:getPointAnchor(i, realMax)

		recthelper.setAnchor(pointItem.rectTr, anchorX, anchorY)
		gohelper.setActive(pointItem.goLight, i <= curEnergy)

		local type = energyList[i]

		if type then
			local imageName = FightQteEntityItemHelper.getSmallCostTypeImage(type)

			UISpriteSetMgr.instance:setFightSprite(pointItem.imageLight, imageName)
			gohelper.setActive(pointItem.goEffectBlue, type == CharacterEnum.CareerType.Xing)
			gohelper.setActive(pointItem.goEffectYellow, type == CharacterEnum.CareerType.Yan)
		else
			gohelper.setActive(pointItem.goEffectBlue, false)
			gohelper.setActive(pointItem.goEffectYellow, false)
		end
	end

	for i = realMax + 1, #self.pointItemList do
		local pointItem = self.pointItemList[i]

		if pointItem then
			gohelper.setActive(pointItem.go, false)
		end
	end

	self.txtNum.text = curEnergy
end

local StatusAnim = {
	[Status.Grey] = "open_grey",
	[Status.CanClick] = "open_canclick",
	[Status.Full] = "open_full"
}
local StatusChangeAnim = {
	[Status.Grey] = {
		[Status.CanClick] = "grey_switch_canclick",
		[Status.Full] = "grey_switch_full"
	},
	[Status.CanClick] = {
		[Status.Grey] = "canclick_switch_grey",
		[Status.Full] = "canclick_switch_full"
	},
	[Status.Full] = {
		[Status.Grey] = "full_switch_grey",
		[Status.CanClick] = "full_switch_canclick"
	}
}

function FightQteBtnView:refreshBg()
	if self.status == self.preStatus then
		local animName = StatusAnim[self.status]

		self.viewAnimator:Play(animName, 0, 1)
	else
		local animName = StatusChangeAnim[self.preStatus][self.status]

		self.viewAnimator:Play(animName, 0, 0)
	end
end

function FightQteBtnView:getCurStatus()
	local qteInfo = self.qteDataMgr:getQteInfo(self.teamType)

	if not qteInfo then
		return Status.Grey
	end

	local curEnergy = qteInfo:getCurEnergy()
	local max = qteInfo:getMaxEnergy()

	if max <= curEnergy then
		return Status.Full
	end

	local threshold = qteInfo:getThreshold()

	if threshold <= curEnergy then
		return Status.CanClick
	end

	return Status.Grey
end

local Radius = 56

function FightQteBtnView:getPointAnchor(index, segmentCount)
	local interval = 2 * math.pi / segmentCount
	local angle = (index - 1) * interval
	local x = Radius * math.cos(angle)
	local y = Radius * math.sin(angle)

	return x, y
end

function FightQteBtnView:showQteView()
	FightController.instance:dispatchEvent(FightEvent.RightBottomElements_ShowElement, FightRightBottomElementEnum.Elements.Qte)
end

function FightQteBtnView:hideQteView()
	FightController.instance:dispatchEvent(FightEvent.RightBottomElements_HideElement, FightRightBottomElementEnum.Elements.Qte)
end

function FightQteBtnView:onDestroyView()
	UIBlockMgr.instance:endBlock(UIBlockKey.Fight_WaitEnterQte)
	TaskDispatcher.cancelTask(self.realSendRequest, self)

	if self.btnClick then
		self.btnClick:RemoveClickListener()

		self.btnClick = nil
	end

	if self.longPressLister then
		self.longPressLister:RemoveLongPressListener()

		self.longPressLister = nil
	end
end

return FightQteBtnView
