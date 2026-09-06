-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlewinresultView.lua

module("logic.extensions.lotusbattle.view.LotusbattlewinresultView", package.seeall)

local LotusbattlewinresultView = class("LotusbattlewinresultView", ViewComponent)

function LotusbattlewinresultView:ctor()
	LotusbattlewinresultView.super.ctor(self)
end

function LotusbattlewinresultView:unbindEvents()
	LotusbattlewinresultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function LotusbattlewinresultView:bindEvents()
	LotusbattlewinresultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function LotusbattlewinresultView:buildUI()
	LotusbattlewinresultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("txtTime")
	self._txtScore = self:getTxt("score/txtScore")
end

function LotusbattlewinresultView:onExit()
	LotusbattlewinresultView.super.onExit(self)
	removetimer(self._tick, self)
end

function LotusbattlewinresultView:onEnter()
	LotusbattlewinresultView.super.onEnter(self)

	self._activityId = LotusbattleModel.instance:getActivityId()
	self._battleMsg = LotusbattleModel.instance:getResultViewDatas()
	self._txtScore.text = string.format("已淘汰人数：%s", self._battleMsg.winStreak)
	self._countDownTime = LotusbattleConfig.instance:getStageTime(self._activityId, "settleStopTime")

	settimer(1, self._tick, self, true)
	self:_tick()
end

function LotusbattlewinresultView:_tick()
	self._countDownTime = self._countDownTime - 1
	self._txtTime.text = string.format("%s秒后未操作自动关闭", self._countDownTime)

	if self._countDownTime <= 0 then
		self:_onClickbtnClose()
		removetimer(self._tick, self)
	end
end

function LotusbattlewinresultView:_onClickbtnClose()
	LotusbattleController.instance:closeResultView()
	self:close()
end

return LotusbattlewinresultView
