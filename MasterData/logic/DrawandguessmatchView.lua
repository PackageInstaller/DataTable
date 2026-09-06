-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessmatchView.lua

module("logic.extensions.drawandguess.view.DrawandguessmatchView", package.seeall)

local DrawandguessmatchView = class("DrawandguessmatchView", ViewComponent)

function DrawandguessmatchView:ctor()
	DrawandguessmatchView.super.ctor(self)
end

function DrawandguessmatchView:unbindEvents()
	DrawandguessmatchView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnExit:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
end

function DrawandguessmatchView:bindEvents()
	DrawandguessmatchView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnExit:AddClickListener(self._onClickbtnExit, self)
	self._btnAgain:AddClickListener(self._onClickbtnAgain, self)
end

function DrawandguessmatchView:buildUI()
	DrawandguessmatchView.super.buildUI(self)

	self._txtDesc = self:getTxt("txtDesc")
	self._btnCancel = self:getBtn("matchcon/btnCancel")
	self._effectGo = self:getGo("effect")
	self._btnExit = self:getBtn("failedcon/btnExit")
	self._btnAgain = self:getBtn("failedcon/btnAgain")
	self._failedconGo = self:getGo("failedcon")
	self._matchconGo = self:getGo("matchcon")
end

function DrawandguessmatchView:onExit()
	DrawandguessmatchView.super.onExit(self)
	removetimer(self._tickTime, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function DrawandguessmatchView:onEnter()
	DrawandguessmatchView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DrawAndGuessMatchRes, self._onDrawAndGuessMatchRes, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessMatchOverTimeRes, self._onNotifyDrawAndGuessMatchOverTimeRes, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessMatchFailRes, self._onNotifyDrawAndGuessMatchFailRes, self)
	self.addGEvent(self, GlobalNotify.PM_NotifyDrawAndGuessGameStartRes, self._onPM_NotifyDrawAndGuessGameStartRes, self)

	self._activityId = self:getFirstParam()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("匹配失败")
		self:_onClickbtnCancel()

		return
	end

	self:_initStartUI()
	self:_startTimer()
	self:_setEffect()
	DrawAndGuessAgent.instance:sendPM_DrawAndGuessMatchReq(self._activityId)
end

function DrawandguessmatchView:_startTimer()
	self._startTime = ServerTime.now()
end

function DrawandguessmatchView:_onClickbtnCancel()
	self:close()
	DrawAndGuessAgent.instance:sendPM_DrawAndGuessCancelMatchReq(self._activityId)
end

function DrawandguessmatchView:_tickTime()
	local time = ServerTime.now() - self._startTime

	self._txtDesc.text = string.format("匹配中：%ss", time)
end

function DrawandguessmatchView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_pipeizhong.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function DrawandguessmatchView:_onDrawAndGuessMatchRes(status)
	if status ~= 0 then
		self:close()
		FloatWordMgr.instance:show("匹配失败")
	end
end

function DrawandguessmatchView:_onNotifyDrawAndGuessMatchOverTimeRes()
	self:_onMatchFail()
end

function DrawandguessmatchView:_onNotifyDrawAndGuessMatchFailRes()
	self:_onMatchFail()
end

function DrawandguessmatchView:_onPM_NotifyDrawAndGuessGameStartRes()
	self:close()
end

function DrawandguessmatchView:_onClickbtnExit()
	self:close()
end

function DrawandguessmatchView:_onClickbtnAgain()
	self:_initStartUI()
	self:_startTimer()
	DrawAndGuessAgent.instance:sendPM_DrawAndGuessMatchReq(self._activityId)
end

function DrawandguessmatchView:_initStartUI()
	goutil.setActive(self._btnCancel.gameObject, true)
	goutil.setActive(self._failedconGo, false)
	goutil.setActive(self._matchconGo, true)
end

function DrawandguessmatchView:_onMatchFail()
	removetimer(self._tickTime, self)

	self._txtDesc.text = "暂时匹配不到，稍后再来吧"

	goutil.setActive(self._btnCancel.gameObject, false)
	goutil.setActive(self._failedconGo, true)
	goutil.setActive(self._matchconGo, false)
end

return DrawandguessmatchView
