-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingRankView.lua

module("logic.extensions.survivalking.view.SurvivalKingRankView", package.seeall)

local SurvivalKingRankView = class("SurvivalKingRankView", ViewComponent)

function SurvivalKingRankView:ctor()
	SurvivalKingRankView.super.ctor(self)
end

function SurvivalKingRankView:unbindEvents()
	SurvivalKingRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function SurvivalKingRankView:bindEvents()
	SurvivalKingRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function SurvivalKingRankView:buildUI()
	SurvivalKingRankView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")

	local goCellRank = self:getGo("cell")
	local goTableViewRank = self:getGo("rankScrollRect")

	self._tableViewRank = ScrollerList.create(goTableViewRank, goCellRank, GameUtil.handler(self._updateCellRank, self), GameUtil.handler(self._clearCellRank, self))
	self._itemTableCell = self:getGo("itemTableCell")
	self._goEmpty = self:getGo("goEmpty")
	self._txtMyTime = self:getTxt("myRank/txtMyTime")
	self._txtMyWinTime = self:getTxt("myRank/txtMyWinTime")
	self._txtMyRank = self:getTxt("myRank/txtMyRank")
	self._txtScore = self:getTxt("content/myRank/txtScore")
end

function SurvivalKingRankView:onExit()
	SurvivalKingRankView.super.onExit(self)
	self._tableViewRank:dispose()
end

function SurvivalKingRankView:onEnter()
	SurvivalKingRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingRankInfo, self._handleGetInfo, self)

	self._itemScrollListDic = {}

	local params = self:getOpenParam()

	self._activityId = 529001

	if params then
		self._activityId = checknumber(params[1])
	end

	SurvivalKingController.instance:getRankInfo(self._activityId)
	self:_handleGetInfo()
end

function SurvivalKingRankView:_handleGetInfo()
	local myRank = -1
	local myWinTimes = 0
	local myFightTimes = 0
	local rankInfos = {}
	local info = SurvivalKingModel.instance:getRankInfo(self._activityId)

	if info then
		rankInfos = info.rankItems or {}
		myRank = info.myRank or -1
		myWinTimes = info.myWinTimes or 0
		myFightTimes = info.myFightTimes or 0
	end

	self._tableViewRank:reloadData(rankInfos)

	if #rankInfos > 0 then
		GameUtil.SetActive(self._goEmpty, false)
	else
		GameUtil.SetActive(self._goEmpty, true)
	end

	self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")
	self._txtMyTime.text = myFightTimes
	self._txtMyWinTime.text = myWinTimes
end

function SurvivalKingRankView:_updateCellRank(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local txtWinTime = goutil.findChildTextComponent(go, "txtWinTime")
	local itemListGo = goutil.findChild(go, "itemTableView")
	local rankInfo = data

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

	HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName
	txtTime.text = rankInfo.fightTimes or 0
	txtWinTime.text = rankInfo.winTimes or 0

	local prizes = self:_getPrizesByRank(rankInfo.rank)

	if itemListGo and self._itemTableCell then
		if not self._itemScrollListDic[go] then
			local prizeScrollList = ScrollerList.create(itemListGo, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			local prizeStrArr = string.split(prizes, "#")

			self._itemScrollListDic[go]:reloadData(prizeStrArr)
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	end
end

function SurvivalKingRankView:_clearCellRank(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function SurvivalKingRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function SurvivalKingRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function SurvivalKingRankView:_getPrizesByRank(rank)
	local data = SurvivalKingConfig.instance:getRankPrizeDataByRank(self._activityId, rank)

	return (data or nil) and (data.prize or "")
end

return SurvivalKingRankView
