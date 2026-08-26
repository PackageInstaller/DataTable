-- chunkname: @modules/logic/battlepass/view/BpView.lua

module("modules.logic.battlepass.view.BpView", package.seeall)

local BpView = class("BpView", BaseView)

function BpView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "left/#simage_icon")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "left/desc/#simage_signature")
	self._simagerewardbg = gohelper.findChildSingleImage(self.viewGO, "right/#simage_rewardbg")
	self._txtLevel = gohelper.findChildText(self.viewGO, "right/level/#txtLevel")
	self._txtScore = gohelper.findChildText(self.viewGO, "right/score/#txtScore")
	self._goWeeklyLimit = gohelper.findChild(self.viewGO, "right/weeklimit")
	self._txtWeeklyLimit = gohelper.findChildText(self.viewGO, "right/weeklimit/#txtWeeklyLimit")
	self._sliderScore = gohelper.findChildSlider(self.viewGO, "right/Slider")
	self._sliderImage = gohelper.findChildImage(self.viewGO, "right/slidervx")
	self._sliderAnim = gohelper.findChild(self.viewGO, "right/slidervx/ani")
	self._sliderBg = gohelper.findChild(self.viewGO, "right/Slider/Fill Area/Fill")
	self._goToggleGroup = gohelper.findChild(self.viewGO, "right/toggleGroup")
	self._bonusRedDot = gohelper.findChild(self.viewGO, "right/redDot/#go_bonus_reddot")
	self._taskRedDot = gohelper.findChild(self.viewGO, "right/redDot/#go_task_reddot")
	self._btnUpgrade = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btnUpgrade", AudioEnum.UI.play_ui_role_pieces_open)
	self._gomax = gohelper.findChild(self.viewGO, "right/#go_max")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_info", AudioEnum.UI.UI_role_introduce_open)
	self._btnRule = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rule")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "left/desc/#txt_skinname/#btn_faj", AudioEnum.UI.play_artificial_ui_carddisappear)
	self._goexpup = gohelper.findChild(self.viewGO, "right/title/#go_expup")
	self._btntitleClick = gohelper.findChildButtonWithAudio(self.viewGO, "right/title/#btn_titleClick")
	self._rewardContainer = gohelper.findChild(self.viewGO, "right/btngroup/#rewardContainer")
	self._goreward = gohelper.findChild(self._rewardContainer, "#go_reward")
	self._clickArea = gohelper.findChildButtonWithAudio(self._rewardContainer, "#clickArea")
	self._hasget = gohelper.findChild(self._rewardContainer, "#hasget")
	self._btn_claim = gohelper.findChild(self._rewardContainer, "#btn_claim")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpView:addEvents()
	self._btnUpgrade:AddClickListener(self._btnUpgradeOnClick, self)
	self._btnInfo:AddClickListener(self.openStoryTips, self)
	self._btnRule:AddClickListener(self.openTips, self)
	self._btnDetail:AddClickListener(self._btndetailOnClick, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnGetInfo, self._updateLevelScore, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnUpdateScore, self._updateLevelScore, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self._updateLevelScore, self)
	self.addEventCb(self, BpController.instance, BpEvent.OnBuyLevel, self._updateLevelScore, self)
	self.addEventCb(self, BpController.instance, BpEvent.ForcePlayBonusAnim, self._forcePlayBonusAnim, self)
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self.viewContainer:registerCallback(BpEvent.TaskTabChange, self._taskTabChange, self)
	self._btntitleClick:AddClickListener(self._btntitleClickOnClick, self)
	self.addClickCb(self, self._clickArea, self._btnrewardOnClick, self)
	self.addEventCb(self, self.viewContainer, BpEvent.TapViewCloseAnimBegin, self.closeAnimBegin, self)
	self.addEventCb(self, self.viewContainer, BpEvent.TapViewCloseAnimEnd, self.closeAnimEnd, self)
end

function BpView:removeEvents()
	self._btnUpgrade:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self.removeEventCb(self, BpController.instance, BpEvent.OnGetInfo, self._updateLevelScore, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdateScore, self._updateLevelScore, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self._updateLevelScore, self)
	self.removeEventCb(self, BpController.instance, BpEvent.OnBuyLevel, self._updateLevelScore, self)
	self.removeEventCb(self, BpController.instance, BpEvent.ForcePlayBonusAnim, self._forcePlayBonusAnim, self)
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self._toSwitchTab, self)
	self.viewContainer:unregisterCallback(BpEvent.TaskTabChange, self._taskTabChange, self)
	self._btntitleClick:RemoveClickListener()
	self.removeEventCb(self, self.viewContainer, BpEvent.TapViewCloseAnimBegin, self.closeAnimBegin, self)
	self.removeEventCb(self, self.viewContainer, BpEvent.TapViewCloseAnimEnd, self.closeAnimEnd, self)
end

function BpView:_editableInitView()
	gohelper.addUIClickAudio(gohelper.findChild(self.viewGO, "right/toggleGroup/toggleBonus1"), AudioEnum.UI.UI_vertical_first_tabs_click)
	gohelper.addUIClickAudio(gohelper.findChild(self.viewGO, "right/toggleGroup/toggleTask2"), AudioEnum.UI.UI_vertical_first_tabs_click)

	local skinId = BpConfig.instance:getCurSkinId(BpModel.instance.id)
	local heroId = lua_skin.configDict[skinId].characterId
	local heroCo = lua_character.configDict[heroId]

	self._simagesignature:LoadImage(ResUrl.getSignature(heroCo.signature))

	local co = BpConfig.instance:getBpCO(BpModel.instance.id)

	if co then
		local skinname = gohelper.findChildTextMesh(self.viewGO, "left/desc/#txt_skinname")
		local name = gohelper.findChildTextMesh(self.viewGO, "left/desc/#txt_skinname/#txt_name")
		local nameEn = gohelper.findChildTextMesh(self.viewGO, "left/desc/#txt_skinname/#txt_name/#txt_enname")

		skinname.text = co.bpSkinDesc
		name.text = co.bpSkinNametxt
		nameEn.text = co.bpSkinEnNametxt
	end

	if BpModel.instance.firstShow then
		ViewMgr.instance:openView(ViewName.BpVideoView)

		BpModel.instance.firstShow = false

		BpRpc.instance:sendBpMarkFirstShowRequest()
	end

	RedDotController.instance:addRedDot(self._taskRedDot, RedDotEnum.DotNode.BattlePassTaskMain)
	RedDotController.instance:addRedDot(self._bonusRedDot, RedDotEnum.DotNode.BattlePassBonus)
	self:_initToggle()
	gohelper.setActive(self._goexpup, BpModel.instance:isShowExpUp())
end

function BpView:_forcePlayBonusAnim()
	if not self._toggleWraps[1].toggleWrap.isOn then
		self._toggleWraps[1].toggleWrap.isOn = true
	else
		BpController.instance:dispatchEvent(BpEvent.ShowUnlockBonusAnim)
	end
end

function BpView:_initToggle()
	self._toggleWraps = self:getUserDataTb_()

	local toggleCount = self._goToggleGroup.transform.childCount

	for i = 1, toggleCount do
		local toggleGo = self._goToggleGroup.transform:GetChild(i - 1).gameObject
		local toggleGomp = toggleGo:GetComponent(gohelper.Type_Toggle)

		if toggleGomp then
			local toggle = {}

			toggle.toggleWrap = gohelper.onceAddComponent(toggleGo, typeof(SLFramework.UGUI.ToggleWrap))
			toggle.label = gohelper.findChildText(toggleGo, "Label")
			toggle.image = gohelper.findChildImage(toggleGo, "Label/Image")
			toggle.mask = gohelper.findChild(toggleGo, "Background/Checkmark")
			self._toggleWraps[i] = toggle
		end
	end
end

function BpView:_toSwitchTab(tabContainerId, toggleId)
	for k, v in ipairs(self._toggleWraps) do
		SLFramework.UGUI.GuiHelper.SetColor(v.label, k == toggleId and "#ffffff" or "#888888")
		SLFramework.UGUI.GuiHelper.SetColor(v.image, k == toggleId and "#ffffff" or "#888888")
		gohelper.setActive(v.mask, k == toggleId)
	end

	self._tabIndex = toggleId

	self:_checkLimitShow()
end

function BpView:_taskTabChange(tabIndex)
	self._taskIndex = tabIndex

	self:_checkLimitShow()
end

function BpView:_checkLimitShow()
	gohelper.setActive(self._goWeeklyLimit, self._tabIndex ~= 2 or self._tabIndex == 2 and self._taskIndex ~= 3)
end

function BpView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageicon:UnLoadImage()
	self._simagesignature:UnLoadImage()
	self._simagerewardbg:UnLoadImage()
end

function BpView:onOpen()
	self:_updateLevelScore(true)
	self:_toSwitchTab(2, (self.viewParam and self.viewParam.defaultTabIds and self.viewParam.defaultTabIds[2] or nil) and self.viewParam.defaultTabIds[2])
	self:refreshBtnReward()
end

function BpView:closeAnimBegin()
	return
end

function BpView:closeAnimEnd()
	return
end

function BpView:refreshBtnReward()
	self.haveSpecialBonus = BpModel.instance:haveSpecialBonus()

	if self.haveSpecialBonus then
		local isShow = BpModel.instance.payStatus ~= BpEnum.PayStatus.Pay2

		gohelper.setActive(self._rewardContainer, isShow)

		if isShow then
			self.specialItem = self.specialItem or IconMgr.instance:getCommonPropItemIcon(self._goreward)

			local bonus = BpModel.instance:getSpecialBonus()[1]

			self.specialItem:onUpdateMO({
				materilType = bonus[1],
				materilId = bonus[2],
				quantity = bonus[3]
			})
			self.specialItem:isShowCount(false)
			self.specialItem:isShowQuality(false)
			gohelper.setActive(self._btn_claim, BpModel.instance.payStatus == BpEnum.PayStatus.NotPay)
			gohelper.setActive(self._hasget, BpModel.instance.payStatus ~= BpEnum.PayStatus.NotPay)
		end
	end
end

function BpView:onOpenFinish()
	BpModel.instance.isViewLoading = nil

	BpController.instance:dispatchEvent(BpEvent.OnViewOpenFinish)
end

function BpView:onClose()
	if self._addScoreTween then
		ZProj.TweenHelper.KillById(self._addScoreTween)

		self._addScoreTween = nil
	end
end

function BpView:_btnUpgradeOnClick()
	local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)
	local curLevel = math.floor(BpModel.instance.score / levelScore)
	local maxLevel = #BpConfig.instance:getBonusCOList(BpModel.instance.id)

	if curLevel < maxLevel then
		ViewMgr.instance:openView(ViewName.BpBuyView)
	end
end

function BpView:_btndetailOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.HeroSkin, BpConfig.instance:getCurSkinId(BpModel.instance.id), false, nil, false)
end

function BpView:openStoryTips()
	ViewMgr.instance:openView(ViewName.BpInformationView)
end

function BpView:openTips()
	ViewMgr.instance:openView(ViewName.BpRuleTipsView)
end

function BpView:_updateLevelScore(init)
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

	local ismax = BpModel.instance:isMaxLevel()

	gohelper.setActive(self._btnUpgrade.gameObject, not ismax)
	gohelper.setActive(self._gomax, ismax)
	self:refreshBtnReward()
end

function BpView:setSliderValue(value)
	if value < 0 then
		value = value + 1
	end

	self._sliderScore:SetValue(value)

	self._sliderImage.fillAmount = value
end

function BpView:_btntitleClickOnClick()
	if BpModel.instance:isShowExpUp() then
		ToastController.instance:showToast(ToastEnum.BpExpUp)
	end
end

function BpView:_btnrewardOnClick()
	BpController.instance:showSpecialBonusMaterialInfo()
end

return BpView
