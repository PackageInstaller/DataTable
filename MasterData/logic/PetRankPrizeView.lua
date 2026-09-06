-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/rank/PetRankPrizeView.lua

module("logic.extensions.handbook.view.rank.PetRankPrizeView", package.seeall)

local PetRankPrizeView = class("PetRankPrizeView", ViewComponent)

function PetRankPrizeView:ctor()
	PetRankPrizeView.super.ctor(self)
end

function PetRankPrizeView:unbindEvents()
	PetRankPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PetRankPrizeView:bindEvents()
	PetRankPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PetRankPrizeView:buildUI()
	PetRankPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "prizeCol/itemScrollercell")
	self._prizeScrollList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._itemScrollListDic = {}
end

function PetRankPrizeView:onExit()
	PetRankPrizeView.super.onExit(self)
	self._prizeScrollList:dispose()
end

function PetRankPrizeView:onEnter()
	PetRankPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local raceId = params[1]
	local rankType = params[2]
	local rankConf = HandbookConfig.instance:getPetRankConfByRaceId(raceId) or {}
	local prizeDataList = HandbookConfig.instance:getPetRankPrizeConfs(rankConf.id, rankType) or {}

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

function PetRankPrizeView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtTitle.text = (data.rankRange[1] == data.rankRange[2] or not data.rankRange[2]) and string.format("第%d名", data.rankRange[1]) or string.format("第%d-%d名", data.rankRange[1], data.rankRange[2])

	local prizeStrArr = string.split(data.prize, "#")

	if not self._itemScrollListDic[mainGo] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
		self._itemScrollListDic[mainGo]:dragNotifyParent()
	end
end

function PetRankPrizeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function PetRankPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function PetRankPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

return PetRankPrizeView
