-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtCoverView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtCoverView", package.seeall)

local TongLinShiJiExtCoverView = class("TongLinShiJiExtCoverView", ViewComponent)

function TongLinShiJiExtCoverView:ctor()
	TongLinShiJiExtCoverView.super.ctor(self)
end

function TongLinShiJiExtCoverView:buildUI()
	TongLinShiJiExtCoverView.super.buildUI(self)

	self._btnCover = self:getGo("btnCover")
	self._btnDontCover = self:getGo("btnDontCover")
	self._txtPrePower = self:getTxt("power/txtPrePower")
	self._txtPrePower2 = self:getTxt("power/txtPrePower2")
end

function TongLinShiJiExtCoverView:bindEvents()
	TongLinShiJiExtCoverView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCover, self._onClickBtnCover, self)
	GameUtil.addClickHandler(self._btnDontCover, self._onClickBtnDontCover, self)
end

function TongLinShiJiExtCoverView:unbindEvents()
	TongLinShiJiExtCoverView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCover)
	GameUtil.rmClickHandler(self._btnDontCover)
end

function TongLinShiJiExtCoverView:onEnter()
	TongLinShiJiExtCoverView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._raceType = params[2]
	self._stageId = checknumber(params[3])

	local prePower, curPower = TongLinShiJiModel.instance:GetOldAndCurScore(self._activityId)

	self._txtPrePower.text = prePower
	self._txtPrePower2.text = curPower
end

function TongLinShiJiExtCoverView:onExit()
	TongLinShiJiExtCoverView.super.onExit(self)
end

function TongLinShiJiExtCoverView:_onClickBtnCover()
	local prePower, curPower = TongLinShiJiModel.instance:GetOldAndCurScore(self._activityId)
	local coverCanGetExtReward = TongLinShiJiController.instance:CoverCanGetExtReward(self._activityId, self._raceType, prePower, curPower)

	if coverCanGetExtReward then
		local tipsContent = "元素已平衡！\n快去聚力造极吧！"

		local function func()
			TongLinShiJiController.instance:sendPM_JiClgConfirmExtremeScoreReq(self._activityId, self._raceType, self._stageId, true)
			UIJumper.instance:removeTopState(ViewName.TongLinShiJiExtStageView)
			BattleController.instance:endBattle()
			self:close()
		end

		TipsFacade.instance:openTipWindow("条件达成", tipsContent, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
	else
		TongLinShiJiController.instance:sendPM_JiClgConfirmExtremeScoreReq(self._activityId, self._raceType, self._stageId, true)
		BattleController.instance:endBattle()
	end
end

function TongLinShiJiExtCoverView:_onClickBtnDontCover()
	TongLinShiJiController.instance:sendPM_JiClgConfirmExtremeScoreReq(self._activityId, self._raceType, self._stageId, false)
	BattleController.instance:endBattle()
end

return TongLinShiJiExtCoverView
