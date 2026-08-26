-- chunkname: @modules/logic/fight/view/Fight38BossWarEchoView.lua

module("modules.logic.fight.view.Fight38BossWarEchoView", package.seeall)

local Fight38BossWarEchoView = class("Fight38BossWarEchoView", FightBaseView)

function Fight38BossWarEchoView:onInitView()
	self.animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._slider = gohelper.findChildImage(self.viewGO, "slider/#image_sliderbg/#image_sliderfg")
	self._skillName = gohelper.findChildText(self.viewGO, "slider/txt_title")
	self._sliderText = gohelper.findChildText(self.viewGO, "slider/#txt_progress")
	self.go_effect1 = gohelper.findChild(self.viewGO, "slider/#go_effect_1")
	self.go_effect2 = gohelper.findChild(self.viewGO, "slider/#go_effect_2")
	self.go_effect3 = gohelper.findChild(self.viewGO, "slider/#go_effect_3")
	self.point1 = gohelper.findChild(self.viewGO, "slider/#image_sliderbg/pointLayout/point_1/full")
	self.point2 = gohelper.findChild(self.viewGO, "slider/#image_sliderbg/pointLayout/point_2/full")
	self.point3 = gohelper.findChild(self.viewGO, "slider/#image_sliderbg/pointLayout/point_3/full")

	local commonTipViewPos = gohelper.findChild(self.viewGO, "commontipview_pos")

	self.commonTipViewPosTr = commonTipViewPos:GetComponent(gohelper.Type_RectTransform)
	self._click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn")
	self.curLevel = nil
end

function Fight38BossWarEchoView:onConstructor(progressData)
	self.progressData = progressData
end

function Fight38BossWarEchoView:onOpen()
	self:_refreshData()
	self:com_registMsg(FightMsgId.NewProgressValueChange, self._refreshData)
	self:com_registClick(self._click, self._onBtnClick)
end

function Fight38BossWarEchoView:_onBtnClick()
	if not self.skillConfig then
		return
	end

	local screenPos = recthelper.uiPosToScreenPos(self.commonTipViewPosTr)
	local title = self.skillConfig.name
	local desc = FightConfig.instance:getSkillEffectDesc(nil, self.skillConfig)

	FightCommonTipController.instance:openCommonView(title, desc, screenPos)
end

function Fight38BossWarEchoView:_refreshData()
	local skillId = self.progressData.skillId
	local skillConfig = lua_skill.configDict[skillId]

	if skillConfig then
		self.skillConfig = skillConfig
		self._skillName.text = skillConfig.name
	end

	local progress = self.progressData.value
	local max = self.progressData.max
	local percent = progress / max

	self._sliderText.text = Mathf.Clamp(percent * 100, 0, 100) .. "%"

	ZProj.TweenHelper.KillByObj(self._slider)
	ZProj.TweenHelper.DOFillAmount(self._slider, percent, 0.3)
	self.point1:SetActive(progress >= 30)
	self.point2:SetActive(progress >= 60)
	self.point3:SetActive(progress >= 100)

	local level = 0

	if progress >= 100 then
		level = 3
	elseif progress >= 60 then
		level = 2
	elseif progress >= 30 then
		level = 1
	end

	if self.curLevel == level then
		return
	end

	local aniName = "leve0"
	local audioId = 0

	if level == 1 then
		aniName = "leve1"
		audioId = 380034
	elseif level == 2 then
		aniName = "leve2"
		audioId = 380035
	elseif level == 3 then
		aniName = "leve3"
		audioId = 380036
	end

	self.animator:Play(aniName, 0, 0)

	self.curLevel = level

	if audioId > 0 then
		AudioMgr.instance:trigger(audioId)
	end
end

function Fight38BossWarEchoView:onClose()
	ZProj.TweenHelper.KillByObj(self._slider)
end

return Fight38BossWarEchoView
