-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/triplemacthesgame/view/TripleMacthesRankView.lua

module("logic.extensions.triplemacthesgame.view.TripleMacthesRankView", package.seeall)

local TripleMacthesRankView = class("TripleMacthesRankView", ViewComponent)

function TripleMacthesRankView:ctor()
	TripleMacthesRankView.super.ctor(self)
end

function TripleMacthesRankView:unbindEvents()
	TripleMacthesRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function TripleMacthesRankView:bindEvents()
	TripleMacthesRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function TripleMacthesRankView:buildUI()
	TripleMacthesRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "right/rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "right/cell")
	self._emptyGo = goutil.findChild(self.mainGO, "right/goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRank")
	self._myStepTitle = self:getGo("right/myRank/txtMyStepTitle")
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
end

function TripleMacthesRankView:onEnter()
	TripleMacthesRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.TripleMacthesRankRefresh, self._refreshView, self)

	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	TripleMatchesGameAgent.instance:sendPM_TripleMatchesGameRankViewReq(self._activityId)
end

function TripleMacthesRankView:onExit()
	TripleMacthesRankView.super.onExit(self)
	self._rankTable:dispose()
end

function TripleMacthesRankView:_refreshView()
	local dailyScore = TripleMacthesModel.instance:getDailyScore()

	self._txtMyStep.text = dailyScore > 0 and langPara("%d", dailyScore) or langPara("%d", 0)

	self._rankTable:reloadData(TripleMacthesModel.instance:getRankInfo())

	if #TripleMacthesModel.instance:getRankInfo() > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = (TripleMacthesModel.instance:getMyRank() > 100 or TripleMacthesModel.instance:getMyRank() <= 0) and lang("未上榜") or TripleMacthesModel.instance:getMyRank()
end

function TripleMacthesRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if rankInfo.headInfo.userId then
				self:onHeadClick(rankInfo.headInfo.userId, imgIcon)
			end
		end)
	end

	txtName.text = rankInfo.headInfo.userName
	txtScore.text = rankInfo.score
	txtArea.text = rankInfo.areaName
end

function TripleMacthesRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function TripleMacthesRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return TripleMacthesRankView
