-- chunkname: @modules/logic/fight/view/Fight3_5BaiFuZhangWheelSelectCardView.lua

module("modules.logic.fight.view.Fight3_5BaiFuZhangWheelSelectCardView", package.seeall)

local Fight3_5BaiFuZhangWheelSelectCardView = class("Fight3_5BaiFuZhangWheelSelectCardView", FightBaseView)

function Fight3_5BaiFuZhangWheelSelectCardView:onInitView()
	self.imageCard = gohelper.findChildSingleImage(self.viewGO, "root/go_card_onece/image_card")
	self.imageCardBack = gohelper.findChildSingleImage(self.viewGO, "root/go_card_onece/image_cardback")
	self.btnEnemy = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/btn/#btn_enemy")
	self.enemySelect = gohelper.findChild(self.viewGO, "root/btn/#btn_enemy/select")
	self.enemyUnSelect = gohelper.findChild(self.viewGO, "root/btn/#btn_enemy/unselect")

	gohelper.setActive(self.enemySelect, false)
	gohelper.setActive(self.enemyUnSelect, true)

	self.btnMySelf = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/btn/#btn_ours")
	self.mySelfSelect = gohelper.findChild(self.viewGO, "root/btn/#btn_ours/select")
	self.mySelfUnSelect = gohelper.findChild(self.viewGO, "root/btn/#btn_ours/unselect")

	gohelper.setActive(self.mySelfSelect, false)
	gohelper.setActive(self.mySelfUnSelect, true)

	self.leftRoot = gohelper.findChild(self.viewGO, "root/left")
	self.cardOnceAnimator = gohelper.findChildComponent(self.viewGO, "root/go_card_onece", typeof(UnityEngine.Animator))
	self.onceRoot = gohelper.findChild(self.viewGO, "root/go_card_onece")
	self.switchRoot = gohelper.findChild(self.viewGO, "root/go_card_switch")
	self.beforeSwitchImage = gohelper.findChildSingleImage(self.viewGO, "root/go_card_switch/#image_card_last/card")
	self.afterSwitchImage = gohelper.findChildSingleImage(self.viewGO, "root/go_card_switch/#image_card_now/card")
	self.cardSwitchAnimator = gohelper.findChildComponent(self.viewGO, "root/go_card_switch", typeof(UnityEngine.Animator))
	self.titleText = gohelper.findChildText(self.viewGO, "root/left/#txt_title")
	self.descText = gohelper.findChildText(self.viewGO, "root/left/#txt_desc")
end

function Fight3_5BaiFuZhangWheelSelectCardView:addEvents()
	self:com_registClick(self.btnEnemy, self.onClickEnemy)
	self:com_registClick(self.btnMySelf, self.onClickMySelf)
end

function Fight3_5BaiFuZhangWheelSelectCardView:removeEvents()
	return
end

function Fight3_5BaiFuZhangWheelSelectCardView:closeView()
	ViewMgr.instance:closeView(ViewName.Fight3_5BaiFuZhangWheelSelectCardView)
	ViewMgr.instance:closeView(ViewName.Fight3_5BaiFuZhangWheelView)
end

function Fight3_5BaiFuZhangWheelSelectCardView:onClickEnemy()
	if self.isSelected then
		return
	end

	if self.selectBtn == 1 then
		local skillId = 0

		skillId = self.wheelId == 0 and (self.isPlus and 3303024 or 3303020) or self.isPlus and 3303022 or 3303018

		local flow = self:com_registFlowSequence()
		local animatorObj = self.cardOnceAnimator.gameObject
		local audioId = 350040

		if self.isSpecial then
			animatorObj = self.cardOnceAnimator.gameObject
			audioId = 350040
		end

		if self.viewParam.isSwitch then
			animatorObj = self.cardSwitchAnimator.gameObject
			audioId = 350041
		end

		self.isSelected = true

		local btnAnimator = gohelper.findChildComponent(self.btnEnemy.gameObject, "select", typeof(UnityEngine.Animator))

		btnAnimator:Play("confirm", 0, 0)
		flow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, audioId)
		flow:registWork(FightWorkPlayAnimator, animatorObj, "switch")
		flow:registWork(FightWorkDelayTimer, 0.5)
		flow:registWork(FightWorkFunction, FightRpc.instance.sendUseClothSkillRequest, FightRpc.instance, skillId, "0", "0", FightEnum.ClothSkillType.BattleSelection)
		flow:registFinishCallback(self.closeView, self)
		flow:start()

		return
	end

	if self.selectBtn == 2 then
		gohelper.setActive(self.mySelfSelect, false)
		gohelper.setActive(self.mySelfUnSelect, true)
	end

	gohelper.setActive(self.enemySelect, true)
	gohelper.setActive(self.enemyUnSelect, false)

	self.selectBtn = 1
end

function Fight3_5BaiFuZhangWheelSelectCardView:onClickMySelf()
	if self.isSelected then
		return
	end

	if self.selectBtn == 2 then
		local skillId = 0

		skillId = self.wheelId == 0 and (self.isPlus and 3303023 or 3303019) or self.isPlus and 3303021 or 3303017

		local flow = self:com_registFlowSequence()
		local animatorObj = self.cardOnceAnimator.gameObject
		local audioId = 350040

		if self.isSpecial then
			animatorObj = self.cardOnceAnimator.gameObject
			audioId = 350040
		end

		if self.viewParam.isSwitch then
			animatorObj = self.cardSwitchAnimator.gameObject
			audioId = 350041
		end

		self.isSelected = true

		local btnAnimator = gohelper.findChildComponent(self.btnMySelf.gameObject, "select", typeof(UnityEngine.Animator))

		btnAnimator:Play("confirm", 0, 0)
		flow:registWork(FightWorkFunction, AudioMgr.instance.trigger, AudioMgr.instance, audioId)
		flow:registWork(FightWorkPlayAnimator, animatorObj, "switch")
		flow:registWork(FightWorkDelayTimer, 0.5)
		flow:registWork(FightWorkFunction, FightRpc.instance.sendUseClothSkillRequest, FightRpc.instance, skillId, "0", "0", FightEnum.ClothSkillType.BattleSelection)
		flow:registFinishCallback(self.closeView, self)
		flow:start()

		return
	end

	if self.selectBtn == 1 then
		gohelper.setActive(self.enemySelect, false)
		gohelper.setActive(self.enemyUnSelect, true)
	end

	gohelper.setActive(self.mySelfSelect, true)
	gohelper.setActive(self.mySelfUnSelect, false)

	self.selectBtn = 2
end

function Fight3_5BaiFuZhangWheelSelectCardView:_onBtnEsc()
	return
end

function Fight3_5BaiFuZhangWheelSelectCardView:onOpen()
	FightDataHelper.baiFuZhangWheelDataMgr.selectedIndex[FightDataHelper.baiFuZhangWheelDataMgr.index] = true

	AudioMgr.instance:trigger(350039)
	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)

	self.wheelId = self.viewParam.wheelId
	self.isPlus = self.viewParam.isPlus
	self.isSpecial = self.viewParam.isSpecial

	gohelper.setActive(self.leftRoot, false)
	gohelper.setActive(self.onceRoot, true)
	gohelper.setActive(self.switchRoot, false)

	if self.isSpecial then
		gohelper.setActive(self.onceRoot, true)
		gohelper.setActive(self.switchRoot, false)

		local cardName = self.wheelId == 1 and "103005" or "760021"

		cardName = ResUrl.getSkillIcon(cardName)

		self.imageCard:LoadImage(cardName)
	end

	if self.viewParam.isSwitch then
		gohelper.setActive(self.onceRoot, false)
		gohelper.setActive(self.switchRoot, true)

		local beforeCardName = self.wheelId == 1 and "103005" or "760021"

		beforeCardName = ResUrl.getSkillIcon(beforeCardName)

		self.beforeSwitchImage:LoadImage(beforeCardName)

		local afterCardName = self.wheelId == 1 and "760021" or "103005"

		afterCardName = ResUrl.getSkillIcon(afterCardName)

		self.afterSwitchImage:LoadImage(afterCardName)
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		self:com_registTimer(self.autoSelect, 5)
	end
end

function Fight3_5BaiFuZhangWheelSelectCardView:autoSelect()
	self:onClickMySelf()
	self:onClickMySelf()
end

function Fight3_5BaiFuZhangWheelSelectCardView:onClose()
	return
end

function Fight3_5BaiFuZhangWheelSelectCardView:onDestroyView()
	return
end

return Fight3_5BaiFuZhangWheelSelectCardView
