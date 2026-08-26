-- chunkname: @modules/logic/fight/view/FightNuoDiKaQteView.lua

module("modules.logic.fight.view.FightNuoDiKaQteView", package.seeall)

local FightNuoDiKaQteView = class("FightNuoDiKaQteView", FightBaseView)

function FightNuoDiKaQteView:onInitView()
	self.level0 = gohelper.findChild(self.viewGO, "operate/root/level0")
	self.level1 = gohelper.findChild(self.viewGO, "operate/root/level1")
	self.level2 = gohelper.findChild(self.viewGO, "operate/root/level2")
	self.level3 = gohelper.findChild(self.viewGO, "operate/root/level3")
	self.countText = gohelper.findChildText(self.viewGO, "operate/root/num/#txt_num")
	self.countEffectText = gohelper.findChildText(self.viewGO, "operate/root/num/#txt_num_effect")
	self.text1 = gohelper.findChildText(self.viewGO, "operate/root/level1/#txt_num")
	self.text2 = gohelper.findChildText(self.viewGO, "operate/root/level2/#txt_num")
	self.text3 = gohelper.findChildText(self.viewGO, "operate/root/level3/#txt_num")
	self.btnClick = gohelper.findChildClick(self.viewGO, "operate/root/#btn_click")
	self.ani = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
	self.numAni = gohelper.findChildComponent(self.viewGO, "operate/root/num", typeof(UnityEngine.Animator))
	self._longPress = SLFramework.UGUI.UILongPressListener.Get(self.btnClick.gameObject)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightNuoDiKaQteView:addEvents()
	self:com_registClick(self.btnClick, self.onBtnClick)
	self:com_registLongPress(self._longPress, self._onLongPress)
	self._longPress:SetLongPressTime({
		0.1
	})
	self:com_registFightEvent(FightEvent.PlayOnceQteWhenTimeout, self.onPlayOnceQteWhenTimeout)
end

function FightNuoDiKaQteView:removeEvents()
	return
end

function FightNuoDiKaQteView:onConstructor()
	return
end

function FightNuoDiKaQteView:onPlayOnceQteWhenTimeout()
	self:clickFunc()
end

function FightNuoDiKaQteView:onBtnClick()
	if self.clickCount == self.maxCount then
		return
	end

	local curTime = Time.time

	self.time = self.time or curTime

	if curTime - self.time > self.timeLimit then
		self.time = curTime

		self:clickFunc()
	end
end

function FightNuoDiKaQteView:_onLongPress()
	self:onBtnClick()
end

function FightNuoDiKaQteView:clickFunc()
	local success = self:com_sendMsg(FightMsgId.OperationForPlayEffect, self.effectType)

	if success then
		self.clickCount = self.clickCount + 1

		local level = self:refreshBtn()
		local clickName = level == 1 and "click" or "click" .. level

		self.ani:Play(clickName, 0, 0)
		self.numAni:Play("update", 0, 0)
		AudioMgr.instance:trigger(20280402)

		if self.clickCount == 1 then
			AudioMgr.instance:trigger(20280401)
		end
	end
end

function FightNuoDiKaQteView:refreshText()
	local count = self.maxCount - self.clickCount

	self.countText.text = count
	self.countEffectText.text = count
end

function FightNuoDiKaQteView:refreshBtn()
	self:refreshText()

	if self.clickCount <= self.levelCount[1] then
		gohelper.setActive(self.level0, false)
		gohelper.setActive(self.level1, true)
		gohelper.setActive(self.level2, false)
		gohelper.setActive(self.level3, false)

		return 1
	end

	if self.clickCount <= self.levelCount[2] then
		gohelper.setActive(self.level0, false)
		gohelper.setActive(self.level1, false)
		gohelper.setActive(self.level2, true)
		gohelper.setActive(self.level3, false)

		return 2
	end

	if self.clickCount <= self.levelCount[3] then
		gohelper.setActive(self.level0, false)
		gohelper.setActive(self.level1, false)
		gohelper.setActive(self.level2, false)
		gohelper.setActive(self.level3, true)

		return 3
	end

	return 3
end

function FightNuoDiKaQteView:onOpen()
	self.time = 0
	self.effectType = self.viewParam.effectType
	self.timeLimit = self.viewParam.timeLimit
	self.paramsArr = self.viewParam.paramsArr
	self.fightStepData = self.viewParam.fightStepData
	self.maxCount = 0

	for i, actEffectData in ipairs(self.fightStepData.actEffect) do
		if actEffectData.effectType == self.effectType then
			self.maxCount = string.splitToNumber(actEffectData.reserveStr, "#")[2] or 0

			break
		end
	end

	local arr = GameUtil.splitString2(self.paramsArr[2], false, ",", "#") or {}

	self.levelCount = {}
	self.clickCount = 0

	for i, v in ipairs(arr) do
		self.levelCount[i] = tonumber(v[1])
	end

	gohelper.setActive(self.level0, true)
	gohelper.setActive(self.level1, false)
	gohelper.setActive(self.level2, false)
	gohelper.setActive(self.level3, false)
	self:refreshText()
	self:com_registUpdate(self.onUpdate)
	self:com_sendFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, true)

	self.showBtnNames = {
		"btnSpeed",
		"btnAuto"
	}

	self:com_sendFightEvent(FightEvent.SetBtnListVisibleWhenHidingFightView, true, self.showBtnNames)
end

function FightNuoDiKaQteView:onUpdate()
	local isAuto = FightDataHelper.stateMgr:getIsAuto() or FightDataHelper.stateMgr.isReplay

	if isAuto then
		self:onBtnClick()
	end
end

function FightNuoDiKaQteView:onClose()
	self:com_sendFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, false)
	self:com_sendFightEvent(FightEvent.SetBtnListVisibleWhenHidingFightView, false, self.showBtnNames)
end

function FightNuoDiKaQteView:onDestroyView()
	return
end

return FightNuoDiKaQteView
