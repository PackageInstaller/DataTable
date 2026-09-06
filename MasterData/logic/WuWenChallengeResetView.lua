-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/WuWenChallengeResetView.lua

module("logic.extensions.wuwenchallenge.view.WuWenChallengeResetView", package.seeall)

local WuWenChallengeResetView = class("WuWenChallengeResetView", ViewComponent)

function WuWenChallengeResetView:ctor()
	WuWenChallengeResetView.super.ctor(self)
end

function WuWenChallengeResetView:unbindEvents()
	WuWenChallengeResetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function WuWenChallengeResetView:bindEvents()
	WuWenChallengeResetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function WuWenChallengeResetView:buildUI()
	WuWenChallengeResetView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtDesc = self:getTxt("txtDesc")
end

function WuWenChallengeResetView:onExit()
	WuWenChallengeResetView.super.onExit(self)
end

function WuWenChallengeResetView:onEnter()
	WuWenChallengeResetView.super.onEnter(self)

	local param = self:getOpenParam()

	self._activityId = param[1]
	self._levelId = param[2]

	local levelCfg = WuWenChallengeConfig.instance:getPhaseCfg(self._activityId, self._levelId)

	self._txtDesc.text = langPara("是否重置【%s】的所有挑战进度", levelCfg.name)
end

function WuWenChallengeResetView:_onClickSure()
	WuWenClgAgent.instance:sendPM_WuWenClgResetPhaseReq(self._activityId)
	self:close()
end

return WuWenChallengeResetView
