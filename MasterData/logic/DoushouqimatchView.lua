-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doushouqi/view/DoushouqimatchView.lua

module("logic.extensions.doushouqi.view.DoushouqimatchView", package.seeall)

local DoushouqimatchView = class("DoushouqimatchView", ViewComponent)

function DoushouqimatchView:ctor()
	DoushouqimatchView.super.ctor(self)
end

function DoushouqimatchView:unbindEvents()
	DoushouqimatchView.super.unbindEvents(self)
	self._btnCancel:RemoveClickListener()
	self._btnRobot:RemoveClickListener()
end

function DoushouqimatchView:bindEvents()
	DoushouqimatchView.super.bindEvents(self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnRobot:AddClickListener(self._onClickbtnRobot, self)
end

function DoushouqimatchView:buildUI()
	DoushouqimatchView.super.buildUI(self)

	self._txtTime = self:getTxt("matching/txtTime")
	self._btnCancel = self:getBtn("matching/btnCancel")
	self._effectGo = self.mainGO
	self._btnRobot = self:getBtn("matching/btnRobot")
end

function DoushouqimatchView:onExit()
	DoushouqimatchView.super.onExit(self)
	removetimer(self._setTimer, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function DoushouqimatchView:onEnter()
	DoushouqimatchView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessMatchOverTimeRes, self.close, self)
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessMatchFailRes, self.close, self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessCancelMatchRes, self.close, self)
	self.addGEvent(self, GlobalNotify.NotifyBeastFightingChessMatchRobotFailRes, self._onNotifyBeastFightingChessMatchRobotFailRes, self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessMatchRobotRes, self._onBeastFightingChessMatchRobotRes, self)
	self.addGEvent(self, GlobalNotify.BeastFightingChessMatchRes, self._onBeastFightingChessMatchRes, self)
	goutil.setActive(self._btnRobot.gameObject, false)

	self._activityType = GameEnum.ActivityType.BeastFightingChess

	local params = self:getOpenParam() or {}
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._chessType = checknumber(params[2])
	self._hasShowBtnRobot = false

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("匹配失败")

		return
	end

	self._startMathTime = ServerTime.now()
	self._targetTickTime = self._startMathTime + DoushouqiConfig.instance:getWaitingMatchSec(self._activityId)
	self._startMatchRobotSec = DoushouqiConfig.instance:getStartMatchRobotSec(self._activityId)

	settimer(1, self._setTimer, self, true)

	self._timeCount = 0

	self:_setTimer()
	self:_setEffect()
	DoushouqiController.instance:sendBeastFightingChessMatchReq(self._activityId, self._chessType)
end

function DoushouqimatchView:_onClickbtnCancel()
	BeastFightingChessAgent.instance:sendBeastFightingChessCancelMatchReq(self._activityId)
	self:close()
end

function DoushouqimatchView:_setTimer()
	self._timeCount = self._timeCount + 1

	local time = ServerTime.now() - self._startMathTime
	local min = math.floor(time / 60)
	local sec = time % 60

	self._txtTime.text = string.format("%02d:%02d", min, sec)

	self:_checkActOver()
	self:_checkShowBtnRobot()
end

function DoushouqimatchView:_checkActOver()
	if self._timeCount % 5 == 0 then
		if ServerTime.now() >= self._targetTickTime then
			FloatWordMgr.instance:show("匹配失败")
			self:_onClickbtnCancel()

			return
		end

		local isActActive = ActivityDefineController.instance:isInActivityTimeById(self._activityType, self._activityId)

		if not isActActive then
			FloatWordMgr.instance:show("不在活动时间内")
			self:_onClickbtnCancel()

			return
		end
	end
end

function DoushouqimatchView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_pipeizhong.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function DoushouqimatchView:_onClickbtnRobot()
	BeastFightingChessAgent.instance:sendBeastFightingChessMatchRobotReq(self._activityId)
	goutil.setActive(self._btnRobot.gameObject, false)
end

function DoushouqimatchView:_checkShowBtnRobot()
	if self._hasShowBtnRobot then
		return
	end

	if self._chessType == DoushouqiController.ChessType.Weihuqi then
		return
	end

	if ServerTime.now() - self._startMathTime >= self._startMatchRobotSec then
		self._hasShowBtnRobot = true

		goutil.setActive(self._btnRobot.gameObject, true)
	end
end

function DoushouqimatchView:_onNotifyBeastFightingChessMatchRobotFailRes()
	if self._hasShowBtnRobot then
		goutil.setActive(self._btnRobot.gameObject, true)
	end
end

function DoushouqimatchView:_onBeastFightingChessMatchRobotRes(status)
	if status ~= 0 and self._hasShowBtnRobot then
		goutil.setActive(self._btnRobot.gameObject, true)
	end
end

function DoushouqimatchView:_onBeastFightingChessMatchRes(status)
	if status ~= 0 then
		self:close()
	end
end

return DoushouqimatchView
