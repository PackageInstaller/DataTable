-- chunkname: @modules/logic/fight/view/FightPreDisplayView.lua

module("modules.logic.fight.view.FightPreDisplayView", package.seeall)

local FightPreDisplayView = class("FightPreDisplayView", BaseView)

function FightPreDisplayView:onInitView()
	self._obj = gohelper.findChild(self.viewGO, "root/predisplay")
	self._text = gohelper.findChildText(self._obj, "#txt_CardNum")
	self._btn = gohelper.findChildButtonWithAudio(self.viewGO, "root/predisplay")
	self._ani = SLFramework.AnimatorPlayer.Get(self._btn.gameObject)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightPreDisplayView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnCameraFocusChanged, self._onCameraFocusChanged, self)
	self.addEventCb(self, FightController.instance, FightEvent.AddPlayOperationData, self._onAddPlayOperationData, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self._onResetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillExpand, self._onClothSkillExpand, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillShrink, self._onClothSkillShrink, self)
	self.addClickCb(self, self._btn, self._onBtnClick, self)
end

function FightPreDisplayView:removeEvents()
	return
end

function FightPreDisplayView:_editableInitView()
	return
end

function FightPreDisplayView:_onBtnClick()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.PreCard
	})
end

function FightPreDisplayView:onRefreshViewParam()
	return
end

function FightPreDisplayView:onOpen()
	gohelper.setActive(self._obj, false)
	self:_refreshUI()
end

function FightPreDisplayView:_onResetCard()
	gohelper.setActive(self._obj, false)
	self:_refreshUI()

	self._lastCount = self._curCardCount
	self._isVisible = false
end

function FightPreDisplayView:_refreshUI()
	self._cardList = FightHelper.getNextRoundGetCardList()
	self._curCardCount = #self._cardList
	self._text.text = luaLang("multiple") .. self._curCardCount
end

function FightPreDisplayView:_onAddPlayOperationData()
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	self:_refreshUI()

	if self._curCardCount > 0 then
		self._isVisible = true
	end

	if self._lastCount then
		if #self._cardList > self._lastCount then
			self:_playAni("fiy")
		end
	elseif #self._cardList > 0 then
		self:_playAni("open")
	end

	self._lastCount = #self._cardList
end

function FightPreDisplayView:_playAni(state)
	self._state = state

	gohelper.setActive(self._obj, true)
	self._ani:Play(state, self._aniDone, self)
end

function FightPreDisplayView:_aniDone()
	if self._state == "close" then
		gohelper.setActive(self._obj, false)
	end
end

function FightPreDisplayView:_setActive(state)
	if state then
		if self._isVisible then
			self:_playAni("open")
		end
	elseif self._isVisible then
		self:_playAni("close")
	end
end

function FightPreDisplayView:_hide()
	if self._isVisible then
		self:_playAni("close")
	end
end

function FightPreDisplayView:_onCameraFocusChanged(isFocus)
	if isFocus then
		self:_setActive(false)
	else
		self:_setActive(true)
	end
end

function FightPreDisplayView:onStageChange(stageType)
	if stageType == FightStageMgr.StageType.Play then
		gohelper.setActive(self._obj, false)

		self._isVisible = false
		self._lastCount = nil
	end
end

function FightPreDisplayView:_onClothSkillExpand()
	self:_setActive(false)
end

function FightPreDisplayView:_onClothSkillShrink()
	self:_setActive(true)
end

function FightPreDisplayView:onClose()
	return
end

function FightPreDisplayView:onDestroyView()
	return
end

return FightPreDisplayView
