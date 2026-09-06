-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/emperorsubdue/view/EmperorSubdueRankView.lua

module("logic.extensions.emperorsubdue.view.EmperorSubdueRankView", package.seeall)

local EmperorSubdueRankView = class("EmperorSubdueRankView", ViewComponent)

function EmperorSubdueRankView:ctor()
	EmperorSubdueRankView.super.ctor(self)
end

function EmperorSubdueRankView:unbindEvents()
	EmperorSubdueRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function EmperorSubdueRankView:bindEvents()
	EmperorSubdueRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function EmperorSubdueRankView:buildUI()
	EmperorSubdueRankView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._ranktableGo = goutil.findChild(self.mainGO, "rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "cell")
	self._rankTableList = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._txtMyScore = self:getTxt("myRank/txtMyScore")
	self._itemTableCell = self:getGo("itemTableCell")
	self._myPrizeCol = goutil.findChild(self.mainGO, "myRank/myPrizeCol")
	self._myPrizeCol_itemScrollerview = goutil.findChild(self.mainGO, "myRank/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = goutil.findChild(self.mainGO, "myRank/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	GameUtil.SetActive(self._myPrizeCol, false)
end

function EmperorSubdueRankView:onExit()
	EmperorSubdueRankView.super.onExit(self)
	self._rankTableList:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil

	self._myPrizeScrollList:dispose()
end

function EmperorSubdueRankView:onEnter()
	EmperorSubdueRankView.super.onEnter(self)

	self._itemScrollListDic = {}
	self._activityId = 547001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self.addGEvent(self, GlobalNotify.PM_EmperorSubdueRankRes, self._handleGetInfo, self)
	self:_handleGetInfo()
	EmperorSubdueController.instance:getRankList(self._activityId)
end

function EmperorSubdueRankView:_handleGetInfo()
	local myRank = -1
	local myScore = 0
	local rankInfos = {}
	local info = EmperorSubdueModel.instance:getRankInfoByActId(self._activityId)

	if info then
		myRank = info.myRank
		myScore = checknumber(info.myScore)
		rankInfos = info.infoList or {}
	end

	self._txtMyScore.text = EmperorSubdueController.instance:numberToString(myScore)

	if #rankInfos == 0 then
		GameUtil.SetActive(self._emptyGo, true)
	else
		GameUtil.SetActive(self._emptyGo, false)
	end

	self._rankTableList:reloadData(rankInfos)

	self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")

	local prizes = self:_getPrizesByRank(myRank)

	if not string.nilorempty(prizes) then
		local prizeStrArr = string.split(prizes, "#")

		self._myPrizeScrollList:reloadData(prizeStrArr)
		self._myPrizeScrollList:dragNotifyParent()
		GameUtil.SetActive(self._myPrizeCol, true)
	else
		GameUtil.SetActive(self._myPrizeCol, false)
		self._myPrizeScrollList:dispose()
	end
end

function EmperorSubdueRankView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtDate = goutil.findChildTextComponent(go, "txtDate")
	local itemListGo = goutil.findChild(go, "itemTableView")
	local rankInfo = data
	local time = rankInfo.time

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
	txtScore.text = EmperorSubdueController.instance:numberToString(checknumber(rankInfo.value))

	local date = GameUtil.time2date(time / 1000)

	txtDate.text = string.format("%02d.%02d.%02d\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)

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

function EmperorSubdueRankView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function EmperorSubdueRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function EmperorSubdueRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function EmperorSubdueRankView:_getPrizesByRank(rank)
	local data = EmperorSubdueConfig.instance:getRankPrizeDataByRank(self._activityId, rank)

	return (data or nil) and (data.prize or "")
end

return EmperorSubdueRankView
