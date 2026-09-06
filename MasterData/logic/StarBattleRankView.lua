-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleRankView.lua

module("logic.extensions.starbattle.view.StarBattleRankView", package.seeall)

local StarBattleRankView = class("StarBattleRankView", ViewComponent)

function StarBattleRankView:ctor()
	StarBattleRankView.super.ctor(self)
end

function StarBattleRankView:unbindEvents()
	StarBattleRankView.super.unbindEvents(self)
end

function StarBattleRankView:bindEvents()
	StarBattleRankView.super.bindEvents(self)
end

function StarBattleRankView:buildUI()
	StarBattleRankView.super.buildUI(self)

	self._ranktableGo = goutil.findChild(self.mainGO, "rankScrollRect")
	self._ranktableCell = goutil.findChild(self.mainGO, "cell")
	self._rankTableList = ScrollerList.create(self._ranktableGo, self._ranktableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = goutil.findChild(self.mainGO, "goEmpty")
	self._txtMyRank = goutil.findChildTextComponent(self.mainGO, "myRank/txtMyRank")
	self._txtMyScore = self:getTxt("myRank/txtMyScore")
	self._myTitle1 = self:getGo("myRank/myTitle1")
	self._itemTableCell = self:getGo("itemTableCell")
	self._myPrizeCol = goutil.findChild(self.mainGO, "myRank/myPrizeCol")
	self._myPrizeCol_itemScrollerview = goutil.findChild(self.mainGO, "myRank/myPrizeCol/itemScrollerview")
	self._myPrizeCol_itemScrollercell = goutil.findChild(self.mainGO, "myRank/myPrizeCol/itemScrollercell")
	self._myPrizeScrollList = ScrollerList.create(self._myPrizeCol_itemScrollerview, self._myPrizeCol_itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	GameUtil.SetActive(self._myPrizeCol, false)
end

function StarBattleRankView:onExit()
	StarBattleRankView.super.onExit(self)
	self._rankTableList:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil

	self._myPrizeScrollList:dispose()
end

function StarBattleRankView:onEnter()
	StarBattleRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_StarBattleGetRankView, self._handleGetInfo, self)

	self._itemScrollListDic = {}

	local params = self:getOpenParam()

	self._typeId = 1
	self._activityId = 510001
	self._periodId = 1
	self._rankPlanId = 1

	if params then
		if params[1] then
			self._activityId = checknumber(params[1])
		end

		if params[2] then
			self._typeId = checknumber(params[2])
		end

		self._periodId = StarBattleController.instance:getCurrentPeriodId(self._activityId)

		local periodCfg = StarBattleConfig.instance:getPeriodCfg(self._activityId, self._periodId)

		if periodCfg then
			if self._typeId == 1 then
				self._rankPlanId = periodCfg.oldRankPlanId or 1
			elseif self._typeId == 2 then
				self._rankPlanId = periodCfg.newRankPlanId or 1
			end
		end
	end

	StarBattleController.instance:getRankView(self._activityId, self._typeId, self._periodId)
	self:_handleGetInfo()
end

function StarBattleRankView:_handleGetInfo()
	local isNewHand = false
	local baseInfo = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if baseInfo then
		isNewHand = baseInfo.isBeginner
	end

	local myRank = -1
	local myScore = 0
	local rankInfos = {}
	local info = StarBattleModel.instance:getRankInfo(self._activityId, self._periodId, self._typeId)

	if info then
		rankInfos = info.infoList or {}
		myRank = info.myRank or -1
		myScore = info.myScore
	end

	self._rankTableList:reloadData(rankInfos)

	if isNewHand and self._typeId == 2 then
		goutil.setActive(self._myTitle1, false)

		self._txtMyScore.text = ""
	elseif not isNewHand and self._typeId == 1 then
		goutil.setActive(self._myTitle1, false)

		self._txtMyScore.text = ""
	else
		goutil.setActive(self._myTitle1, true)

		self._txtMyScore.text = myScore
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

function StarBattleRankView:_updateCell(view, cell, data, tag)
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

function StarBattleRankView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function StarBattleRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function StarBattleRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function StarBattleRankView:_getPrizesByRank(rank)
	local data = StarBattleConfig.instance:getRankPrizeCfgByRank(self._rankPlanId, rank)

	return (data or nil) and (data.prize or "")
end

return StarBattleRankView
