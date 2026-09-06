-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtPassView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtPassView", package.seeall)

local TongLinShiJiExtPassView = class("TongLinShiJiExtPassView", ViewComponent)

function TongLinShiJiExtPassView:ctor()
	TongLinShiJiExtPassView.super.ctor(self)
end

function TongLinShiJiExtPassView:buildUI()
	TongLinShiJiExtPassView.super.buildUI(self)

	self._btn = self:getGo("btn")
	self._imgTitle = self:getGo("img/imgTitle")
	self._imgChange = self._imgTitle:GetComponent("UIImageSpriteChange")
end

function TongLinShiJiExtPassView:bindEvents()
	TongLinShiJiExtPassView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btn, self._onClickBtn, self)
end

function TongLinShiJiExtPassView:unbindEvents()
	TongLinShiJiExtPassView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btn)
end

function TongLinShiJiExtPassView:onEnter()
	TongLinShiJiExtPassView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._challengeModel = checknumber(params[2])

	self._imgChange:SetState(self._challengeModel - 1)
end

function TongLinShiJiExtPassView:onExit()
	TongLinShiJiExtPassView.super.onExit(self)
end

function TongLinShiJiExtPassView:_onClickBtn()
	if self._challengeModel == TongLinShiJiModel.NOR_PRIZE_TYPE then
		self:close()
		BattleController.instance:endBattle()
	else
		TongLinShiJiController.instance:sendPM_JiClgGainPrizeReq(self._activityId, TongLinShiJiModel.EXT_PRIZE_TYPE)
		UIStateManager.instance:popByName(ViewName.TongLinShiJiExtView)
		self:close()
	end
end

return TongLinShiJiExtPassView
