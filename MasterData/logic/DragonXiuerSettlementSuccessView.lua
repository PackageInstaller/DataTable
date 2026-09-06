-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerSettlementSuccessView.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerSettlementSuccessView", package.seeall)

local DragonXiuerSettlementSuccessView = class("DragonXiuerSettlementSuccessView", BattleSettlementBaseView)

function DragonXiuerSettlementSuccessView:ctor()
	DragonXiuerSettlementSuccessView.super.ctor(self)
end

function DragonXiuerSettlementSuccessView:buildUI()
	DragonXiuerSettlementSuccessView.super.buildUI(self)

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

function DragonXiuerSettlementSuccessView:destroyUI()
	DragonXiuerSettlementSuccessView.super.destroyUI(self)

	self._settlementScore = nil
	self._settlementTeam = nil
	self._settlementReward = nil
	self._settlementProgress = nil
	self._settlementProgress_2 = nil
end

function DragonXiuerSettlementSuccessView:bindEvents()
	DragonXiuerSettlementSuccessView.super.bindEvents(self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._btnStatics:AddClickListener(self._onClickStatics, self)
end

function DragonXiuerSettlementSuccessView:unbindEvents()
	DragonXiuerSettlementSuccessView.super.unbindEvents(self)
	self._btnNext:RemoveClickListener()
	self._btnStatics:RemoveClickListener()
end

function DragonXiuerSettlementSuccessView:onEnter()
	DragonXiuerSettlementSuccessView.super.onEnter(self)

	local enumType = BattleSettlementModel.instance:getType()

	goutil.setActive(self._btnNext.gameObject, false)

	self._isShowNextBtn = false
end

function DragonXiuerSettlementSuccessView:onExit()
	DragonXiuerSettlementSuccessView.super.onExit(self)
	self:_stopCountdown()

	if ViewMgr.instance:isOpen(ViewName.BattleStatics) then
		UIStateManager.instance:popByName(ViewName.BattleStatics)
	end
end

function DragonXiuerSettlementSuccessView:getAudioId()
	return 30201
end

function DragonXiuerSettlementSuccessView:customSettlementInfo()
	local enumType = BattleSettlementModel.instance:getType()

	if enumType == BattleSettlementModel.Enum.DragonXiuerBossChallenge then
		self:_onEnumDragonXiuerBossChallenge()
	else
		self:_onEnumTypeIsDefault()
	end
end

function DragonXiuerSettlementSuccessView:_onEnumTypeIsDefault()
	local param = {}

	table.insert(param, self)
	self:enqueueQueue(self._settlementTeam, param)
	self:enqueueQueue(self._settlementReward, nil)
	self:_doOnEnter()

	self._totalTimeForClickEnd = self._delayTime + 1

	self:_delayOnBtnClose()
end

function DragonXiuerSettlementSuccessView:_onEnumDragonXiuerBossChallenge()
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

function DragonXiuerSettlementSuccessView:_onClickNext()
	if self._isClickNext then
		return
	end

	self._isClickNext = true
end

function DragonXiuerSettlementSuccessView:_onClickStatics()
	ViewMgr.instance:open(ViewName.BattleStatics)
end

function DragonXiuerSettlementSuccessView:_onAnimEnd()
	DragonXiuerSettlementSuccessView.super._onAnimEnd(self)
	goutil.setActive(self._btnNext.gameObject, self._isShowNextBtn)

	if self._isShowNextBtn then
		self:_startCountdown()
	end

	self:_popupAceteamBossEndView()
	GlobalDispatcher:dispatch(GlobalNotify.BattleSettlementAniPlayEnd)
end

function DragonXiuerSettlementSuccessView:_onSecond()
	self._countdownTime = self._countdownTime - 1

	if self._countdownTime >= 0 then
		self:_setDesc(self._countdownTime)
	else
		self:_onCountdownEnd()
		self:_stopCountdown()
	end
end

function DragonXiuerSettlementSuccessView:_startCountdown()
	return
end

function DragonXiuerSettlementSuccessView:_stopCountdown()
	removetimer(self._onSecond, self)
end

function DragonXiuerSettlementSuccessView:_onCountdownEnd()
	self:_onClickNext()
end

function DragonXiuerSettlementSuccessView:_setDesc(time)
	self._txtDesc.text = string.format("下一关（%d秒）", self._countdownTime)
end

function DragonXiuerSettlementSuccessView:_popupExtraPassView()
	DragonXiuerSettlementSuccessView.super._popupExtraPassView(self)
end

return DragonXiuerSettlementSuccessView
