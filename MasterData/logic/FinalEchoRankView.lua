-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/view/FinalEchoRankView.lua

module("logic.extensions.finalecho.view.FinalEchoRankView", package.seeall)

local FinalEchoRankView = class("FinalEchoRankView", ViewComponent)

function FinalEchoRankView:ctor()
	FinalEchoRankView.super.ctor(self)
end

function FinalEchoRankView:unbindEvents()
	FinalEchoRankView.super.unbindEvents(self)
end

function FinalEchoRankView:bindEvents()
	FinalEchoRankView.super.bindEvents(self)
end

function FinalEchoRankView:buildUI()
	FinalEchoRankView.super.buildUI(self)

	self._ranktableGo = goutil.findChild(self.mainGO, "rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "cell")
	self._rankTableList = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._txtMyScore = self:getTxt("myRank/txtMyScore")
	self._itemTableCell = self:getGo("itemTableCell")
	self._myTitle1 = self:getGo("myRank/myTitle1")
	self._myTitle2 = self:getGo("myRank/myTitle2")
	self._txtScore1 = self:getGo("subTitle/txtScore1")
	self._txtScore2 = self:getGo("subTitle/txtScore2")
	self._myPrizeCol = goutil.findChild(self.mainGO, "myRank/myPrizeCol")
	self._myPrizeCol_itemScrollerview = goutil.findChild(self.mainGO, "myRank/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = goutil.findChild(self.mainGO, "myRank/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	GameUtil.SetActive(self._myPrizeCol, false)
end

function FinalEchoRankView:onExit()
	FinalEchoRankView.super.onExit(self)
	self._rankTableList:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil

	self._myPrizeScrollList:dispose()
end

function FinalEchoRankView:onEnter()
	FinalEchoRankView.super.onEnter(self)

	self._itemScrollListDic = {}

	local params = self:getOpenParam()

	self._typeId = checknumber(params[1])
	self._activityId = checknumber(params[2])

	self.addGEvent(self, GlobalNotify.FinalEchoGetRankInfo, self._handleGetInfo, self)
	self.addGEvent(self, GlobalNotify.StarHallGetRankInfo, self._handleGetInfo, self)
	self:_handleGetInfo()

	if self._typeId == 1 then
		StarHallController.instance:getRankInfo(self._activityId)
	elseif self._typeId == 2 then
		FinalEchoController.instance:getRankInfo(self._activityId)
	end
end

function FinalEchoRankView:_handleGetInfo()
	goutil.setActive(self._myTitle1, false)
	goutil.setActive(self._myTitle2, false)
	goutil.setActive(self._txtScore1, false)
	goutil.setActive(self._txtScore2, false)

	local myRank = -1
	local myScore = 0
	local rankInfos = {}

	if self._typeId == 1 then
		goutil.setActive(self._txtScore1, true)

		local info = StarHallModel.instance:getRankInfo(self._activityId)

		if info then
			rankInfos = info.rankInfos or {}
			myRank = info.myRank
			myScore = 0
		end
	elseif self._typeId == 2 then
		goutil.setActive(self._txtScore2, true)

		local info = FinalEchoModel.instance:getRankInfo(self._activityId)

		if info then
			rankInfos = info.rankInfos or {}
			myRank = info.myRank
			myScore = checknumber(info.historyBestDamage)
		end
	end

	self._rankTableList:reloadData(rankInfos)

	self._txtMyScore.text = myScore

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

function FinalEchoRankView:_updateCell(view, cell, data, tag)
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
	txtScore.text = rankInfo.value

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

function FinalEchoRankView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function FinalEchoRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function FinalEchoRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function FinalEchoRankView:_getPrizesByRank(rank)
	if self._typeId == 1 then
		local data = StarHallConfig.instance:getRankPrizeDataByRank(self._activityId, rank)

		return data and data.prize
	elseif self._typeId == 2 then
		local data = FinalEchoConfig.instance:getRankPrizeDataByRank(self._activityId, rank)

		return data and data.prize
	end

	return ""
end

return FinalEchoRankView
