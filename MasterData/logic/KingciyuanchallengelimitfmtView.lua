-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengelimitfmtView.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengelimitfmtView", package.seeall)

local KingciyuanchallengelimitfmtView = class("KingciyuanchallengelimitfmtView", ViewComponent)

function KingciyuanchallengelimitfmtView:ctor()
	KingciyuanchallengelimitfmtView.super.ctor(self)
end

function KingciyuanchallengelimitfmtView:unbindEvents()
	KingciyuanchallengelimitfmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function KingciyuanchallengelimitfmtView:bindEvents()
	KingciyuanchallengelimitfmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function KingciyuanchallengelimitfmtView:buildUI()
	KingciyuanchallengelimitfmtView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
end

function KingciyuanchallengelimitfmtView:onExit()
	KingciyuanchallengelimitfmtView.super.onExit(self)
end

function KingciyuanchallengelimitfmtView:onEnter()
	KingciyuanchallengelimitfmtView.super.onEnter(self)
end

function KingciyuanchallengelimitfmtView:_onClickBuff()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.KING_CI_YUAN_CHALLENGE)

	if activityId > 0 then
		UIStateManager.instance:push(ViewName.KingciyuanchallengebuffpopupView, activityId)
	end
end

return KingciyuanchallengelimitfmtView
