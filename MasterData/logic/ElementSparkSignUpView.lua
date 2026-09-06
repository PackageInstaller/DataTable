-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkSignUpView.lua

module("logic.extensions.elementspark.view.ElementSparkSignUpView", package.seeall)

local ElementSparkSignUpView = class("ElementSparkSignUpView", ViewComponent)

function ElementSparkSignUpView:ctor()
	ElementSparkSignUpView.super.ctor(self)
end

function ElementSparkSignUpView:unbindEvents()
	ElementSparkSignUpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnSignUp)

	for i, v in ipairs(self._campList) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function ElementSparkSignUpView:bindEvents()
	ElementSparkSignUpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnSignUp, self._onClickSignUp, self)

	for i, v in ipairs(self._campList) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickCamp, self, i))
	end
end

function ElementSparkSignUpView:buildUI()
	ElementSparkSignUpView.super.buildUI(self)

	self._btnPrize = self:getBtn("btnPrize")
	self._btnShop = self:getBtn("btnShop")
	self._btnRank = self:getBtn("btnRank")
	self._btnSignUp = self:getBtn("btnSign")
	self._txtSign = self:getTxt("btnSign/Text")
	self._txtOpenTime = self:getTxt("txtOpenTime")
	self._txtTip = self:getTxt("txtTip")
	self._campList = {}

	for i = 1, 4 do
		local camp = {}

		camp.btn = self:getBtn("camp/camp_" .. i)

		table.insert(self._campList, camp)
	end
end

function ElementSparkSignUpView:onExit()
	ElementSparkSignUpView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end
end

function ElementSparkSignUpView:onEnter()
	ElementSparkSignUpView.super.onEnter(self)

	self._activityId = ElementSparkController.instance:getActivityId()

	self.addGEvent(self, GlobalNotify.EleSparkGetRegisterInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.EleSparkRegisterRes, self._signUpSuccess, self)

	self._isSignUp = false
	self._stage = self:getFirstParam()

	GameUtil.SetActive(self._btnRank.gameObject, self._stage > GameEnum.ElementSparkStageType.Signup)
	GameUtil.SetActive(self._txtTip.gameObject, self._stage < GameEnum.ElementSparkStageType.Battle)

	local actCfg = ElementSparkConfig.instance:getActivityCfgById(self._activityId)
	local time = actCfg.warStartTime
	local timeDate = GameUtil.string2date(time)

	self._txtOpenTime.text = string.format("龙裔争夺将于%02d月%02d日%02d点开启", timeDate.month, timeDate.day, timeDate.hour)

	self:_playEffect()
	self:_refresh()
	self:_sendInfoReq()
end

function ElementSparkSignUpView:_playEffect()
	local path = "20231222/shenyuneizhan/fx_ui_shenyuneizhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, path, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function ElementSparkSignUpView:_onClickCamp(campId)
	UIStateManager.instance:push(ViewName.ElementSaprkCampDetailView, campId)
end

function ElementSparkSignUpView:_sendInfoReq()
	if self._stage < GameEnum.ElementSparkStageType.Battle then
		ElementSparkController.instance:sendPM_EleSparkGetRegisterInfoReq(self._activityId)
	end
end

function ElementSparkSignUpView:_refresh()
	if self._stage == GameEnum.ElementSparkStageType.Battle then
		self._txtOpenTime.text = "战斗已开始，请尽快加入战斗"
		self._txtSign.text = "进入\n战场"

		return
	end

	if self._stage == GameEnum.ElementSparkStageType.Result then
		self._txtOpenTime.text = "战斗已结束，当前处于公示阶段"
		self._txtSign.text = "战斗\n结束"

		return
	end

	self._isSignUp = ElementSparkModel.instance:getRegisterInfo()
	self._txtSign.text = self._isSignUp and "报名\n成功" or self._stage == GameEnum.ElementSparkStageType.RandomAssigned and "分配中" or "报名"
end

function ElementSparkSignUpView:_signUpSuccess()
	self._isSignUp = ElementSparkModel.instance:getRegisterInfo()
	self._txtSign.text = "报名\n成功"

	FloatWordMgr.instance:show("报名成功，所属势力将在开战后通知")
end

function ElementSparkSignUpView:_onClickPrize()
	UIStateManager.instance:push(ViewName.ElementSparkPrizeView)
end

function ElementSparkSignUpView:_onClickShop()
	GotoMgr.gotoByString(ElementSparkConfig.instance:getActivityCfgById(self._activityId).jumpTo)
end

function ElementSparkSignUpView:_onClickSignUp()
	if self._stage == GameEnum.ElementSparkStageType.Battle then
		ElementSparkSceneController.instance:enterScene()

		return
	end

	if self._stage == GameEnum.ElementSparkStageType.Result then
		ElementSparkSceneController.instance:enterScene()

		return
	end

	if self._stage == GameEnum.ElementSparkStageType.Notopen then
		FloatWordMgr.instance:show("不在战斗阶段或者公示阶段")

		return
	end

	if not self._isSignUp and self._stage == GameEnum.ElementSparkStageType.Signup then
		ElementSparkController.instance:sendPM_EleSparkRegisterReq(self._activityId)
	end

	UIStateManager.instance:push(ViewName.ElementSparkTipsView, self._stage)
end

function ElementSparkSignUpView:_onClickRank()
	UIStateManager.instance:push(ViewName.ElementSparkInfoView, 2, true)
end

return ElementSparkSignUpView
