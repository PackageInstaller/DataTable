-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegoddragonclg/view/DivineGodDragonClgRankView.lua

module("logic.extensions.divinegoddragonclg.view.DivineGodDragonClgRankView", package.seeall)

local DivineGodDragonClgRankView = class("DivineGodDragonClgRankView", ViewComponent)

function DivineGodDragonClgRankView:ctor()
	DivineGodDragonClgRankView.super.ctor(self)
end

function DivineGodDragonClgRankView:buildUI()
	DivineGodDragonClgRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "right/rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "right/cell")
	self._emptyGo = goutil.findChild(self.mainGO, "right/goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRank")
	self._myStepTitle = self:getGo("right/myRank/txtMyStepTitle")
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
end

function DivineGodDragonClgRankView:bindEvents()
	DivineGodDragonClgRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineGodDragonClgRankView:unbindEvents()
	DivineGodDragonClgRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineGodDragonClgRankView:destroyUI()
	DivineGodDragonClgRankView.super.destroyUI(self)
end

function DivineGodDragonClgRankView:onEnter()
	DivineGodDragonClgRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.PM_DivineGodDragonGetRankRes, self._refreshView, self)

	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local myScore = DivineGodDragonClgModel.instance:getKillNum()

	if myScore > 0 then
		GameUtil.SetActive(self._myStepTitle, true)
		GameUtil.SetActive(self._txtMyStep, true)

		self._txtMyStep.text = langPara("%d", myScore)
	else
		GameUtil.SetActive(self._myStepTitle, false)
		GameUtil.SetActive(self._txtMyStep, false)
	end

	DivineGodDragonClgAgent.instance:sendPM_DivineGodDragonGetRankReq(self._activityId)
end

function DivineGodDragonClgRankView:onExit()
	DivineGodDragonClgRankView.super.onExit(self)
	self._rankTable:dispose()
end

function DivineGodDragonClgRankView:_refreshView()
	local list = DivineGodDragonClgModel.instance:getRankInfo(self._activityId)

	self._rankTable:reloadData(list)

	if #list > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = (DivineGodDragonClgModel.instance:getMyRank(self._activityId) > 100 or DivineGodDragonClgModel.instance:getMyRank(self._activityId) <= 0) and lang("未上榜") or DivineGodDragonClgModel.instance:getMyRank(self._activityId)
end

function DivineGodDragonClgRankView:_updateCell(view, cell, rankInfo, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")

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
	txtScore.text = langPara("%d", rankInfo.value)

	local date = GameUtil.time2date(checknumber(rankInfo.time / 1000))

	txtTime.text = langPara("%s月%s日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
end

function DivineGodDragonClgRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function DivineGodDragonClgRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return DivineGodDragonClgRankView
