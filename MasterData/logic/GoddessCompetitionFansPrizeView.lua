-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionFansPrizeView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionFansPrizeView", package.seeall)

local GoddessCompetitionFansPrizeView = class("GoddessCompetitionFansPrizeView", ViewComponent)

function GoddessCompetitionFansPrizeView:ctor()
	GoddessCompetitionFansPrizeView.super.ctor(self)
end

function GoddessCompetitionFansPrizeView:unbindEvents()
	GoddessCompetitionFansPrizeView.super.unbindEvents(self)
end

function GoddessCompetitionFansPrizeView:bindEvents()
	GoddessCompetitionFansPrizeView.super.bindEvents(self)
end

function GoddessCompetitionFansPrizeView:buildUI()
	GoddessCompetitionFansPrizeView.super.buildUI(self)

	self._boxTableView = self:getGo("boxScrollerview")
	self._boxTableCell = self:getGo("boxScrollercell")
	self._rewardTableView = goutil.findChildComponent(self._boxTableCell, "rewardList", "UITableGrid")
	self._boxCon = self:getGo("boxCon")
	self._itemTableCell = self:getGo("itemTableCell")
end

function GoddessCompetitionFansPrizeView:onExit()
	GoddessCompetitionFansPrizeView.super.onExit(self)
	self._boxTableList:dispose()

	for i, v in pairs(self._prizeScrollListDic) do
		v:dispose()
	end

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._prizeScrollListDic = nil
	self._itemScrollListDic = nil
end

function GoddessCompetitionFansPrizeView:onEnter()
	GoddessCompetitionFansPrizeView.super.onEnter(self)

	self._actId = 453001
	self._boxTableList = ScrollerList.create(self._boxTableView, self._boxTableCell, GameUtil.handler(self._updateBoxCell, self), GameUtil.handler(self._clearBoxCell, self))

	self._boxTableList:regGetCellSize(GameUtil.handler(self._getBoxCellSize, self))

	self._prizeScrollListDic = {}
	self._itemScrollListDic = {}
	self._itemOffsetY = self._rewardTableView.cellSpacing.y

	self:initViewData()
end

function GoddessCompetitionFansPrizeView:refreshUI()
	self._boxTableList:reloadData(self._boxPrizeData)
end

function GoddessCompetitionFansPrizeView:initViewData()
	self._boxTableCellWeight = GameUtil.getWidth(self._boxTableCell)
	self._boxSizeHeight = GameUtil.getHeight(self._boxCon)
	self._exTableHeight = GameUtil.getHeight(self._boxTableCell) - self._boxSizeHeight
	self._boxPrizeData = {}

	local rankCfgs = GoddessCompetitionConfig.instance:getFansRankPrizeCfgs(self._actId)

	for rank, v in pairs(rankCfgs) do
		local fansPrizeCfgs = GoddessCompetitionConfig.instance:getFansRankPrizeCfgsByRank(self._actId, rank)
		local superData = {
			rank = rank,
			prizeCfgs = fansPrizeCfgs
		}

		table.insert(self._boxPrizeData, superData)
	end

	table.sort(self._boxPrizeData, function(a, b)
		return a.rank < b.rank
	end)
	self:refreshUI()
end

function GoddessCompetitionFansPrizeView:_updateBoxCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local rewardListGo = goutil.findChild(go, "rewardList")
	local viewPoint = goutil.findChild(go, "rewardList/Viewport")
	local listNameGo = goutil.findChild(go, "list")

	if rewardListGo and self._boxCon then
		local prizeStrArr = data.prizeCfgs

		if not self._prizeScrollListDic[go] then
			local rewardScrollList = ScrollerList.create(rewardListGo, self._boxCon, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

			self._prizeScrollListDic[go] = self._prizeScrollListDic[go]

			self._prizeScrollListDic[go]:reloadData(prizeStrArr)
			self._prizeScrollListDic[go]:dragNotifyParent()

			local line = math.ceil(#prizeStrArr / self._rewardTableView.numRowsOrCols)

			GameUtil.setHeight(viewPoint, (self._boxSizeHeight + self._itemOffsetY) * line + self._exTableHeight - self._itemOffsetY)
			GameUtil.setHeight(listNameGo, (self._boxSizeHeight + self._itemOffsetY) * line + self._exTableHeight - self._itemOffsetY)
		end
	end

	txtType.text = langPara("第%s名女神", GameUtil.getChineseNumber(data.rank))
end

function GoddessCompetitionFansPrizeView:_clearBoxCell(cell)
	local go = cell.gameObject
	local rewardScrollList = self._prizeScrollListDic[go]

	if rewardScrollList then
		rewardScrollList:dispose()

		self._prizeScrollListDic[go] = nil
	end
end

function GoddessCompetitionFansPrizeView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local itemListGo = goutil.findChild(go, "itemTableView")

	txtRank.text = langPara("超级粉丝团第%s名", GameUtil.getChineseNumber(data.rank[1]))

	if itemListGo and self._itemTableCell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[go] then
			local prizeScrollList = ScrollerList.create(itemListGo, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			self._itemScrollListDic[go]:reloadData(prizeStrArr)
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	end
end

function GoddessCompetitionFansPrizeView:_clearRewardCell(cell)
	local go = cell.gameObject
	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function GoddessCompetitionFansPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function GoddessCompetitionFansPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function GoddessCompetitionFansPrizeView:_getBoxCellSize(view, idx)
	local count = self:getCountByIndex(idx)
	local line = math.ceil(count / self._rewardTableView.numRowsOrCols)

	return self._boxTableCellWeight, (self._boxSizeHeight + self._itemOffsetY) * line + self._exTableHeight - self._itemOffsetY
end

function GoddessCompetitionFansPrizeView:getCountByIndex(idx)
	return #self._boxPrizeData[idx + 1].prizeCfgs
end

return GoddessCompetitionFansPrizeView
