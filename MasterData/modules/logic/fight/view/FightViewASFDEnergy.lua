-- chunkname: @modules/logic/fight/view/FightViewASFDEnergy.lua

module("modules.logic.fight.view.FightViewASFDEnergy", package.seeall)

local FightViewASFDEnergy = class("FightViewASFDEnergy", BaseView)

function FightViewASFDEnergy:onInitView()
	self.goASFD = gohelper.findChild(self.viewGO, "root/asfd_container")
	self.txtASFDEnergy = gohelper.findChildText(self.viewGO, "root/asfd_container/asfd_icon/#txt_Num")
	self.goClick = gohelper.findChild(self.viewGO, "root/asfd_container/asfd_icon/#click")
	self.flyContainerWrap = gohelper.findChild(self.viewGO, "asfd_fly_container")
	self.goFlyContainer = gohelper.findChild(self.viewGO, "root/asfd_container/asfd_icon/#go_fly_container")
	self.goFlyItem = gohelper.findChild(self.viewGO, "root/asfd_container/asfd_icon/#go_fly_container/#go_fly_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewASFDEnergy:addEvents()
	return
end

function FightViewASFDEnergy:removeEvents()
	return
end

function FightViewASFDEnergy:_editableInitView()
	local goContainer = self.viewContainer.rightBottomElementLayoutView:getElementContainer(FightRightBottomElementEnum.Elements.ASFD)

	gohelper.addChild(goContainer, self.goASFD)
	gohelper.addChild(self.flyContainerWrap, self.goFlyContainer)

	local rectTr = self.goASFD:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(rectTr, 0, 0)

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.goASFD)

	self:_hideASFD()

	self.flyItemList = {}

	table.insert(self.flyItemList, self:createFlyItem(self.goFlyItem))
	gohelper.setActive(self.goFlyItem, false)
	gohelper.setActive(self.goClick, false)
	gohelper.setActive(self.goFlyContainer, false)

	self.rectFlyContainer = self.goFlyContainer:GetComponent(gohelper.Type_RectTransform)

	self.addEventCb(self, FightController.instance, FightEvent.ASFD_TeamEnergyChange, self.onTeamEnergyChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.stageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.ASFD_StartAllocateCardEnergy, self.startAllocateCardEnergy, self)

	self.handCardView = self.viewContainer.fightViewHandCard
	self.tweenIdList = {}
end

FightViewASFDEnergy.FlyDuration = 0.3

function FightViewASFDEnergy:startAllocateCardEnergy()
	local cardList = FightDataHelper.handCardMgr.handCard

	tabletool.clear(self.tweenIdList)

	self.flyCount = 0
	self.arrivedCount = 0
	self.tempVector2 = self.tempVector2 or Vector2()

	gohelper.setActive(self.goFlyContainer, true)

	for index, cardMo in ipairs(cardList) do
		if cardMo.energy and cardMo.energy > 0 then
			local handCardItem = self.handCardView:getHandCardItem(index)

			if handCardItem then
				self.flyCount = self.flyCount + 1

				local screenPosX, screenPosY = handCardItem:getASFDScreenPos()

				self.tempVector2:Set(screenPosX, screenPosY)

				local targetAnchorX, targetAnchorY = recthelper.screenPosToAnchorPos2(self.tempVector2, self.rectFlyContainer)
				local flyItem = self:getFlyItem(self.flyCount)

				recthelper.setAnchor(flyItem.rectTr, 0, 0)

				local tweenId = ZProj.TweenHelper.DOAnchorPos(flyItem.rectTr, targetAnchorX, targetAnchorY, FightViewASFDEnergy.FlyDuration / FightModel.instance:getUISpeed(), self.onFlyDone, self)

				table.insert(self.tweenIdList, tweenId)
			end
		end
	end

	self.animatorPlayer:Play("close", self._hideASFD, self)

	if self.flyCount < 1 then
		FightController.instance:dispatchEvent(FightEvent.ASFD_AllocateCardEnergyDone)
	end
end

function FightViewASFDEnergy:onFlyDone()
	self.arrivedCount = self.arrivedCount + 1

	if self.arrivedCount < self.flyCount then
		return
	end

	AudioMgr.instance:trigger(20248002)
	tabletool.clear(self.tweenIdList)

	for _, flyItem in ipairs(self.flyItemList) do
		self:resetFlyItem(flyItem)
	end

	gohelper.setActive(self.goFlyContainer, false)
	FightController.instance:dispatchEvent(FightEvent.ASFD_AllocateCardEnergyDone)
end

function FightViewASFDEnergy:onTeamEnergyChange(side, beforeEnergy, curEnergy)
	if side ~= FightEnum.EntitySide.MySide then
		return
	end

	if curEnergy <= 0 then
		return self:showASFD()
	end

	AudioMgr.instance:trigger(20248001)

	if self.goASFD.activeInHierarchy then
		self:playClickAnim()
	else
		self:showASFD()
	end

	self.txtASFDEnergy.text = curEnergy
end

function FightViewASFDEnergy:playClickAnim()
	gohelper.setActive(self.goClick, false)
	gohelper.setActive(self.goClick, true)
end

function FightViewASFDEnergy:hideASFD()
	if self.goASFD.activeInHierarchy then
		gohelper.setActive(self.goASFD, false)
		self.animatorPlayer:Play("close", self._hideASFD, self)
	end
end

function FightViewASFDEnergy:_hideASFD()
	gohelper.setActive(self.goASFD, false)
	FightController.instance:dispatchEvent(FightEvent.RightBottomElements_HideElement, FightRightBottomElementEnum.Elements.ASFD)
end

function FightViewASFDEnergy:showASFD()
	gohelper.setActive(self.goASFD, true)
	FightController.instance:dispatchEvent(FightEvent.RightBottomElements_ShowElement, FightRightBottomElementEnum.Elements.ASFD)
end

function FightViewASFDEnergy:stageChange()
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Enter and curStage ~= FightStageMgr.StageType.Play then
		self:hideASFD()
	end
end

function FightViewASFDEnergy:createFlyItem(go)
	local item = self:getUserDataTb_()

	item.go = go
	item.rectTr = go:GetComponent(gohelper.Type_RectTransform)

	return item
end

function FightViewASFDEnergy:getFlyItem(index)
	local flyItem = self.flyItemList[index]

	if flyItem then
		gohelper.setActive(flyItem.go, true)

		return flyItem
	end

	local flyGo = gohelper.cloneInPlace(self.goFlyItem)

	flyItem = self:createFlyItem(flyGo)

	gohelper.setActive(flyItem.go, true)
	table.insert(self.flyItemList, flyItem)

	return flyItem
end

function FightViewASFDEnergy:resetFlyItem(flyItem)
	recthelper.setAnchor(flyItem.rectTr, 0, 0)
	gohelper.setActive(flyItem.go, false)
end

function FightViewASFDEnergy:onUpdateParam()
	self:hideASFD()
end

function FightViewASFDEnergy:onDestroyView()
	for _, tweenId in ipairs(self.tweenIdList) do
		ZProj.TweenHelper.KillById(tweenId)
	end

	tabletool.clear(self.tweenIdList)
end

return FightViewASFDEnergy
