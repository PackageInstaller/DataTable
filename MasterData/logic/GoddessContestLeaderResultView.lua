-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/view/GoddessContestLeaderResultView.lua

module("logic.extensions.goddesscontest.view.GoddessContestLeaderResultView", package.seeall)

local GoddessContestLeaderResultView = class("GoddessContestLeaderResultView", ViewComponent)

function GoddessContestLeaderResultView:buildUI()
	GoddessContestLeaderResultView.super.buildUI(self)

	self._txtName = self:getTxt("headCom/txtName")
	self._txtArea = self:getTxt("headCom/area/txt")
	self._head = self:getGo("headCom/head")
	self._txtVoteNum = self:getTxt("voteNum/txt")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
end

function GoddessContestLeaderResultView:bindEvents()
	GoddessContestLeaderResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickClose, self)
end

function GoddessContestLeaderResultView:unbindEvents()
	GoddessContestLeaderResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function GoddessContestLeaderResultView:onEnter()
	GoddessContestLeaderResultView.super.onEnter(self)

	self._curLeaderInfo = GoddessContestModel.instance:getCurLeaderInfo()

	local headInfo = self._curLeaderInfo.headInfo

	HeadItemController.instance:setHeadCellByInfo(self._head, headInfo)

	self._txtVoteNum.text = langPara("获得票数:%s", self._curLeaderInfo.getVoteNum)
	self._txtName.text = headInfo.userName
	self._txtArea.text = headInfo.areaName
end

function GoddessContestLeaderResultView:onExit()
	GoddessContestLeaderResultView.super.onExit(self)
	HeadItemController.instance:resetHeadCell(self._head)
end

function GoddessContestLeaderResultView:_onClickClose()
	self:close()
	GoddessContestModel.instance:setUserIsFirstOpen(GoddessContestModel.LeaderResultTipKey)
end

return GoddessContestLeaderResultView
