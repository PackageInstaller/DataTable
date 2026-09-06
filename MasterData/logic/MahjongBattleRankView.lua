-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleRankView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleRankView", package.seeall)

local MahjongBattleRankView = class("MahjongBattleRankView", ViewComponent)

function MahjongBattleRankView:ctor()
	MahjongBattleRankView.super.ctor(self)
end

function MahjongBattleRankView:unbindEvents()
	MahjongBattleRankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MahjongBattleRankView:bindEvents()
	MahjongBattleRankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MahjongBattleRankView:buildUI()
	MahjongBattleRankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local goCellRank = self:getGo("content/rankcell")
	local goTableViewRank = self:getGo("content/rankview")

	self._tableViewRank = ScrollerList.create(goTableViewRank, goCellRank, GameUtil.handler(self._updateCellRank, self), GameUtil.handler(self._clearCellRank, self))
	self._goEmpty = self:getGo("content/goEmpty")
	self._txtMyRank = self:getTxt("content/myRank/txtMyRank")
	self._item = self:getGo("item")

	goutil.setActive(self._item, false)
end

function MahjongBattleRankView:onExit()
	MahjongBattleRankView.super.onExit(self)
	self._tableViewRank:dispose()
end

function MahjongBattleRankView:onEnter()
	MahjongBattleRankView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleRankViewRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())
	self._itemScrollListDic = {}

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	self:_updateUIByInfo()
	MahjongBattleController.instance:requestRankView(self._activityId)
end

function MahjongBattleRankView:_updateUIByInfo()
	local myRank = -1
	local rankInfos = {}
	local info = MahjongBattleModel.instance:getRankInfoByActId(self._activityId)

	if info then
		rankInfos = info.infoList or {}
		myRank = info.myRank or -1
	end

	self._tableViewRank:reloadData(rankInfos)

	if #rankInfos > 0 then
		GameUtil.SetActive(self._goEmpty, false)
	else
		GameUtil.SetActive(self._goEmpty, true)
	end

	self._txtMyRank.text = checknumber(myRank) > 0 and myRank or lang("未上榜")
end

function MahjongBattleRankView:_updateCellRank(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local itemListGo = goutil.findChild(go, "prizeCom")
	local txtDate = goutil.findChildTextComponent(cell, "txtDate")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
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

	local date = GameUtil.time2date(checknumber(data.time / 1000))

	txtDate.text = string.format("%s-%s-%s\n%02d:%02d:%02d", date.year, date.month, date.day, date.hour, date.min, date.sec)
	txtName.text = rankInfo.headInfo.userName
	txtScore.text = rankInfo.value

	local prizes = self:_getPrizesByRank(rankInfo.rank)

	if itemListGo and self._item then
		if not self._itemScrollListDic[go] then
			local prizeScrollList = ScrollerList.create(itemListGo, self._item, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			local prizeStrArr = string.split(prizes, "#")

			self._itemScrollListDic[go]:reloadData(prizeStrArr)
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	end
end

function MahjongBattleRankView:_clearCellRank(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function MahjongBattleRankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function MahjongBattleRankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function MahjongBattleRankView:_getPrizesByRank(rank)
	local data = MahjongBattleConfig.instance:getRankPrizeDataByRank(self._activityId, rank)

	return (data or nil) and (data.prize or "")
end

return MahjongBattleRankView
