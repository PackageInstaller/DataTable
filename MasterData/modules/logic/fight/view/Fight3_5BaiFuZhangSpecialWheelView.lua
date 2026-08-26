-- chunkname: @modules/logic/fight/view/Fight3_5BaiFuZhangSpecialWheelView.lua

module("modules.logic.fight.view.Fight3_5BaiFuZhangSpecialWheelView", package.seeall)

local Fight3_5BaiFuZhangSpecialWheelView = class("Fight3_5BaiFuZhangSpecialWheelView", FightBaseView)

function Fight3_5BaiFuZhangSpecialWheelView:onInitView()
	self.cardItem = gohelper.findChild(self.viewGO, "wheel/card/go_carditem")
	self.wheelRoot = gohelper.findChild(self.viewGO, "wheel").transform
	self.pointer = gohelper.findChild(self.viewGO, "#zhizhen").transform
	self.rootAnimator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self.selectRoot = gohelper.findChild(self.viewGO, "Right/layout")
	self.selectItem = gohelper.findChild(self.viewGO, "Right/layout/go_item")
end

function Fight3_5BaiFuZhangSpecialWheelView:addEvents()
	return
end

function Fight3_5BaiFuZhangSpecialWheelView:removeEvents()
	return
end

function Fight3_5BaiFuZhangSpecialWheelView:initWheelData()
	self.wheelData = {
		0,
		0,
		0,
		0,
		0,
		0
	}
end

function Fight3_5BaiFuZhangSpecialWheelView:onWheelRotate(value)
	local rotate = value % 360

	transformhelper.setLocalRotation(self.wheelRoot, 0, 0, rotate)
end

function Fight3_5BaiFuZhangSpecialWheelView:onOpen()
	self.tweenComp = self:addComponent(FightTweenComponent)
	self.selectStage = 1

	gohelper.setActive(self.cardItem, true)

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkDelayTimer)

	self.wheelData = FightDataHelper.baiFuZhangWheelDataMgr.wheelData
	self.index = FightDataHelper.baiFuZhangWheelDataMgr.index

	if not self.wheelData then
		self.isInit = true

		self:initWheelData()

		self.index = 1
		FightDataHelper.baiFuZhangWheelDataMgr.wheelData = self.wheelData
		FightDataHelper.baiFuZhangWheelDataMgr.index = 1
	end

	self:showWheelList()
	flow:registWork(FightWorkDelayTimer, 1.2)

	if self.isInit then
		AudioMgr.instance:trigger(350035)

		self.wheelRotate = 300

		transformhelper.setLocalRotation(self.wheelRoot, 0, 0, self.wheelRotate)
		flow:registWork(FightWorkFunction, self.showTitle, self)

		local parallelFlow = flow:registWork(FightWorkFlowParallel)
		local audioFlow = parallelFlow:registWork(FightWorkFlowSequence)

		audioFlow:registWork(FightWorkDelayTimer, 0.5)
		parallelFlow:registWork(FightWorkDelayTimer, 2)

		local ease = EaseType.OutCubic
		local time = 2

		flow:registWork(FightTweenWork, {
			type = "DOTweenFloat",
			to = 0,
			from = self.wheelRotate,
			t = time,
			frameCb = self.onWheelRotate,
			cbObj = self,
			ease = ease
		})
		flow:registWork(FightWorkDelayTimer, 0.16)
		transformhelper.setLocalRotation(self.pointer, 0, 0, 0)
	else
		AudioMgr.instance:trigger(350034)
		transformhelper.setLocalRotation(self.pointer, 0, 0, -self.index * 60 + 60)

		self.index = self.index % 6 + 1
		FightDataHelper.baiFuZhangWheelDataMgr.index = self.index
	end

	flow:registWork(FightTweenWork, {
		type = "DOLocalRotate",
		tox = 0,
		toy = 0,
		t = 0.3,
		tr = self.pointer,
		toz = -self.index * 60 + 60
	})
	flow:registFinishCallback(self.onflowFinish, self)
	flow:start()
end

function Fight3_5BaiFuZhangSpecialWheelView:showTitle()
	local url = "ui/viewres/fight/fight_baifuzhang_tipsview.prefab"

	self:com_loadAsset(url, self.onTitleLoaded)
end

function Fight3_5BaiFuZhangSpecialWheelView:onTitleLoaded(success, assetItem)
	if not success then
		return
	end

	local obj = assetItem:GetResource()
	local cloneObj = gohelper.clone(obj, self.viewGO)

	self:com_registTimer(self.destroyTitle, 2, cloneObj)
end

function Fight3_5BaiFuZhangSpecialWheelView:destroyTitle(obj)
	gohelper.destroy(obj)
end

function Fight3_5BaiFuZhangSpecialWheelView:onflowFinish()
	self:closeThis()

	FightDataHelper.baiFuZhangWheelDataMgr.selectedIndex[FightDataHelper.baiFuZhangWheelDataMgr.index] = true

	FightRpc.instance:sendUseClothSkillRequest(3303019, "0", "0", FightEnum.ClothSkillType.BattleSelection)
end

function Fight3_5BaiFuZhangSpecialWheelView:showWheelList()
	for i = 1, 6 do
		local cardRoot = gohelper.findChild(self.viewGO, string.format("wheel/card/pos%d", i))
		local cardItem = gohelper.clone(self.cardItem, cardRoot)
		local cardIcon = gohelper.findChildSingleImage(cardItem, "root/#card")
		local cardName = self.wheelData[i] == 1 and "103005" or "760021"

		cardName = ResUrl.getSkillIcon(cardName)

		cardIcon:LoadImage(cardName)

		local animator = gohelper.onceAddComponent(cardItem, typeof(UnityEngine.Animator))

		if self.isInit then
			animator:Play("open", 0, 0)
		elseif FightDataHelper.baiFuZhangWheelDataMgr.selectedIndex[i] then
			animator:Play("idle_card", 0, 0)
		else
			animator:Play("idle_black", 0, 0)
		end
	end

	gohelper.setActive(self.cardItem, false)
end

function Fight3_5BaiFuZhangSpecialWheelView:onClose()
	return
end

function Fight3_5BaiFuZhangSpecialWheelView:onDestroyView()
	return
end

return Fight3_5BaiFuZhangSpecialWheelView
