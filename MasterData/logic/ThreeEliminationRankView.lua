-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationRankView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationRankView", package.seeall)

local ThreeEliminationRankView = class("ThreeEliminationRankView", ViewComponent)

function ThreeEliminationRankView:ctor()
	ThreeEliminationRankView.super.ctor(self)
end

function ThreeEliminationRankView:buildUI()
	ThreeEliminationRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "right/rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "right/cell")
	self._emptyGo = goutil.findChild(self.mainGO, "right/goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRank")
	self._myStepTitle = self:getGo("right/myRank/txtMyStepTitle")
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
end

function ThreeEliminationRankView:bindEvents()
	ThreeEliminationRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ThreeEliminationRankView:unbindEvents()
	ThreeEliminationRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ThreeEliminationRankView:destroyUI()
	ThreeEliminationRankView.super.destroyUI(self)
end

function ThreeEliminationRankView:onEnter()
	ThreeEliminationRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameGetRankRes, self._refreshView, self)

	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGameGetRankReq(self._activityId)

	local bestGroup = ThreeEliminationOtherModel.instance:getBestBattleGroup()
	local bestStage = ThreeEliminationOtherModel.instance:getBestBattleStage()

	if bestGroup > 0 then
		GameUtil.SetActive(self._myStepTitle, true)
		GameUtil.SetActive(self._txtMyStep, true)

		self._txtMyStep.text = langPara("%d-%d", bestGroup, bestStage)
	else
		GameUtil.SetActive(self._myStepTitle, false)
		GameUtil.SetActive(self._txtMyStep, false)
	end
end

function ThreeEliminationRankView:onExit()
	ThreeEliminationRankView.super.onExit(self)
	self._rankTable:dispose()
end

function ThreeEliminationRankView:_refreshView()
	self._rankTable:reloadData(ThreeEliminationOtherModel.instance:getRankInfo())

	if #ThreeEliminationOtherModel.instance:getRankInfo() > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = (ThreeEliminationOtherModel.instance:getMyRank() > 100 or ThreeEliminationOtherModel.instance:getMyRank() <= 0) and lang("未上榜") or ThreeEliminationOtherModel.instance:getMyRank()
end

function ThreeEliminationRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local rankInfo = data.rankInfo

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
	txtScore.text = langPara("%d-%d", data.groupId, data.stageId)

	local date = GameUtil.time2date(checknumber(rankInfo.time / 1000))

	txtTime.text = langPara("%s月%s日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
end

function ThreeEliminationRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function ThreeEliminationRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return ThreeEliminationRankView
