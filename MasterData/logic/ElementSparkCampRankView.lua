-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkCampRankView.lua

module("logic.extensions.elementspark.view.ElementSparkCampRankView", package.seeall)

local ElementSparkCampRankView = class("ElementSparkCampRankView", ViewComponent)

function ElementSparkCampRankView:ctor()
	ElementSparkCampRankView.super.ctor(self)
end

function ElementSparkCampRankView:unbindEvents()
	ElementSparkCampRankView.super.unbindEvents(self)
end

function ElementSparkCampRankView:bindEvents()
	ElementSparkCampRankView.super.bindEvents(self)
end

function ElementSparkCampRankView:buildUI()
	ElementSparkCampRankView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._scrollRect = self:getScrollRect("tableview")
	self._rankCell = self:getGo("cell")
	self._tableview = ScrollerList.create(self._tableviewGo, self._rankCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._empty = self:getGo("empty")
	self._txtMyCamp = self:getTxt("myRank/txtCamp")
	self._item = self:getGo("item")
end

function ElementSparkCampRankView:onExit()
	ElementSparkCampRankView.super.onExit(self)
	self._tableview:dispose()
end

function ElementSparkCampRankView:onEnter()
	ElementSparkCampRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetCampRankRes, self._refresh, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._rewardScroller = {}
	self._personRewardScroller = {}

	self:_refresh()
	self:_sendInfoReq()
end

function ElementSparkCampRankView:_sendInfoReq()
	ElementSparkController.instance:sendPM_EleSparkGetCampRankReq(self._activityId)
end

function ElementSparkCampRankView:_refresh()
	local info = ElementSparkModel.instance:getCampRankInfo()
	local isEmpty = TableUtil.isTableEmpty(info)

	self._txtMyCamp.text = ElementSparkController.instance:getMyCampName()

	if isEmpty then
		GameUtil.SetActive(self._tableviewGo, false)
		GameUtil.SetActive(self._empty, true)
	else
		GameUtil.SetActive(self._tableviewGo, true)
		GameUtil.SetActive(self._empty, false)
		self._tableview:reloadData(info)

		self._scrollRect.scrollRect.verticalNormalizedPosition = 1
	end
end

function ElementSparkCampRankView:_updateCell(view, cell, data)
	local imgRank = goutil.findChild(cell, "imgRank")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local rewardViewGo = goutil.findChild(cell, "rewardView")
	local leaderViewGo = goutil.findChild(cell, "leaderRewardView")
	local rewardView, leaderView

	if self._rewardScroller[cell] == nil then
		self._rewardScroller[cell] = {}
		rewardView = ScrollerList.create(rewardViewGo, self._item, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		rewardView:dragNotifyParent()

		leaderView = ScrollerList.create(leaderViewGo, self._item, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		leaderView:dragNotifyParent()

		self._rewardScroller[cell][rewardViewGo] = rewardView
		self._rewardScroller[cell][leaderViewGo] = leaderView
	else
		rewardView = self._rewardScroller[cell][rewardViewGo]
		leaderView = self._rewardScroller[cell][leaderViewGo]
	end

	local rank = cell.index + 1
	local isTopThree = rank >= 1 and rank <= 3

	if isTopThree then
		GameUtil.setUIImageSpriteIdx(imgRank, rank - 1)
	end

	txtRank.text = rank
	txtScore.text = data.score
	txtName.text = ElementSparkController.instance:getCampNameById(data.campId)

	GameUtil.SetActive(imgRank, isTopThree)
	GameUtil.SetActive(txtRank, not isTopThree)

	local leaderPrize, prize = ElementSparkConfig.instance:getCampPrizeByRank(self._activityId, rank)
	local leaderPrizeCfg, prizeCfg = string.split(leaderPrize, "#"), string.split(prize, "#")

	if prizeCfg then
		rewardView:reloadData(prizeCfg)
	end

	if leaderPrizeCfg then
		leaderView:reloadData(leaderPrizeCfg)
	end
end

function ElementSparkCampRankView:_clearCell(cell)
	if self._rewardScroller[cell] then
		for _, view in ipairs(self._rewardScroller[cell]) do
			view:dispose()
		end
	end
end

function ElementSparkCampRankView:_updatePrizeCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function ElementSparkCampRankView:_clearPrizeCell(cell)
	MaterialMgr.resetAll(cell)
end

return ElementSparkCampRankView
