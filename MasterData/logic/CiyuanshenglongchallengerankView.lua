-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/view/CiyuanshenglongchallengerankView.lua

module("logic.extensions.ciyuanshenglong.view.CiyuanshenglongchallengerankView", package.seeall)

local CiyuanshenglongchallengerankView = class("CiyuanshenglongchallengerankView", ViewComponent)

function CiyuanshenglongchallengerankView:ctor()
	CiyuanshenglongchallengerankView.super.ctor(self)
end

function CiyuanshenglongchallengerankView:unbindEvents()
	CiyuanshenglongchallengerankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CiyuanshenglongchallengerankView:bindEvents()
	CiyuanshenglongchallengerankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CiyuanshenglongchallengerankView:buildUI()
	CiyuanshenglongchallengerankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._empty = self:getGo("empty")
	self._myRank = self:getGo("myRank")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtTip = self:getTxt("myRank/txtTip")

	local tabcell = self:getGo("tabcell")
	local tabview = self:getGo("tabview")

	self._tabScrollList = ScrollerList.create(tabview, tabcell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self.clearTabCell, self))

	local cell = self:getGo("cell")
	local tableview = self:getGo("tableview")

	self._scrollList = ScrollerList.create(tableview, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function CiyuanshenglongchallengerankView:onExit()
	CiyuanshenglongchallengerankView.super.onExit(self)
	self._scrollList:dispose()
	self._tabScrollList:dispose()
end

function CiyuanshenglongchallengerankView:onEnter()
	CiyuanshenglongchallengerankView.super.onEnter(self)

	local param = self:getOpenParam() or {}

	self._activityId = param[1]
	self._curIndex = CiyuanshenglongModel.instance.rankIndex

	if self._curIndex == nil then
		self._curIndex = CiyuanshenglongModel.TAB_HISTORY
	end

	local list = {}

	table.insert(list, lang("历史排行"))
	table.insert(list, lang("每日排行"))
	self._tabScrollList:reloadData(list)
	self.addGEvent(self, GlobalNotify.CIYUANSHENGLONG_RANK_UPDATE, self._refreshUI, self)
	self:_refreshUI()
	self:_sendMsg()
end

function CiyuanshenglongchallengerankView:_sendMsg()
	if self._curIndex == CiyuanshenglongModel.TAB_HISTORY then
		CiyuanshenglongController.instance:sendPM_CiYuanHolyDragonClgGetHistoryRankReq(self._activityId)
	else
		CiyuanshenglongController.instance:sendPM_CiYuanHolyDragonClgGetDailyRankReq(self._activityId)
	end
end

function CiyuanshenglongchallengerankView:_refreshUI()
	local info = {}

	if self._curIndex == CiyuanshenglongModel.TAB_HISTORY then
		info = CiyuanshenglongModel.instance.historyRankInfo or {}
		self._txtTip.text = CiyuanshenglongConfig.instance:getCommonValue("RANK_CHALLENGE")
	else
		info = CiyuanshenglongModel.instance.todyRankInfo or {}
		self._txtTip.text = CiyuanshenglongConfig.instance:getCommonValue("RANK")
	end

	if not info.rankInfos then
		local list = {}

		self._scrollList:reloadData(list)

		self._txtMyRank.text = checknumber(info.myRank) > 0 and checknumber(info.myRank) or "未上榜"

		GameUtil.SetActive(self._empty, #list == 0)
	end
end

function CiyuanshenglongchallengerankView:_updateCell(view, cell, data, tag)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local head = goutil.findChild(cell, "head")
	local btnHead = goutil.findChild(cell, "btnHead")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	txtArea.text = data.headInfo.areaName
	txtScore.text = data.value
	txtRank.text = data.rank

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		GameUtil.setUIImageSpriteIdx(imgRank, rank - 1)
	end

	if data.headInfo.userId then
		GameUtil.addClickHandler(btnHead, GameUtil.handler(self.onHeadClick, self, data.headInfo.userId, btnHead))
	end

	local time = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = langPara("text_timeinfo", time.month, time.day, time.hour, time.min, time.sec)
end

function CiyuanshenglongchallengerankView:clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)
end

function CiyuanshenglongchallengerankView:_updateTabCell(view, cell, data, tag)
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	txtName.text = data

	GameUtil.SetActive(imgSelected, cell.data == self._curIndex)
	GameUtil.setUITextColorIdx(txtName, cell.data == self._curIndex and 0 or 1)
	GameUtil.addClickHandler(cell, function()
		self._curIndex = cell.data
		CiyuanshenglongModel.instance.rankIndex = self._curIndex

		self._tabScrollList:refresh()
		self:_sendMsg()
	end)
end

function CiyuanshenglongchallengerankView:clearTabCell(cell)
	return
end

function CiyuanshenglongchallengerankView:onHeadClick(userId, go)
	FriendController.instance:showInfoView(userId, go)
end

return CiyuanshenglongchallengerankView
