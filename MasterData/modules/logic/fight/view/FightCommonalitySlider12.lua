-- chunkname: @modules/logic/fight/view/FightCommonalitySlider12.lua

module("modules.logic.fight.view.FightCommonalitySlider12", package.seeall)

local FightCommonalitySlider12 = class("FightCommonalitySlider12", FightBaseView)
local IconState = {
	Blue = 1,
	Red = 3,
	Grey = 2
}
local IdleAnim = {
	[IconState.Blue] = "idle_blue",
	[IconState.Grey] = "idle_grey",
	[IconState.Red] = "idle_red"
}
local TransitionAnim = {
	[IconState.Blue] = {
		[IconState.Grey] = "b_to_g",
		[IconState.Red] = "b_to_r"
	},
	[IconState.Grey] = {
		[IconState.Blue] = "g_to_b",
		[IconState.Red] = "g_to_r"
	},
	[IconState.Red] = {
		[IconState.Blue] = "r_to_b",
		[IconState.Grey] = "r_to_g"
	}
}

function FightCommonalitySlider12:onInitView()
	self._sliderBlue = gohelper.findChildImage(self.viewGO, "slider/sliderbg/sliderfg_blue")
	self._sliderRed = gohelper.findChildImage(self.viewGO, "slider/sliderbg/sliderfg_red")
	self._sliderGrey = gohelper.findChildImage(self.viewGO, "slider/sliderbg/sliderfg_grey")
	self._sliderGrey.fillAmount = 0
	self._skillName = gohelper.findChildText(self.viewGO, "slider/txt_commonality")
	self._sliderText = gohelper.findChildText(self.viewGO, "slider/sliderbg/#txt_slidernum")
	self._tips = gohelper.findChild(self.viewGO, "tips")
	self._tipsTitle = gohelper.findChildText(self.viewGO, "tips/#txt_title")
	self._desText = gohelper.findChildText(self.viewGO, "tips/desccont/#txt_descitem")
	self._max = gohelper.findChild(self.viewGO, "slider/#max")
	self._iconAni = gohelper.findChildComponent(self.viewGO, "slider/node_iocn", typeof(UnityEngine.Animator))
	self._click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn")
end

function FightCommonalitySlider12:onConstructor(progressData)
	self.progressData = progressData
end

function FightCommonalitySlider12:onOpen()
	self:_refreshData()
	self:com_registMsg(FightMsgId.NewProgressValueChange, self._refreshData)
	self:com_registClick(self._click, self._onBtnClick)
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self._onTouchFightViewScreen)
end

function FightCommonalitySlider12:_onTouchFightViewScreen()
	gohelper.setActive(self._tips, false)
end

function FightCommonalitySlider12:_onBtnClick()
	gohelper.setActive(self._tips, true)
end

function FightCommonalitySlider12:_refreshData()
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

	self._sliderText.text = ""

	local bluePercent = (max - progress) / max

	ZProj.TweenHelper.KillByObj(self._sliderBlue)
	ZProj.TweenHelper.DOFillAmount(self._sliderBlue, bluePercent, 0.2 / FightModel.instance:getUISpeed())

	self._sliderRed.fillAmount = 1

	self:_refreshIconState(progress, max)

	self._lastMax = isMax
end

function FightCommonalitySlider12:_refreshIconState(progress, max)
	local newState = max > progress * 2 and IconState.Blue or max < progress * 2 and IconState.Red or IconState.Grey

	if self._lastIconState == newState then
		return
	end

	if not self._iconAni then
		self._lastIconState = newState

		return
	end

	local animName

	if self._lastIconState == nil then
		animName = IdleAnim[newState]
	else
		local trans = TransitionAnim[self._lastIconState]

		animName = trans and trans[newState]
	end

	if animName then
		self._iconAni:Play(animName, 0, 0)
	end

	self._lastIconState = newState
end

function FightCommonalitySlider12:onClose()
	ZProj.TweenHelper.KillByObj(self._sliderBlue)
end

return FightCommonalitySlider12
