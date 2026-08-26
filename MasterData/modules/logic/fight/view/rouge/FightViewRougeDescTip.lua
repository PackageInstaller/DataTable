-- chunkname: @modules/logic/fight/view/rouge/FightViewRougeDescTip.lua

module("modules.logic.fight.view.rouge.FightViewRougeDescTip", package.seeall)

local FightViewRougeDescTip = class("FightViewRougeDescTip", BaseViewExtended)

function FightViewRougeDescTip:onInitView()
	self._desTips = self.viewGO
	self._clickTips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._tipsContentObj = gohelper.findChild(self.viewGO, "Content")
	self._tipsContentTransform = self._tipsContentObj and self._tipsContentObj.transform
	self._tipsNameText = gohelper.findChildText(self.viewGO, "Content/#txt_title")
	self._tipsDescText = gohelper.findChildText(self.viewGO, "Content/#txt_details")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRougeDescTip:addEvents()
	self.addClickCb(self, self._clickTips, self._onBtnTips, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.RougeShowTip, self.onRougeShowTip, self)
end

function FightViewRougeDescTip:removeEvents()
	return
end

function FightViewRougeDescTip:onRougeShowTip(tab)
	self:_showTips(tab)
end

function FightViewRougeDescTip:_editableInitView()
	return
end

function FightViewRougeDescTip:onRefreshViewParam()
	return
end

function FightViewRougeDescTip:hideTipObj()
	gohelper.setActive(self._desTips, false)
end

function FightViewRougeDescTip:showTipObj()
	gohelper.setActive(self._desTips, true)
end

function FightViewRougeDescTip:_onBtnTips()
	self:hideTipObj()
end

function FightViewRougeDescTip:_onClothSkillRoundSequenceFinish()
	self:hideTipObj()
end

function FightViewRougeDescTip:_onRoundSequenceFinish()
	self:hideTipObj()
end

function FightViewRougeDescTip:onOpen()
	self:hideTipObj()
end

function FightViewRougeDescTip:_showTips(tab)
	local config = tab and tab.config

	if config then
		gohelper.setActive(self._desTips, true)

		self._tipsNameText.text = config.name
		self._tipsDescText.text = HeroSkillModel.instance:skillDesToSpot(config.desc)

		if self._tipsContentTransform then
			local posX, posY = recthelper.rectToRelativeAnchorPos2(tab.position, self.viewGO.transform)

			recthelper.setAnchorY(self._tipsContentTransform, posY)
		end
	end
end

function FightViewRougeDescTip:onClose()
	return
end

function FightViewRougeDescTip:onDestroyView()
	return
end

return FightViewRougeDescTip
