-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkgame/view/LinkGameRankView.lua

module("logic.extensions.linkgame.view.LinkGameRankView", package.seeall)

local LinkGameRankView = class("LinkGameRankView", ViewComponent)

function LinkGameRankView:ctor()
	LinkGameRankView.super.ctor(self)
end

function LinkGameRankView:buildUI()
	LinkGameRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "right/rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "right/cell")
	self._emptyGo = goutil.findChild(self.mainGO, "right/goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRank")
	self._myStepTitle = self:getGo("right/myRank/txtMyStepTitle")
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
end

function LinkGameRankView:bindEvents()
	LinkGameRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function LinkGameRankView:unbindEvents()
	LinkGameRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function LinkGameRankView:destroyUI()
	LinkGameRankView.super.destroyUI(self)
end

function LinkGameRankView:onEnter()
	LinkGameRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.handlePM_LinkGameRankRes, self._refreshView, self)

	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	LinkGameAgent.instance:sendPM_LinkGameRankReq(self._activityId)

	local myStep = checknumber(LinkGameModel.instance:getMyTotalStep())

	GameUtil.SetActive(self._myStepTitle, myStep > 0)
	GameUtil.SetActive(self._txtMyStep, myStep > 0)

	self._txtMyStep.text = myStep
end

function LinkGameRankView:onExit()
	LinkGameRankView.super.onExit(self)
	self._rankTable:dispose()
end

function LinkGameRankView:_refreshView()
	self._rankTable:reloadData(LinkGameModel.instance:getRankInfo())

	if #LinkGameModel.instance:getRankInfo() > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = (LinkGameModel.instance:getMyRank() > 100 or LinkGameModel.instance:getMyRank() <= 0) and lang("未上榜") or LinkGameModel.instance:getMyRank()
end

function LinkGameRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")

	txtRank.text = data.rank

	GameUtil.SetActive(imgChangeRank, data.rank <= 3 and data.rank > 0)

	if data.rank <= 3 and data.rank > 0 then
		imgChangeRank:SetState(data.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgIcon)
			end
		end)
	end

	txtName.text = data.headInfo.userName
	txtScore.text = data.value

	local date = GameUtil.time2date(checknumber(data.time / 1000))

	txtTime.text = langPara("%s月%s日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
end

function LinkGameRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function LinkGameRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return LinkGameRankView
