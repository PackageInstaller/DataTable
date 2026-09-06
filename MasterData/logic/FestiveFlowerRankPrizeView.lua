-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/festiveflower/view/FestiveFlowerRankPrizeView.lua

module("logic.extensions.festiveflower.view.FestiveFlowerRankPrizeView", package.seeall)

local FestiveFlowerRankPrizeView = class("FestiveFlowerRankPrizeView", ViewComponent)

function FestiveFlowerRankPrizeView:ctor()
	FestiveFlowerRankPrizeView.super.ctor(self)
end

function FestiveFlowerRankPrizeView:unbindEvents()
	FestiveFlowerRankPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FestiveFlowerRankPrizeView:bindEvents()
	FestiveFlowerRankPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FestiveFlowerRankPrizeView:buildUI()
	FestiveFlowerRankPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "prizeCol/itemScrollercell")
	self._prizeScrollList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._itemScrollListDic = {}
end

function FestiveFlowerRankPrizeView:onExit()
	FestiveFlowerRankPrizeView.super.onExit(self)
	self._prizeScrollList:dispose()
end

function FestiveFlowerRankPrizeView:onEnter()
	FestiveFlowerRankPrizeView.super.onEnter(self)

	local prizeDataList = FestiveFlowerConfig.instance:getRankPrizeConfigs(FestiveFlowerModel.instance:getActivityId()) or {}

	self._prizeDataList = {}

	for i, config in pairs(prizeDataList) do
		table.insert(self._prizeDataList, config)
	end

	table.sort(self._prizeDataList, function(a, b)
		return a.rankRange[1] < b.rankRange[1]
	end)
	self._prizeScrollList:reloadData(self._prizeDataList)
	self._prizeScrollList:refresh()
end

function FestiveFlowerRankPrizeView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtTitle.text = data.title

	local prizeStrArr = string.split(data.prize, "#")

	if not self._itemScrollListDic[mainGo] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
		self._itemScrollListDic[mainGo]:dragNotifyParent()
	end
end

function FestiveFlowerRankPrizeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function FestiveFlowerRankPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function FestiveFlowerRankPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

return FestiveFlowerRankPrizeView
