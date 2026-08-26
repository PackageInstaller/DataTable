-- chunkname: @modules/logic/battlepass/view/BpSPView.lua

module("modules.logic.battlepass.view.BpSPView", package.seeall)

local BpSPView = class("BpSPView", BaseView)

function BpSPView:onInitView()
	self._btnSelectBonus = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_faj")
	self._txtLevel = gohelper.findChildText(self.viewGO, "right/level/#txtLevel")
	self._txtScore = gohelper.findChildText(self.viewGO, "right/score/#txtScore")
	self._goWeeklyLimit = gohelper.findChild(self.viewGO, "right/weeklimit")
	self._txtWeeklyLimit = gohelper.findChildText(self.viewGO, "right/weeklimit/#txtWeeklyLimit")
	self._sliderScore = gohelper.findChildSlider(self.viewGO, "right/Slider")
	self._sliderImage = gohelper.findChildImage(self.viewGO, "right/slidervx")
	self._sliderAnim = gohelper.findChild(self.viewGO, "right/slidervx/ani")
	self._sliderBg = gohelper.findChild(self.viewGO, "right/Slider/Fill Area/Fill")
	self._gomax = gohelper.findChild(self.viewGO, "right/#go_max")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_info", AudioEnum.UI.UI_role_introduce_open)
	self._btnRule = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rule")
end

function BpSPView:addEvents()
	self._btnSelectBonus:AddClickListener(self._onClickSelectBonus, self)
	self._btnInfo:AddClickListener(self.openStoryTips, self)
	self._btnRule:AddClickListener(self.openTips, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnGetInfo, self._updateLevelScore, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnUpdateScore, self._updateLevelScore, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self._updateLevelScore, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnBuyLevel, self._updateLevelScore, self)
	self.addEventCb(self, BpController.instance, BpEvent.ForcePlayBonusAnim, self._forcePlayBonusAnim, self)
end

function BpSPView:removeEvents()
	self._btnSelectBonus:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self.removeEventCb(self, BpController.instance, BpEvent.OnGetInfo, self._updateLevelScore, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdateScore, self._updateLevelScore, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self._updateLevelScore, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnBuyLevel, self._updateLevelScore, self)
	self.removeEventCb(self, BpController.instance, BpEvent.ForcePlayBonusAnim, self._forcePlayBonusAnim, self)
end

function BpSPView:_forcePlayBonusAnim()
	if not self._toggleWraps[1].toggleWrap.isOn then
		self._toggleWraps[1].toggleWrap.isOn = true
	else
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end
end

function BpSPView:onOpen()
	self:_updateLevelScore(true)
end

function BpSPView:onOpenFinish()
	BpModel.instance.isViewLoading = nil

	BpController.instance:dispatchEvent(BpEvent.OnViewOpenFinish)
end

function BpSPView:onClose()
	if self._addScoreTween then
		ZProj.TweenHelper.KillById(self._addScoreTween)

		self._addScoreTween = nil
	end
end

function BpSPView:openStoryTips()
	ViewMgr.instance:openView(ViewName.BpSPInformationView)
end

function BpSPView:openTips()
	ViewMgr.instance:openView(ViewName.BpSPRuleTipsView)
end

function BpSPView:_updateLevelScore(init)
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local level = math.floor(BpModel.instance.score / levelScore)
	local scoreInThisLevel = BpModel.instance.score % levelScore
	local weeklyScore = BpModel.instance.weeklyScore
	local weeklyMaxScore = BpModel.instance:getWeeklyMaxScore()

	self._txtLevel.text = level
	self._txtScore.text = scoreInThisLevel .. "/" .. levelScore
	self._txtWeeklyLimit.text = weeklyMaxScore <= weeklyScore and weeklyScore .. "/" .. weeklyMaxScore or "<color=#CAC8C5>" .. weeklyScore .. "/" .. weeklyMaxScore

	local toValue = scoreInThisLevel / levelScore
	local fromValue = self._sliderScore:GetValue()

	if init then
		self:setSliderValue(toValue)
	elseif math.abs(fromValue - toValue) > 0.01 then
		if self._addScoreTween then
			ZProj.TweenHelper.KillById(self._addScoreTween)

			self._addScoreTween = nil
		end

		if toValue < fromValue then
			fromValue = fromValue - 1
		end

		self._addScoreTween = ZProj.TweenHelper.DOTweenFloat(fromValue, toValue, BpEnum.AddScoreTime, self.setSliderValue, nil, self, nil, EaseType.OutQuart)
	end

	local curLevel = math.floor(BpModel.instance.score / levelScore)
	local maxLevel = #BpConfig.instance:getBonusCOList(BpModel.instance.id)
	local ismax = maxLevel <= curLevel

	gohelper.setActive(self._gomax, ismax)
end

function BpSPView:_onClickSelectBonus()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpBonusSelectView)
end

function BpSPView:setSliderValue(value)
	if value < 0 then
		value = value + 1
	end

	self._sliderScore:SetValue(value)

	self._sliderImage.fillAmount = value
end

return BpSPView
