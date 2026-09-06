-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idiomchain/view/IdiomChainResultView.lua

module("logic.extensions.idiomchain.view.IdiomChainResultView", package.seeall)

local IdiomChainResultView = class("IdiomChainResultView", ViewComponent)

function IdiomChainResultView:buildUI()
	IdiomChainResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtGameTime = self:getTxt("gameTime/txt")
	self._txtScore = self:getTxt("score/txt")
end

function IdiomChainResultView:bindEvents()
	IdiomChainResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function IdiomChainResultView:unbindEvents()
	IdiomChainResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function IdiomChainResultView:onEnter()
	IdiomChainResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._difficultId = checknumber(params[2])
	self._gameTime = checknumber(params[3])

	self.addGEvent(self, GlobalNotify.HandlePM_IdiomChainGameEndRes, self._onUpdate, self)
	self:_onUpdate()
end

function IdiomChainResultView:onExit()
	IdiomChainResultView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.GameSureCloseView)
end

function IdiomChainResultView:_onUpdate()
	self._txtGameTime.text = self._gameTime

	local scoreData = IdiomChainConfig.instance:getScoreDataBySec(self._activityId, self._difficultId, self._gameTime)

	if scoreData then
		self._txtScore.text = scoreData.score or 0
	end
end

return IdiomChainResultView
