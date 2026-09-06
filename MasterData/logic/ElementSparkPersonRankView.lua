-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkPersonRankView.lua

module("logic.extensions.elementspark.view.ElementSparkPersonRankView", package.seeall)

local ElementSparkPersonRankView = class("ElementSparkPersonRankView", ViewComponent)

function ElementSparkPersonRankView:ctor()
	ElementSparkPersonRankView.super.ctor(self)
end

function ElementSparkPersonRankView:unbindEvents()
	ElementSparkPersonRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function ElementSparkPersonRankView:bindEvents()
	ElementSparkPersonRankView.super.bindEvents(self)
end

function ElementSparkPersonRankView:buildUI()
	ElementSparkPersonRankView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._scrollRect = self:getScrollRect("tableview")
	self._cellGo = self:getGo("cell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("empty")
	self._txtMyCamp = self:getTxt("myRank/txtCamp")
	self._rank = self:getGo("myRank/rank")
	self._score = self:getGo("myRank/score")
	self._txtMyRank = self:getTxt("myRank/rank/txtMyRank")
	self._txtMyScore = self:getTxt("myRank/score/txtScore")
	self._item = self:getGo("item")
end

function ElementSparkPersonRankView:onExit()
	ElementSparkPersonRankView.super.onExit(self)
	self._tableview:dispose()

	self._rewardScroller = nil
end

function ElementSparkPersonRankView:onEnter()
	ElementSparkPersonRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetPersonRankRes, self._refresh, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._rewardScroller = {}
	self._campId = ElementSparkModel.instance:getMyCampId()

	if self._campId <= 0 then
		self:_refresh(1)
	else
		self:_refresh(self._campId)
	end
end

function ElementSparkPersonRankView:_refresh(campId)
	self._info = ElementSparkModel.instance:getPersonRankInfo()

	local isEmpty = TableUtil.isTableEmpty(self._info.rankInfos)

	self._txtMyCamp.text = ElementSparkController.instance:getMyCampName()

	GameUtil.SetActive(self._rank, campId == self._campId)
	GameUtil.SetActive(self._score, campId == self._campId)

	self._txtMyScore.text = self._info.myScore

	if checknumber(self._info.myRank) > 0 then
		self._txtMyRank.text = self._info.myRank or "未上榜"
	end

	if isEmpty then
		GameUtil.SetActive(self._tableviewGo, false)
		GameUtil.SetActive(self._empty, true)
	else
		GameUtil.SetActive(self._tableviewGo, true)
		GameUtil.SetActive(self._empty, false)
		self._tableview:reloadData(self._info.rankInfos)

		self._scrollRect.scrollRect.verticalNormalizedPosition = 1
	end
end

function ElementSparkPersonRankView:_updateCell(view, cell, data)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtArea = goutil.findChildTextComponent(cell, "txtArea")
	local head = goutil.findChild(cell, "head")
	local rewardView = goutil.findChild(cell, "rewardView")
	local rewardView = ScrollerList.create(rewardView, self._item, GameUtil.handler(self._updateRewarCell, self), GameUtil.handler(self._clearRewardCell, self))

	self._rewardScroller[cell] = rewardView

	local headInfo = data.headInfo

	txtName.text = headInfo.userName
	txtArea.text = headInfo.areaName

	local proxy = HeadItemController.instance:setHeadCellByInfo(head, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.headInfo.userId, head)
		end)
	end

	local rank = cell.index + 1
	local isTopThree = rank >= 1 and rank <= 3

	if isTopThree then
		GameUtil.setUIImageSpriteIdx(imgRank, rank - 1)
	end

	txtRank.text = rank
	txtScore.text = data.score

	GameUtil.SetActive(imgRank, isTopThree)
	GameUtil.SetActive(txtRank, not isTopThree)

	local prizeCfg = ElementSparkConfig.instance:getPersonPrizeByRank(self._activityId, rank)
	local prizeData = string.split(prizeCfg, "#")

	if prizeData then
		rewardView:reloadData(prizeData)
	end

	rewardView:dragNotifyParent()
end

function ElementSparkPersonRankView:_clearCell(cell)
	if self._rewardScroller[cell] then
		self._rewardScroller[cell]:dispose()
	end
end

function ElementSparkPersonRankView:_updateRewarCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function ElementSparkPersonRankView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

return ElementSparkPersonRankView
