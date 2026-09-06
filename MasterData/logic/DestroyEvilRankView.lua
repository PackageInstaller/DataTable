-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilRankView.lua

module("logic.extensions.destroyevil.view.DestroyEvilRankView", package.seeall)

local DestroyEvilRankView = class("DestroyEvilRankView", ViewComponent)

function DestroyEvilRankView:ctor()
	DestroyEvilRankView.super.ctor(self)
end

function DestroyEvilRankView:buildUI()
	DestroyEvilRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._ranktableGo = self:getGo("rankCol/rankScrollerview")
	self._ranktableCell = self:getGo("rankCol/rankScrollercell")
	self._emptyGo = self:getGo("rankCol/emptyGo")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
end

function DestroyEvilRankView:bindEvents()
	DestroyEvilRankView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DestroyEvilRankView:unbindEvents()
	DestroyEvilRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DestroyEvilRankView:onEnter()
	DestroyEvilRankView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self.addGEvent(self, GlobalNotify.DestroyEvilViewHelpRankRes, self._refreshView, self)

	self._rankTable = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	DestroyEvilAgent.instance:sendPM_DestroyEvilViewHelpRankReq(self._activityId)
end

function DestroyEvilRankView:onExit()
	DestroyEvilRankView.super.onExit(self)
	self._rankTable:dispose()
end

function DestroyEvilRankView:_refreshView()
	local list = DestroyEvilModel.instance:getRankInfos()

	self._rankTable:reloadData(list)

	if #list > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

	self._txtMyRank.text = (DestroyEvilModel.instance:getMyRank() > 100 or DestroyEvilModel.instance:getMyRank() <= 0) and lang("未上榜") or DestroyEvilModel.instance:getMyRank()
end

function DestroyEvilRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgIcon")
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
	txtScore.text = data.helpCount
	txtTime.text = data.helpTotalDamage
end

function DestroyEvilRankView:_clearCell(cell)
	local go = cell.gameObject

	HeadItemController.instance:resetHeadCell(go)
end

function DestroyEvilRankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return DestroyEvilRankView
