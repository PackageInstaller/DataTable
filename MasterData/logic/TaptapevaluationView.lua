-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/TaptapevaluationView.lua

module("logic.extensions.activitypopup.view.TaptapevaluationView", package.seeall)

local TaptapevaluationView = class("TaptapevaluationView", ViewComponent)

function TaptapevaluationView:ctor()
	TaptapevaluationView.super.ctor(self)
end

function TaptapevaluationView:unbindEvents()
	TaptapevaluationView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnClose)
end

function TaptapevaluationView:bindEvents()
	TaptapevaluationView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickClose, self)
end

function TaptapevaluationView:buildUI()
	TaptapevaluationView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._btnCancel = self:getGo("btnCancel")
end

function TaptapevaluationView:onExit()
	TaptapevaluationView.super.onExit(self)
end

function TaptapevaluationView:onEnter()
	TaptapevaluationView.super.onEnter(self)

	self._openId = checknumber(self:getFirstParam())
end

function TaptapevaluationView:_onClickSure()
	local cochannelId = checknumber(LoginModel.instance:getCoChannelId())

	if cochannelId == 20001 then
		SDKManager.openReviewInTapTap()
	else
		local taptapAppId = SDKManager.TAPTAP_COMMIT_APPID
		local installParam = "taptap://taptap.com/app?app_id=" .. taptapAppId .. "&source=outer|update"
		local notInstallParam = "https://www.taptap.com/app/" .. taptapAppId

		SDKManager.openMobileApp(installParam, notInstallParam)
	end

	SurveyController.instance:reportBehavior(201803, self._openId)
	ViewAutoShowController.instance:trySaveHasEvaluation()
	self:close()
end

function TaptapevaluationView:_onClickClose()
	ViewAutoShowController.instance:trySaveMonthEvaluation()
	self:close()
end

return TaptapevaluationView
