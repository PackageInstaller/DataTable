-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenSettlementSuccessView.lua

module("logic.extensions.dragonxiuer.view.YushenSettlementSuccessView", package.seeall)

local YushenSettlementSuccessView = class("YushenSettlementSuccessView", BattleSettlementBaseView)

function YushenSettlementSuccessView:ctor()
	YushenSettlementSuccessView.super.ctor(self)
end

function YushenSettlementSuccessView:buildUI()
	YushenSettlementSuccessView.super.buildUI(self)

	self._btnNext = self:getBtn("btnNext")
	self._txtDesc = self:getTxt("btnNext/txtDesc")
	self._btnStatics = self:getBtn("part2/right/team/btnStatics")
	self._settlementScore = SettlementScore.New()

	self._settlementScore:buildUI(self:getGo("part2/right/score"))

	self._settlementTeam = SettlementTeam.New()

	self._settlementTeam:buildUI(self:getGo("part2/right/team"))

	self._settlementReward = SettlementReward.New()

	self._settlementReward:buildUI(self:getGo("part2/right/reward"))

	self._settlementProgress = SettlementProgress.New()

	self._settlementProgress:buildUI(self:getGo("part2/right/progress"))

	self._settlementProgress_2 = SettlementProgressDouble.New()

	self._settlementProgress_2:buildUI(self:getGo("part2/right/progress2"))
	table.insert(self._settlementList, self._settlementScore)
	table.insert(self._settlementList, self._settlementTeam)
	table.insert(self._settlementList, self._settlementReward)
	table.insert(self._settlementList, self._settlementProgress)
	table.insert(self._settlementList, self._settlementProgress_2)

	self._isSuccess = true
end

function YushenSettlementSuccessView:destroyUI()
	YushenSettlementSuccessView.super.destroyUI(self)

	self._settlementScore = nil
	self._settlementTeam = nil
	self._settlementReward = nil
	self._settlementProgress = nil
	self._settlementProgress_2 = nil
end

function YushenSettlementSuccessView:bindEvents()
	YushenSettlementSuccessView.super.bindEvents(self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnStatics:AddClickListener(self._onClickStatics, self)
end

function YushenSettlementSuccessView:unbindEvents()
	YushenSettlementSuccessView.super.unbindEvents(self)
	self._btnNext:RemoveClickListener()
	self._btnStatics:RemoveClickListener()
end

function YushenSettlementSuccessView:onEnter()
	YushenSettlementSuccessView.super.onEnter(self)

	local enumType = BattleSettlementModel.instance:getType()

	goutil.setActive(self._btnNext.gameObject, false)

	self._isShowNextBtn = false
end

function YushenSettlementSuccessView:onExit()
	YushenSettlementSuccessView.super.onExit(self)
	self:_stopCountdown()

	if ViewMgr.instance:isOpen(ViewName.BattleStatics) then
		UIStateManager.instance:popByName(ViewName.BattleStatics)
	end
end

function YushenSettlementSuccessView:getAudioId()
	return 30201
end

function YushenSettlementSuccessView:customSettlementInfo()
	local enumType = BattleSettlementModel.instance:getType()

	if enumType == BattleSettlementModel.Enum.YushenBossChallenge then
		self:_onEnumYushenBossChallenge()
	else
		self:_onEnumTypeIsDefault()
	end
end

function YushenSettlementSuccessView:_onEnumTypeIsDefault()
	local param = {}

	table.insert(param, self)
	self:enqueueQueue(self._settlementTeam, param)
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function YushenSettlementSuccessView:_onEnumYushenBossChallenge()
	local params = BattleSettlementModel.instance:getParams()
	local paramA = {
		curNum = params.curNumA,
		maxNum = params.totalNumA,
		progressStr = params.descA,
		color = params.colorA
	}
	local paramB = {
		curNum = params.curNumB,
		maxNum = params.totalNumB,
		progressStr = params.descB,
		color = params.colorB
	}

	self:dequeueQueue()
	self:enqueueQueue(self._settlementProgress_2, {
		paramA,
		paramB,
		params.title
	})
	self:enqueueQueue(self._settlementTeam, {
		self
	})
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function YushenSettlementSuccessView:_onClickNext()
	if self._isClickNext then
		return
	end

	self._isClickNext = true
end

function YushenSettlementSuccessView:_onClickStatics()
	ViewMgr.instance:open(ViewName.BattleStatics)
end

function YushenSettlementSuccessView:_onAnimEnd()
	YushenSettlementSuccessView.super._onAnimEnd(self)
	goutil.setActive(self._btnNext.gameObject, self._isShowNextBtn)

	if self._isShowNextBtn then
		self:_startCountdown()
	end

	self:_popupAceteamBossEndView()
	GlobalDispatcher:dispatch(GlobalNotify.BattleSettlementAniPlayEnd)
end

function YushenSettlementSuccessView:_onSecond()
	self._countdownTime = self._countdownTime - 1

	if self._countdownTime >= 0 then
		self:_setDesc(self._countdownTime)
	else
		self:_onCountdownEnd()
		self:_stopCountdown()
	end
end

function YushenSettlementSuccessView:_startCountdown()
	return
end

function YushenSettlementSuccessView:_stopCountdown()
	removetimer(self._onSecond, self)
end

function YushenSettlementSuccessView:_onCountdownEnd()
	self:_onClickNext()
end

function YushenSettlementSuccessView:_setDesc(time)
	self._txtDesc.text = string.format("下一关（%d秒）", self._countdownTime)
end

function YushenSettlementSuccessView:_popupExtraPassView()
	YushenSettlementSuccessView.super._popupExtraPassView(self)
end

return YushenSettlementSuccessView
