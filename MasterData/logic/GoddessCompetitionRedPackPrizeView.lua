-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionRedPackPrizeView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionRedPackPrizeView", package.seeall)

local GoddessCompetitionRedPackPrizeView = class("GoddessCompetitionRedPackPrizeView", ViewComponent)

function GoddessCompetitionRedPackPrizeView:ctor()
	GoddessCompetitionRedPackPrizeView.super.ctor(self)
end

function GoddessCompetitionRedPackPrizeView:unbindEvents()
	GoddessCompetitionRedPackPrizeView.super.unbindEvents(self)
end

function GoddessCompetitionRedPackPrizeView:bindEvents()
	GoddessCompetitionRedPackPrizeView.super.bindEvents(self)
end

function GoddessCompetitionRedPackPrizeView:buildUI()
	GoddessCompetitionRedPackPrizeView.super.buildUI(self)

	self._itemTableCell = self:getGo("itemTableCell")
	self._normalrankGo = self:getGo("normalRank")
	self._rankTableView = self:getGo("normalRank/rankTableview")
	self._rankTableCell = self:getGo("normalRank/rankTableview/rankTableCell")
	self._rankTableList = ScrollerList.create(self._rankTableView, self._rankTableCell, GameUtil.handler(self._updateNormalCell, self), GameUtil.handler(self._clearNormalCell, self))
end

function GoddessCompetitionRedPackPrizeView:onExit()
	GoddessCompetitionRedPackPrizeView.super.onExit(self)
	self._rankTableList:dispose()

	for i, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end

	self._itemScrollListDic = nil
end

function GoddessCompetitionRedPackPrizeView:onEnter()
	GoddessCompetitionRedPackPrizeView.super.onEnter(self)

	self._actId = 453001
	self._itemScrollListDic = {}

	self:_refreshWeekView()
end

function GoddessCompetitionRedPackPrizeView:_refreshWeekView()
	local rankPrizeCfg = GoddessCompetitionConfig.instance:getRedPcakRankPrizeCfgs(self._actId)

	if rankPrizeCfg then
		self._rankTableList:reloadData(rankPrizeCfg)
	end
end

function GoddessCompetitionRedPackPrizeView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function GoddessCompetitionRedPackPrizeView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function GoddessCompetitionRedPackPrizeView:_updateNormalCell(view, cell, data, tag)
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

function GoddessCompetitionRedPackPrizeView:_clearNormalCell(cell)
	local go = cell.gameObject
	local prizeScrollList = self._itemScrollListDic[go]

	if prizeScrollList then
		prizeScrollList:dispose()

		self._itemScrollListDic[go] = nil
	end
end

return GoddessCompetitionRedPackPrizeView
