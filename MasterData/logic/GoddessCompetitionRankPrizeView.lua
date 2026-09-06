-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRankPrizeView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRankPrizeView", package.seeall)

local GoddessCompetitionRankPrizeView = class("GoddessCompetitionRankPrizeView", ViewComponent)

function GoddessCompetitionRankPrizeView:ctor()
	GoddessCompetitionRankPrizeView.super.ctor(self)
end

function GoddessCompetitionRankPrizeView:unbindEvents()
	GoddessCompetitionRankPrizeView.super.unbindEvents(self)
end

function GoddessCompetitionRankPrizeView:bindEvents()
	GoddessCompetitionRankPrizeView.super.bindEvents(self)
end

function GoddessCompetitionRankPrizeView:buildUI()
	GoddessCompetitionRankPrizeView.super.buildUI(self)

	self._finialRankGo = self:getGo("finialRank")
	self._finalTableView = self:getGo("finialRank/boxScrollerview")
	self._finalTableCell = self:getGo("finialRank/boxScrollercell")
	self._finalTableList = ScrollerList.create(self._finalTableView, self._finalTableCell, GameUtil.handler(self._updateFinalTabCell, self), GameUtil.handler(self._clearFinalTabCell, self))

	self._finalTableList:regGetCellSize(GameUtil.handler(self._getFinalTabCellSize, self))

	self._rewardTableView = goutil.findChildComponent(self._finalTableCell, "rewardList", "UITableGrid")
	self._finalRewardCon = self:getGo("finialRank/boxCon")
	self._itemTableCell = self:getGo("finialRank/itemTableCell")
	self._normalrankGo = self:getGo("normalRank")
	self._rankTableView = self:getGo("normalRank/rankTableview")
	self._rankTableCell = self:getGo("normalRank/rankTableview/rankTableCell")
	self._rankTableList = ScrollerList.create(self._rankTableView, self._rankTableCell, GameUtil.handler(self._updateNormalCell, self), GameUtil.handler(self._clearNormalCell, self))
	self._tabTableview = self:getGo("tabTableview")
	self._tabTablecell = self:getGo("tabTableview/tabTablecell")
	self._tabTableList = ScrollerList.create(self._tabTableview, self._tabTablecell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function GoddessCompetitionRankPrizeView:onExit()
	GoddessCompetitionRankPrizeView.super.onExit(self)
	self._finalTableList:dispose()

	for i, v in pairs(self._prizeScrollListDic) do
		v:dispose()
	end

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._prizeScrollListDic = nil
	self._itemScrollListDic = nil
end

function GoddessCompetitionRankPrizeView:onEnter()
	GoddessCompetitionRankPrizeView.super.onEnter(self)

	self._actId = 453001
	self._prizeScrollListDic = {}
	self._itemScrollListDic = {}
	self._itemOffsetY = self._rewardTableView.cellSpacing.y

	GameUtil.SetActive(self._finialRankGo, false)
	GameUtil.SetActive(self._normalrankGo, false)
	self:_initViewData()
	self:_onClickTab(1)
end

function GoddessCompetitionRankPrizeView:_refreshWeekView()
	local stepCfg = GoddessCompetitionConfig.instance:getStepCfg(self._actId, self._curStepId)
	local rankPrizeCfg = GoddessCompetitionConfig.instance:getWeekRankPrizeCfgs(stepCfg.rankPrizePlanId)

	if rankPrizeCfg then
		self._rankTableList:reloadData(rankPrizeCfg)
	end
end

function GoddessCompetitionRankPrizeView:_refreshFinalView()
	self._finalTableList:reloadData(self._finalPrizeData)
end

function GoddessCompetitionRankPrizeView:_refreshTabView()
	local stepCfgs = GoddessCompetitionConfig.instance:getStepCfgs(self._actId)

	self._tabTableList:reloadData(stepCfgs)
end

function GoddessCompetitionRankPrizeView:_initViewData()
	self._boxTableCellWeight = GameUtil.getWidth(self._finalTableCell)
	self._boxSizeHeight = GameUtil.getHeight(self._finalRewardCon)
	self._exTableHeight = GameUtil.getHeight(self._finalTableCell) - self._boxSizeHeight
	self._finalPrizeData = {}

	local rankCfgs = GoddessCompetitionConfig.instance:getFinalRankPrizeCfgs(self._actId)

	for rank, v in pairs(rankCfgs) do
		local fansPrizeCfgs = GoddessCompetitionConfig.instance:getFinalRankPrizeCfgsByRank(self._actId, rank)
		local superData = {
			rank = rank,
			prizeCfgs = fansPrizeCfgs
		}

		table.insert(self._finalPrizeData, superData)
	end

	table.sort(self._finalPrizeData, function(a, b)
		return a.rank < b.rank
	end)
	self:_refreshFinalView()
end

function GoddessCompetitionRankPrizeView:_updateFinalTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local rewardListGo = goutil.findChild(go, "rewardList")
	local viewPoint = goutil.findChild(go, "rewardList/Viewport")
	local listNameGo = goutil.findChild(go, "list")
	local imgRank = goutil.findChild(go, "imgRank")
	local imgRankChange = goutil.findChildComponent(go, "imgRank", ComponentType.UIImageSpriteChange)

	if rewardListGo and self._finalRewardCon then
		local prizeStrArr = data.prizeCfgs

		if not self._prizeScrollListDic[go] then
			local rewardScrollList = ScrollerList.create(rewardListGo, self._finalRewardCon, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))

			self._prizeScrollListDic[go] = self._prizeScrollListDic[go]

			self._prizeScrollListDic[go]:reloadData(prizeStrArr)
			self._prizeScrollListDic[go]:dragNotifyParent()

			local line = math.ceil(#prizeStrArr / self._rewardTableView.numRowsOrCols)

			GameUtil.setHeight(viewPoint, (self._boxSizeHeight + self._itemOffsetY) * line + self._exTableHeight - self._itemOffsetY)
			GameUtil.setHeight(listNameGo, (self._boxSizeHeight + self._itemOffsetY) * line + self._exTableHeight - self._itemOffsetY)
		end
	end

	imgRankChange:SetState(data.rank - 1)
end

function GoddessCompetitionRankPrizeView:_clearFinalTabCell(cell)
	local go = cell.gameObject
	local rewardScrollList = self._prizeScrollListDic[go]

	if rewardScrollList then
		rewardScrollList:dispose()

		self._prizeScrollListDic[go] = nil
	end
end

function GoddessCompetitionRankPrizeView:_updateRewardCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local itemListGo = goutil.findChild(go, "itemTableView")

	txtRank.text = data.title

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

function GoddessCompetitionRankPrizeView:_clearRewardCell(cell)
	local go = cell.gameObject
	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function GoddessCompetitionRankPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function GoddessCompetitionRankPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function GoddessCompetitionRankPrizeView:_getFinalTabCellSize(view, idx)
	local count = self:getCountByIndex(idx)
	local line = math.ceil(count / self._rewardTableView.numRowsOrCols)

	return self._boxTableCellWeight, (self._boxSizeHeight + self._itemOffsetY) * line + self._exTableHeight - self._itemOffsetY
end

function GoddessCompetitionRankPrizeView:getCountByIndex(idx)
	return #self._finalPrizeData[idx + 1].prizeCfgs
end

function GoddessCompetitionRankPrizeView:_updateNormalCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local itemListGo = goutil.findChild(go, "itemTableView")

	txtRank.text = data.title

	if itemListGo and self._itemTableCell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[go] then
			local prizeScrollList = ScrollerList.create(itemListGo, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[go]:setCenterMode(true)

			self._itemScrollListDic[go] = self._itemScrollListDic[go]

			self._itemScrollListDic[go]:reloadData(prizeStrArr)
			self._itemScrollListDic[go]:dragNotifyParent()
		end
	end
end

function GoddessCompetitionRankPrizeView:_clearNormalCell(cell)
	local go = cell.gameObject
	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

function GoddessCompetitionRankPrizeView:_updateTabCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local txtName = goutil.findChildTextComponent(go, "btn/txt")

	txtName.text = data.stepId == 1 and lang("淘汰赛") or data.desc

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickTab(data.stepId)
	end, self)

	local UIChangeGroup = btn:GetComponent(typeof(UIChangeGroup))

	UIChangeGroup:SetState(self._curStepId == data.stepId and 1 or 0)
end

function GoddessCompetitionRankPrizeView:_clearTabCell(cell)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function GoddessCompetitionRankPrizeView:_onClickTab(stepId)
	self._curStepId = stepId

	local stepCfg = GoddessCompetitionConfig.instance:getStepCfg(self._actId, self._curStepId)

	if stepCfg then
		if checknumber(stepCfg.rankPrizePlanId) ~= 0 then
			self:_refreshWeekView()
			GameUtil.SetActive(self._finialRankGo, false)
			GameUtil.SetActive(self._normalrankGo, true)
		else
			GameUtil.SetActive(self._finialRankGo, true)
			GameUtil.SetActive(self._normalrankGo, false)
		end
	end

	self:_refreshTabView()
end

return GoddessCompetitionRankPrizeView
