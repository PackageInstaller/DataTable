-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofjieshen/view/HeartofjieshenrankView.lua

module("logic.extensions.heartofjieshen.view.HeartofjieshenrankView", package.seeall)

local HeartofjieshenrankView = class("HeartofjieshenrankView", ViewComponent)

function HeartofjieshenrankView:ctor()
	HeartofjieshenrankView.super.ctor(self)
end

function HeartofjieshenrankView:unbindEvents()
	HeartofjieshenrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function HeartofjieshenrankView:bindEvents()
	HeartofjieshenrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function HeartofjieshenrankView:buildUI()
	HeartofjieshenrankView.super.buildUI(self)

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
	self._scrollerHandlers = {}
	self._txtReward = self:getTxt("title/txtReward")
end

function HeartofjieshenrankView:onExit()
	HeartofjieshenrankView.super.onExit(self)
	self._scrollList:dispose()
	self._tabScrollList:dispose()
end

function HeartofjieshenrankView:onEnter()
	HeartofjieshenrankView.super.onEnter(self)

	local param = self:getOpenParam() or {}

	self._activityId = param[1]
	self._curIndex = HeartofjieshenModel.instance.rankIndex

	if self._curIndex == nil then
		self._curIndex = HeartofjieshenModel.TAB_TODAY
	end

	local list = {}

	table.insert(list, lang("每日排行"))
	table.insert(list, lang("历史排行"))
	self._tabScrollList:reloadData(list)
	self.addGEvent(self, GlobalNotify.HeartOfJieShenClgGetDailyRankRes, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.HeartOfJieShenClgGetHistoryRankRes, self._refreshUI, self)
	self:_refreshUI()
	self:_sendMsg()
end

function HeartofjieshenrankView:_sendMsg()
	if self._curIndex == HeartofjieshenModel.TAB_HISTORY then
		HeartOfJieShenClgAgent.instance:sendPM_HeartOfJieShenClgGetHistoryRankReq(self._activityId)
	else
		HeartOfJieShenClgAgent.instance:sendPM_HeartOfJieShenClgGetDailyRankReq(self._activityId)
	end
end

function HeartofjieshenrankView:_refreshUI()
	local info = {}

	if self._curIndex == HeartofjieshenModel.TAB_HISTORY then
		local msg = HeartofjieshenModel.instance:getHistoryRankMsg(self._activityId)

		info = msg or {}
		self._txtTip.text = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "rank_challenge")
	else
		local msg = HeartofjieshenModel.instance:getDailyRankMsg(self._activityId)

		info = msg or {}
		self._txtTip.text = HeartofjieshenConfig.instance:getCommonValue(self._activityId, "rank")
	end

	self._prizeStrList = {}

	if self._curIndex == HeartofjieshenModel.TAB_TODAY then
		local actCfg = HeartofjieshenConfig.instance:getActCfg(self._activityId)

		self._prizeStrList = string.split(actCfg.dailyRankPrize, "#")
	end

	if not info.rankInfos then
		local list = {}

		self._scrollList:reloadData(list)

		self._txtMyRank.text = checknumber(info.myRank) > 0 and checknumber(info.myRank) or "未上榜"

		GameUtil.SetActive(self._empty, #list == 0)

		self._txtReward.text = self._curIndex == HeartofjieshenModel.TAB_TODAY and "奖励" or "区服"
	end
end

function HeartofjieshenrankView:_updateCell(view, cell, data, tag)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local head = goutil.findChild(cell, "head")
	local btnHead = goutil.findChild(cell, "btnHead")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDamage = goutil.findChildTextComponent(cell, "txtDamage")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local scroll = self._scrollerHandlers[cell]
	local prizeStrList

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	txtDamage.text = data.value
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
	txtArea.text = self._curIndex == HeartofjieshenModel.TAB_TODAY and "" or data.headInfo.areaName

	if not scroll then
		scroll = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollerHandlers[cell] = scroll
	end

	scroll:reloadData(self._prizeStrList)
end

function HeartofjieshenrankView:_updateRewardCell(view, cell, cfgStr, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(cfgStr, cell.gameObject)
end

function HeartofjieshenrankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function HeartofjieshenrankView:clearCell(cell)
	local head = goutil.findChild(cell, "head")

	HeadItemController.instance:resetHeadCell(head)

	if self._scrollerHandlers[cell] then
		self._scrollerHandlers[cell]:dispose()
	end
end

function HeartofjieshenrankView:_updateTabCell(view, cell, data, tag)
	local imgSelected = goutil.findChild(cell, "imgSelected")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	txtName.text = data

	GameUtil.SetActive(imgSelected, cell.data == self._curIndex)
	GameUtil.setUITextColorIdx(txtName, cell.data == self._curIndex and 0 or 1)
	GameUtil.addClickHandler(cell, function()
		self._curIndex = cell.data
		HeartofjieshenModel.instance.rankIndex = self._curIndex

		self._tabScrollList:refresh()
		self:_sendMsg()
	end)
end

function HeartofjieshenrankView:clearTabCell(cell)
	return
end

function HeartofjieshenrankView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

return HeartofjieshenrankView
