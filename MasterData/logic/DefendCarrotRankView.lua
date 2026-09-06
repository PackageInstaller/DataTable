-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/view/DefendCarrotRankView.lua

module("logic.extensions.defendcarrot.view.DefendCarrotRankView", package.seeall)

local DefendCarrotRankView = class("DefendCarrotRankView", ViewComponent)

function DefendCarrotRankView:ctor()
	DefendCarrotRankView.super.ctor(self)
end

function DefendCarrotRankView:unbindEvents()
	DefendCarrotRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DefendCarrotRankView:bindEvents()
	DefendCarrotRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DefendCarrotRankView:buildUI()
	DefendCarrotRankView.super.buildUI(self)

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

	self._btnClose = self:getGo("leftTop/btnClose")
end

function DefendCarrotRankView:onExit()
	DefendCarrotRankView.super.onExit(self)
	self._rankTableList:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil

	self._myPrizeScrollList:dispose()
end

function DefendCarrotRankView:onEnter()
	DefendCarrotRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DefendCarrotRankInfo, self._handleGetInfo, self)

	self._itemScrollListDic = {}

	local params = self:getOpenParam()

	self._activityId = 517001
	self._periodId = 1

	if params then
		self._activityId = checknumber(params[1])
	end

	DefendCarrotController.instance:getRankInfo(self._activityId)
	self:_handleGetInfo()
end

function DefendCarrotRankView:_handleGetInfo()
	local myRank = -1
	local myDate = -1
	local rankInfos = {}
	local info = DefendCarrotModel.instance:getRankInfo(self._activityId)

	if info then
		rankInfos = info.rankInfos or {}
		myRank = info.myRank or -1
	end

	local baseInfo = DefendCarrotModel.instance:getBaseInfo(self._activityId)

	if baseInfo then
		myDate = checknumber(baseInfo.stageFinishTime)
	end

	self._rankTableList:reloadData(rankInfos)

	if myDate > 0 then
		local date = GameUtil.time2date(myDate / 1000)

		self._txtMyScore.text = string.format("%02d.%02d.%02d %02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	else
		self._txtMyScore.text = lang("未上榜")
	end

	if #rankInfos > 0 then
		GameUtil.SetActive(self._emptyGo, false)
	else
		GameUtil.SetActive(self._emptyGo, true)
	end

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

function DefendCarrotRankView:_updateCell(view, cell, data, tag)
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
	txtScore.text = ""

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

function DefendCarrotRankView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function DefendCarrotRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function DefendCarrotRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function DefendCarrotRankView:_getPrizesByRank(rank)
	local data = DefendCarrotConfig.instance:getRankPrizeDataByRank(self._activityId, rank)

	return (data or nil) and (data.prize or "")
end

return DefendCarrotRankView
