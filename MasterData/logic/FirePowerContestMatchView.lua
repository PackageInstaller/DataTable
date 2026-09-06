-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirePowerContestMatchView.lua

module("logic.extensions.firepowercontest.view.FirePowerContestMatchView", package.seeall)

local FirePowerContestMatchView = class("FirePowerContestMatchView", ViewComponent)

function FirePowerContestMatchView:ctor()
	FirePowerContestMatchView.super.ctor(self)
end

function FirePowerContestMatchView:unbindEvents()
	FirePowerContestMatchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FirePowerContestMatchView:bindEvents()
	FirePowerContestMatchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickCloseT, self)
end

function FirePowerContestMatchView:buildUI()
	FirePowerContestMatchView.super.buildUI(self)

	self._matching = self:getGo("matching")
	self._btnClose = self:getBtn("matching/btnCancel")
	self._txtTime = self:getTxt("matching/txtTime")
	self._successNode = self:getGo("success")
end

function FirePowerContestMatchView:onExit()
	FirePowerContestMatchView.super.onExit(self)
	FirePowerContestController.instance:unregisterLocalNotify(FirePowerContestController.AfterMatchResponse, self._onMatchRespone, self)
	FirePowerContestController.instance:unregisterLocalNotify(FirePowerContestController.NotifyMatchFinish, self._onNotifyMatchFinish, self)
	FirePowerContestController.instance:unregisterLocalNotify(FirePowerContestController.AfterCancelMatchResponse, self._onCancelMatchResponese, self)
	self:removeTimer()
	self:_stopMatchSuccessEff()
end

function FirePowerContestMatchView:onEnter()
	FirePowerContestMatchView.super.onEnter(self)
	FirePowerContestController.instance:registerLocalNotify(FirePowerContestController.AfterMatchResponse, self._onMatchRespone, self)
	FirePowerContestController.instance:registerLocalNotify(FirePowerContestController.NotifyMatchFinish, self._onNotifyMatchFinish, self)
	goutil.setActive(self._matching, true)
	goutil.setActive(self._successNode, false)

	self._maxMatchTime = checknumber(FirePowerContestConfig.instance:getCommonValue("MaxMatchingSec"))

	local actId = FirePowerContestConfig.instance:getActId()

	if actId > 0 then
		FirePowerContestAgent.instance:sendPM_FPCBeginMatchReq(actId)
	else
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()
	end

	self._txtTime.text = ""
end

function FirePowerContestMatchView:_onNotifyMatchFinish(status)
	self:removeTimer()

	if status == 0 then
		goutil.setActive(self._matching, false)
		goutil.setActive(self._successNode, true)
		self:_playMatchSuccessEff()
	else
		self:close()
	end
end

function FirePowerContestMatchView:_onMatchRespone(status)
	if status == 0 then
		self._startMatchTime = UnityEngine.Time.realtimeSinceStartup

		self:addTimer()

		local handler = FirePowerContestModel.instance.handler

		handler:setState(FirePowerContestHandler.ST_Matching)
	else
		self:close()
	end
end

function FirePowerContestMatchView:_onCancelMatchResponese(status, msg)
	FirePowerContestController.instance:unregisterLocalNotify(FirePowerContestController.AfterCancelMatchResponse, self._onCancelMatchResponese, self)

	if status == 0 then
		local handler = FirePowerContestModel.instance.handler

		handler:setState(FirePowerContestHandler.ST_None)
	else
		self:close()
	end

	self:close()
end

function FirePowerContestMatchView:_onClickCloseT()
	local handler = FirePowerContestModel.instance.handler

	if handler:isState(FirePowerContestHandler.ST_Matching) then
		FirePowerContestController.instance:registerLocalNotify(FirePowerContestController.AfterCancelMatchResponse, self._onCancelMatchResponese, self)
		FirePowerContestAgent.instance:sendPM_FPCCancelMatchReq()
	else
		self:close()
	end

	FirePowerContestModel.instance:setMatchCD()
end

function FirePowerContestMatchView:removeTimer()
	removetimer(self._tick, self)
end

function FirePowerContestMatchView:addTimer()
	settimer(1, self._tick, self)
end

function FirePowerContestMatchView:_tick()
	local deltaTime = UnityEngine.Time.realtimeSinceStartup - self._startMatchTime

	self._txtTime.text = GameUtil.FormatTimeSymbol(deltaTime)

	if deltaTime >= self._maxMatchTime then
		FloatWordMgr.instance:show(lang("FirePowerContestMatchView__5"))
		FirePowerContestController.instance:reqDisposeGame()
		FirePowerContestModel.instance:setMatchCD()

		if FirePowerContestController.instance:getIsTourArenaMode() then
			-- block empty
		else
			self:close()
		end
	end
end

function FirePowerContestMatchView:_playMatchSuccessEff()
	self:_stopMatchSuccessEff()

	local effPath = "20220401/caijingling/fx_ui_pipeichenggong_cjl.prefab"

	self._matchSuccessEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, false)

	self._matchSuccessEff:setParent(self.mainGO.transform)
	self._matchSuccessEff:setLocalPos(0, 0, 0)
	self._matchSuccessEff:setScale(1)
	self._matchSuccessEff:setEffTime(1.5)

	function self._matchSuccessEff.finishHandler()
		local handler = FirePowerContestModel.instance.handler

		handler:setState(FirePowerContestHandler.ST_Preparing)
		UIStateManager.instance:push(ViewName.FirePowerContestPrepareView)
	end
end

function FirePowerContestMatchView:_stopMatchSuccessEff()
	if self._matchSuccessEff then
		UIEffectManager.instance:stopEffect(self._matchSuccessEff)

		self._matchSuccessEff = nil
	end
end

return FirePowerContestMatchView
