-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgresetView.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgresetView", package.seeall)

local OrigindarkmoyanclgresetView = class("OrigindarkmoyanclgresetView", ViewComponent)

function OrigindarkmoyanclgresetView:ctor()
	OrigindarkmoyanclgresetView.super.ctor(self)
end

function OrigindarkmoyanclgresetView:unbindEvents()
	OrigindarkmoyanclgresetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function OrigindarkmoyanclgresetView:bindEvents()
	OrigindarkmoyanclgresetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function OrigindarkmoyanclgresetView:buildUI()
	OrigindarkmoyanclgresetView.super.buildUI(self)

	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
end

function OrigindarkmoyanclgresetView:onExit()
	OrigindarkmoyanclgresetView.super.onExit(self)
end

function OrigindarkmoyanclgresetView:onEnter()
	OrigindarkmoyanclgresetView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
end

function OrigindarkmoyanclgresetView:_onClickSure()
	OriginDarkMoYanClgAgent.instance:sendPM_OriginDarkMoYanClgResetCurrentStageReq(self._activityId, self._stageId)
	self:close()
end

return OrigindarkmoyanclgresetView
