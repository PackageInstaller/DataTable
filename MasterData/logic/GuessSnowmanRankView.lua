-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanRankView.lua

module("logic.extensions.guesssnowman.view.GuessSnowmanRankView", package.seeall)

local GuessSnowmanRankView = class("GuessSnowmanRankView", ViewComponent)

function GuessSnowmanRankView:ctor()
	GuessSnowmanRankView.super.ctor(self)
end

function GuessSnowmanRankView:buildUI()
	GuessSnowmanRankView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "right/rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "right/cell")
	self._emptyGo = goutil.findChild(self.mainGO, "right/goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRank")
end

function GuessSnowmanRankView:bindEvents()
	GuessSnowmanRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GuessSnowmanRankView:unbindEvents()
	GuessSnowmanRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GuessSnowmanRankView:destroyUI()
	GuessSnowmanRankView.super.destroyUI(self)
end

function GuessSnowmanRankView:onEnter()
	GuessSnowmanRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	GlobalDispatcher:addListener(GlobalNotify.GuessBoxGameRankInfo, self._refreshView, self)

	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	GuessBoxAgent.instance:sendPM_GuessBoxGameRankInfoReq(self._activityId)
end

function GuessSnowmanRankView:onExit()
	GuessSnowmanRankView.super.onExit(self)
	self._rankTable:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.GuessBoxGameRankInfo, self._refreshView, self)
end

function GuessSnowmanRankView:_refreshView()
	self._rankTable:reloadData(GuessBoxModel.instance:getRankInfo())

	if #GuessBoxModel.instance:getRankInfo() > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = (GuessBoxModel.instance:getMyRank() > 100 or GuessBoxModel.instance:getMyRank() <= 0) and lang("未上榜") or GuessBoxModel.instance:getMyRank()
end

function GuessSnowmanRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
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
	txtArea.text = data.headInfo.areaName or ""
	txtScore.text = data.score

	local date = GameUtil.time2date(checknumber(data.time / 1000))

	txtTime.text = langPara("%s月%s日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)
end

function GuessSnowmanRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function GuessSnowmanRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return GuessSnowmanRankView
