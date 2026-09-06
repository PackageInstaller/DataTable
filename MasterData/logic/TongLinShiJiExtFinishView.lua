-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtFinishView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtFinishView", package.seeall)

local TongLinShiJiExtFinishView = class("TongLinShiJiExtFinishView", ViewComponent)

function TongLinShiJiExtFinishView:ctor()
	TongLinShiJiExtFinishView.super.ctor(self)
end

function TongLinShiJiExtFinishView:buildUI()
	TongLinShiJiExtFinishView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtPower = self:getTxt("power/txtPower")
end

function TongLinShiJiExtFinishView:bindEvents()
	TongLinShiJiExtFinishView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function TongLinShiJiExtFinishView:unbindEvents()
	TongLinShiJiExtFinishView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TongLinShiJiExtFinishView:onEnter()
	TongLinShiJiExtFinishView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._raceType = params[2]
	self._stageId = checknumber(params[3])

	local prePower, curPower = TongLinShiJiModel.instance:GetOldAndCurScore(self._activityId)

	self._txtPower.text = curPower
end

function TongLinShiJiExtFinishView:onExit()
	TongLinShiJiExtFinishView.super.onExit(self)
end

function TongLinShiJiExtFinishView:_onClickClose()
	BattleController.instance:endBattle()
end

return TongLinShiJiExtFinishView
