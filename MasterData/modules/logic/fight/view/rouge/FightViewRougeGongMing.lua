-- chunkname: @modules/logic/fight/view/rouge/FightViewRougeGongMing.lua

module("modules.logic.fight.view.rouge.FightViewRougeGongMing", package.seeall)

local FightViewRougeGongMing = class("FightViewRougeGongMing", BaseViewExtended)

function FightViewRougeGongMing:onInitView()
	self._resonancelObj = self.viewGO
	self._resonancelNameText = gohelper.findChildText(self.viewGO, "bg/#txt_name")
	self._resonancelLevelText = gohelper.findChildText(self.viewGO, "bg/#txt_level")
	self._clickResonancel = gohelper.findChildClickWithDefaultAudio(self.viewGO, "bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRougeGongMing:addEvents()
	self.addClickCb(self, self._clickResonancel, self._onBtnResonancel, self)
	self.addEventCb(self, FightController.instance, FightEvent.ResonanceLevel, self._onResonanceLevel, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillRoundSequenceFinish, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
end

function FightViewRougeGongMing:removeEvents()
	return
end

function FightViewRougeGongMing:_editableInitView()
	return
end

function FightViewRougeGongMing:onRefreshViewParam()
	return
end

function FightViewRougeGongMing:hideResonanceObj()
	gohelper.setActive(self._resonancelObj, false)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeGongMing)
end

function FightViewRougeGongMing:showResonanceObj()
	gohelper.setActive(self._resonancelObj, true)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeGongMing)
end

function FightViewRougeGongMing:_onClothSkillRoundSequenceFinish()
	self:hideResonanceObj()
end

function FightViewRougeGongMing:_onRoundSequenceFinish()
	self:hideResonanceObj()
end

function FightViewRougeGongMing:_onResonanceLevel()
	self:_refreshData()
end

function FightViewRougeGongMing:_onPolarizationLevel()
	self:_refreshData()
end

function FightViewRougeGongMing:onOpen()
	self:hideResonanceObj()
end

function FightViewRougeGongMing:_refreshData()
	gohelper.setActive(self.viewGO, true)
	self:_refreshGongMing()
end

FightViewRougeGongMing.TempParam = {}

function FightViewRougeGongMing:_onBtnResonancel()
	local tab = FightViewRougeGongMing.TempParam

	tab.config = self._resonancelConfig
	tab.position = self._resonancelObj.transform.position

	FightController.instance:dispatchEvent(FightEvent.RougeShowTip, tab)
end

function FightViewRougeGongMing:_refreshGongMing()
	self._resonancelLevel = FightRoundSequence.roundTempData.ResonanceLevel

	if self._resonancelLevel then
		local showResonancelLevel = self._resonancelLevel ~= 0

		if showResonancelLevel then
			local config = lua_resonance.configDict[self._resonancelLevel]

			if config then
				self:showResonanceObj()

				self._resonancelConfig = config
				self._resonancelNameText.text = config and config.name
				self._resonancelLevelText.text = "Lv." .. self._resonancelLevel

				for i = 1, 3 do
					local effectObj = gohelper.findChild(self.viewGO, "effect_lv/effect_lv" .. i)

					gohelper.setActive(effectObj, i == self._resonancelLevel)
				end

				if self._resonancelLevel > 3 then
					gohelper.setActive(gohelper.findChild(self.viewGO, "effect_lv/effect_lv3"), true)
				end
			else
				self:hideResonanceObj()
			end
		end
	end
end

function FightViewRougeGongMing:onClose()
	return
end

function FightViewRougeGongMing:onDestroyView()
	return
end

return FightViewRougeGongMing
