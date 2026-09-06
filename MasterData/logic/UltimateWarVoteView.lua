-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarVoteView.lua

module("logic.extensions.ultimatewar.view.UltimateWarVoteView", package.seeall)

local UltimateWarVoteView = class("UltimateWarVoteView", ViewComponent)

function UltimateWarVoteView:buildUI()
	UltimateWarVoteView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnVoteLeft = self:getGo("btnVoteLeft")
	self._btnVoteRight = self:getGo("btnVoteRight")
end

function UltimateWarVoteView:bindEvents()
	UltimateWarVoteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnVoteLeft, GameUtil.handler(self._onClickBtnVote, self, 1))
	GameUtil.addClickHandler(self._btnVoteRight, GameUtil.handler(self._onClickBtnVote, self, 2))
end

function UltimateWarVoteView:unbindEvents()
	UltimateWarVoteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnVoteLeft)
	GameUtil.rmClickHandler(self._btnVoteRight)
end

function UltimateWarVoteView:onEnter()
	UltimateWarVoteView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._ultimateWarMo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	self._isHasVote = self._ultimateWarMo:getSelectVoteId() > 0

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarVoteRes, self._handlePM_UltimateWarVoteRes, self)
end

function UltimateWarVoteView:onExit()
	UltimateWarVoteView.super.onExit(self)
end

function UltimateWarVoteView:_handlePM_UltimateWarVoteRes()
	self._isHasVote = true

	self:close()
	UIStateManager.instance:push(ViewName.UltimateWarVoteResultView, self._activityId)
end

function UltimateWarVoteView:_onClickBtnVote(voteId)
	if self._isHasVote then
		return
	end

	local data = UltimateWarConfig.instance:getWarVoteData(self._activityId, voteId)
	local tipsContent = string.format("是否确定支持%s", data.desc)

	local function okFunc()
		UltimateWarController.instance:sendPM_UltimateWarVoteReq(self._activityId, voteId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

return UltimateWarVoteView
