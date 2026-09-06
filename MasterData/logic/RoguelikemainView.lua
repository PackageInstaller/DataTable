-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikemainView.lua

module("logic.extensions.roguelike.view.RoguelikemainView", package.seeall)

local RoguelikemainView = class("RoguelikemainView", ViewComponent)

function RoguelikemainView:buildUI()
	RoguelikemainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnTask = self:getGo("btnTask")
	self._btnPrize = self:getGo("btnPrize")
	self._btnFarm = self:getGo("btnFarm")
	self._btnRank = self:getGo("btnRank")
	self._btnBuff = self:getGo("btnBuff")
	self._btnRent = self:getGo("btnRent")
	self._btnChallenge1 = self:getGo("btnChallenge1")
	self._btnChallenge2 = self:getGo("btnChallenge2")
	self._lockClg1 = self:getGo("btnChallenge1/lock")
	self._lockClg2 = self:getGo("btnChallenge2/lock")
	self._txtChallenge1 = self:getTxt("challengeDesc1/txt")
	self._txtChallenge2 = self:getTxt("challengeDesc2/txt")
	self._txtTime = self:getTxt("time/txt")
	self._bgClgDesc1 = self:getGo("challengeDesc1/bg")
	self._bgClgDesc2 = self:getGo("challengeDesc2/bg")
	self._clgTextChange1 = self:getGo("challengeDesc1/txt"):GetComponent(ComponentType.UITextColorChange)
	self._clgTextChange2 = self:getGo("challengeDesc2/txt"):GetComponent(ComponentType.UITextColorChange)
	self._prizeRedPoint = self:getGo("btnPrize/redPoint")
	self._farmRedPoint = self:getGo("btnFarm/redPoint")
	self._btnTaskredPointGo = self:getGo("btnTask/redPoint")
end

function RoguelikemainView:bindEvents()
	RoguelikemainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnFarm, self._onClickFarm, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnRent, self._onClickRent, self)
	GameUtil.addClickHandler(self._btnChallenge1, self._onClickChallenge1, self)
	GameUtil.addClickHandler(self._btnChallenge2, self._onClickChallenge2, self)
end

function RoguelikemainView:unbindEvents()
	RoguelikemainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnFarm)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnRent)
	GameUtil.rmClickHandler(self._btnChallenge1)
	GameUtil.rmClickHandler(self._btnChallenge2)
end

function RoguelikemainView:onEnter()
	RoguelikemainView.super.onEnter(self)
	self:_loadEffect()
	self.addGEvent(self, GlobalNotify.RoguelikeGetInfoRes, self._onGetInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = RoguelikeModel.instance:getActivityId()
	end

	self:_initActivityTime()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = RoguelikeConfig.instance:getActivityCfg(self._activityId)

	RedPointController.instance:regRedPoint(self._prizeRedPoint, self._cfgActivity.redPointId)

	local farmRedPointId = 515

	RedPointController.instance:regRedPoint(self._farmRedPoint, farmRedPointId)
	RedPointController.instance:regRedPoint(self._btnTaskredPointGo, 470)
	self:_updateChallengeBtns()
	RoguelikeAgent.instance:sendPM_RoguelikeGetInfoReq(self._activityId)
end

function RoguelikemainView:onExit()
	RoguelikemainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._prizeRedPoint)
	RedPointController.instance:unregRedPoint(self._farmRedPoint)
	RedPointController.instance:unregRedPoint(self._btnTaskredPointGo)
	self:_removeEffect()
end

function RoguelikemainView:_onClickTip()
	TipsFacade.instance:openRulesView("roguelikemainview_rule")
end

function RoguelikemainView:_onClickTask()
	UIStateManager.instance:push(ViewName.CommonGroupTaskMainView, self._activityId, 1)
end

function RoguelikemainView:_onClickPrize()
	UIStateManager.instance:push(ViewName.RoguelikeprizeView, self._activityId)
end

function RoguelikemainView:_onClickFarm()
	FuncOpenController.instance:openFunc(FuncConst.EternalFarm)
end

function RoguelikemainView:_onClickRank()
	UIStateManager.instance:push(ViewName.RoguelikeranktabView, self._activityId)
end

function RoguelikemainView:_onClickBuff()
	UIStateManager.instance:push(ViewName.RoguelikebufflevelupView, self._activityId)
end

function RoguelikemainView:_onClickRent()
	UIStateManager.instance:push(ViewName.RoguelikerentpetView, self._activityId)
end

function RoguelikemainView:_onClickChallenge1()
	local isUnlock = RoguelikeModel.instance:isPhaseUnlock(self._activityId, RoguelikeModel.Challenge1)

	if isUnlock then
		UIStateManager.instance:push(ViewName.RoguelikelevelView, self._activityId, RoguelikeModel.Challenge1)
	else
		local cfgPhase = RoguelikeConfig.instance:getPhaseCfg(self._activityId, RoguelikeModel.Challenge1)
		local date = GameUtil.string2date(cfgPhase.releaseTime)
		local str = string.format("%s.%s 5:00后解锁", date.month, date.day)

		FloatWordMgr.instance:show(str)
	end
end

function RoguelikemainView:_onClickChallenge2()
	local isUnlock = RoguelikeModel.instance:isPhaseUnlock(self._activityId, RoguelikeModel.Challenge2)

	if isUnlock then
		UIStateManager.instance:push(ViewName.RoguelikelevelView, self._activityId, RoguelikeModel.Challenge2)
	else
		local cfgPhase = RoguelikeConfig.instance:getPhaseCfg(self._activityId, RoguelikeModel.Challenge2)
		local date = GameUtil.string2date(cfgPhase.releaseTime)
		local str = string.format("%s.%s 5:00后解锁", date.month, date.day)

		FloatWordMgr.instance:show(str)
	end
end

function RoguelikemainView:_onGetInfoRes()
	self:_updateChallengeBtns()
end

function RoguelikemainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function RoguelikemainView:_updateChallengeBtns()
	local isUnlock1 = RoguelikeModel.instance:isPhaseUnlock(self._activityId, RoguelikeModel.Challenge1)

	goutil.setActive(self._lockClg1, not isUnlock1)

	if isUnlock1 then
		local num = RoguelikeModel.instance:getNormalMaxPassedStageId(self._activityId, RoguelikeModel.Challenge1)

		self._txtChallenge1.text = string.format("当前已完成<color=#%s>%d</color>关", ColorConst.Green, num)

		GameUtil.SetGray(self._bgClgDesc1, false)
		self._clgTextChange1:SetState(1)
	else
		local cfgPhase = RoguelikeConfig.instance:getPhaseCfg(self._activityId, RoguelikeModel.Challenge1)
		local date = GameUtil.string2date(cfgPhase.releaseTime)

		self._txtChallenge1.text = string.format("%d.%d 5:00后解锁", date.month, date.day)

		GameUtil.SetGray(self._bgClgDesc1, true)
		self._clgTextChange1:SetState(0)
	end

	local isUnlock2 = RoguelikeModel.instance:isPhaseUnlock(self._activityId, RoguelikeModel.Challenge2)

	goutil.setActive(self._lockClg2, not isUnlock2)

	if isUnlock2 then
		local num = RoguelikeModel.instance:getNormalMaxPassedStageId(self._activityId, RoguelikeModel.Challenge2)

		self._txtChallenge2.text = string.format("当前已完成<color=#%s>%d</color>关", ColorConst.Green, num)

		GameUtil.SetGray(self._bgClgDesc2, false)
		self._clgTextChange2:SetState(1)
	else
		local cfgPhase = RoguelikeConfig.instance:getPhaseCfg(self._activityId, RoguelikeModel.Challenge2)
		local date = GameUtil.string2date(cfgPhase.releaseTime)

		self._txtChallenge2.text = string.format("%d.%d 5:00后解锁", date.month, date.day)

		GameUtil.SetGray(self._bgClgDesc2, true)
		self._clgTextChange2:SetState(0)
	end
end

function RoguelikemainView:_loadEffect()
	self:_removeEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, RoguelikemainViewPresentor.BgEffectPath, self.mainGO.transform, 0, 0, true, false)

	uiEffect:setParent(self.mainGO.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffect = uiEffect
end

function RoguelikemainView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return RoguelikemainView
