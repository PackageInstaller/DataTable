-- chunkname: @modules/logic/fight/view/FightCommonalitySlider5.lua

module("modules.logic.fight.view.FightCommonalitySlider5", package.seeall)

local FightCommonalitySlider5 = class("FightCommonalitySlider5", FightBaseView)

function FightCommonalitySlider5:onInitView()
	self._slider = gohelper.findChildImage(self.viewGO, "slider/sliderbg/sliderfg")
	self._skillName = gohelper.findChildText(self.viewGO, "slider/txt_commonality")
	self._sliderText = gohelper.findChildText(self.viewGO, "slider/sliderbg/#txt_slidernum")
	self._tips = gohelper.findChild(self.viewGO, "tips")
	self._tipsTitle = gohelper.findChildText(self.viewGO, "tips/#txt_title")
	self._desText = gohelper.findChildText(self.viewGO, "tips/desccont/#txt_descitem")
	self._max = gohelper.findChild(self.viewGO, "slider/max")
	self._click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn")
end

function FightCommonalitySlider5:onConstructor(progressData)
	self.progressData = progressData
end

function FightCommonalitySlider5:onOpen()
	self:_refreshData()
	self:com_registMsg(FightMsgId.NewProgressValueChange, self._refreshData)
	self:com_registClick(self._click, self._onBtnClick)
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self._onTouchFightViewScreen)
end

function FightCommonalitySlider5:_onTouchFightViewScreen()
	gohelper.setActive(self._tips, false)
end

function FightCommonalitySlider5:_onBtnClick()
	gohelper.setActive(self._tips, true)
end

function FightCommonalitySlider5:_refreshData()
	local skillId = self.progressData.skillId
	local skillConfig = lua_skill.configDict[skillId]

	if skillConfig then
		self._skillName.text = skillConfig.name
		self._tipsTitle.text = skillConfig.name
		self._desText.text = FightConfig.instance:getSkillEffectDesc(nil, skillConfig)
	end

	local progress = self.progressData.value
	local max = self.progressData.max
	local isMax = max <= progress

	if self._lastMax ~= isMax then
		gohelper.setActive(self._max, isMax)
	end

	local percent = progress / max

	self._sliderText.text = Mathf.Clamp(percent * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(self._slider)
	ZProj.TweenHelper.DOFillAmount(self._slider, percent, 0.2 / FightModel.instance:getUISpeed())

	self._lastMax = isMax
end

function FightCommonalitySlider5:onClose()
	ZProj.TweenHelper.KillByObj(self._slider)
end

return FightCommonalitySlider5
