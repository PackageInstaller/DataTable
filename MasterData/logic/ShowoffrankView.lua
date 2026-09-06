-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showoff/view/ShowoffrankView.lua

module("logic.extensions.showoff.view.ShowoffrankView", package.seeall)

local ShowoffrankView = class("ShowoffrankView", ViewComponent)

function ShowoffrankView:ctor()
	ShowoffrankView.super.ctor(self)
end

function ShowoffrankView:unbindEvents()
	ShowoffrankView.super.unbindEvents(self)
end

function ShowoffrankView:bindEvents()
	ShowoffrankView.super.bindEvents(self)
end

function ShowoffrankView:buildUI()
	ShowoffrankView.super.buildUI(self)

	self._emptyGo = self:getGo("emptyGo")
	self._txtTip = self:getTxt("tipsCol/txtTip")
	self._txtMyCount = self:getTxt("tipsCol/txtMyCount")
	self._txtMyRank = self:getTxt("tipsCol/txtMyRank")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ShowoffrankView:onExit()
	ShowoffrankView.super.onExit(self)
	self._scrollList:dispose()
end

function ShowoffrankView:onEnter()
	ShowoffrankView.super.onEnter(self)

	self._cfg = self:getFirstParam()

	if self._cfg then
		self.addGEvent(self, GlobalNotify.SHOW_OFF_RANK_INFO_UPDATE, self._refreshUI, self)
		ShowOffRankController.instance:sendGetRankInfo(self._cfg.rankId, self._cfg.memberId)
		self:_refreshUI()

		self._txtTip.text = self._cfg.desc
	end
end

function ShowoffrankView:_refreshUI()
	local info = ShowOffRankModel.instance:getRankInfo(self._cfg.rankId, self._cfg.memberId) or {}

	if not info.infoList then
		local infoList = {}

		GameUtil.SetActive(self._emptyGo, #infoList == 0)
		self._scrollList:reloadData(infoList)

		self._txtMyCount.text = checknumber(info.myValue)

		local rank = checknumber(info.myRank)

		self._txtMyRank.text = rank <= 0 and lang("???") or rank
	end
end

function ShowoffrankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local head = goutil.findChild(go, "head")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local txtScore = goutil.findChildTextComponent(go, "txtCount")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local rankInfo = data

	txtRank.text = rankInfo.rank

	GameUtil.SetActive(imgChangeRank, false)
	GameUtil.SetActive(txtRank, true)

	local proxy = HeadItemController.instance:setHeadCellByInfo(head, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName
	txtScore.text = rankInfo.value
	txtArea.text = rankInfo.headInfo.areaName

	local date = GameUtil.time2date(checknumber(rankInfo.time) / 1000)

	txtTime.text = langPara("%s.%02d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
end

function ShowoffrankView:_clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)
end

return ShowoffrankView
