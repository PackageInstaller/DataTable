-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/prize/KingArenaRankPrizeView.lua

module("logic.extensions.kingarena.view.prize.KingArenaRankPrizeView", package.seeall)

local KingArenaRankPrizeView = class("KingArenaRankPrizeView", ViewComponent)

function KingArenaRankPrizeView:buildUI()
	KingArenaRankPrizeView.super.buildUI(self)

	self._txtTime = self:getTxt("settleTime/txtTime")

	local rankScrCell = self:getGo("rankScrCell")
	local rankScrView = self:getGo("rankScrView")

	self._itemScrollercell = self:getGo("itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._currGet = self:getGo("currGet")
	self._reward = self:getGo("currGet/reward")
	self._itemCon = self:getGo("currGet/itemCon")
	self._itemView = self:getGo("currGet/itemView")
	self._itemCell = self:getGo("currGet/itemCell")
	self._txtTitle = self:getGo("currGet/txtTitle")
	self._emptyItemScrView = self:getGo("currGet/empty")
end

function KingArenaRankPrizeView:bindEvents()
	KingArenaRankPrizeView.super.bindEvents(self)
end

function KingArenaRankPrizeView:unbindEvents()
	KingArenaRankPrizeView.super.unbindEvents(self)
end

function KingArenaRankPrizeView:onEnter()
	KingArenaRankPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._stepMgr = KingArenaController.instance:getStepMgr()
	self._kingArenaMo = KingArenaController.instance:getKingArenaMo(self._seasonId)
	self._zoneId = self._kingArenaMo:getZoneId()

	if self._zoneId <= 0 then
		self._zoneId = 1
	end

	self._periodId = self._stepMgr:getNewestPeriodId()
	self._rankcfg = KingArenaConfig.instance:getRankPrizeCfg(self._seasonId, self._zoneId)

	local periodData = KingArenaConfig.instance:getPeriodData(self._seasonId, self._periodId)

	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaGetInfoRes, self._onUpdate, self)

	if periodData then
		local date = GameUtil.string2date(periodData.endTime)

		self._txtTime.text = string.format("%02d.%02d.%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
	else
		self._txtTime.text = "无"
	end

	self:_onUpdate()
end

function KingArenaRankPrizeView:onExit()
	KingArenaRankPrizeView.super.onExit(self)
	self._rankScrollList:dispose()
	GameUtil.clearCells(self._itemView, self._clearItemCellWithCr, self)
end

function KingArenaRankPrizeView:_onUpdate()
	local curRank = self._kingArenaMo:getMyCurRank()
	local rankData = KingArenaConfig.instance:getRankPrizeData(self._seasonId, self._zoneId, curRank)

	self._curRankPrizeId = 0

	self._rankScrollList:reloadData(self._rankcfg or {})

	if rankData then
		local index = rankData.rankPrizeId

		self._rankScrollList:MoveCellToCenter(index - 1)

		self._curRankPrizeId = rankData.rankPrizeId
	end

	local prizeStrArr = {}

	if rankData then
		prizeStrArr = string.split(rankData.rankPrize, "#")
	end

	GameUtil.updateCellsList(self._itemView, self._itemCell, prizeStrArr, self._updateItemCellWithCr, self)
	GameUtil.SetActive(self._emptyItemScrView, #prizeStrArr <= 0)
end

function KingArenaRankPrizeView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtNum = goutil.findChildTextComponent(mainGo, "txtNum")
	local txtRange = goutil.findChildTextComponent(mainGo, "txtRange")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local imgSelect = goutil.findChild(mainGo, "imgSelect")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	GameUtil.SetActive(imgRank, false)
	txtRange.gameObject:SetActive(true)

	txtNum.text = string.format("%s", data.rankPrizeId)

	local left, right = data.range[1], data.range[2]

	if left == right then
		local isTop3 = checknumber(left) <= 3

		if isTop3 then
			GameUtil.SetActive(imgRank, true)
			txtRange.gameObject:SetActive(false)
			imgRank:SetState(left - 1)
		else
			txtRange.text = string.format("第%s名", left)

			txtRange.gameObject:SetActive(true)
		end
	else
		txtRange.text = string.format("%s-%s名", left, right)
	end

	GameUtil.SetActive(imgSelect, self._curRankPrizeId == data.rankPrizeId)

	if itemScrView and self._itemScrollercell then
		local prizeStrArr = string.split(data.rankPrize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function KingArenaRankPrizeView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function KingArenaRankPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function KingArenaRankPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function KingArenaRankPrizeView:_updateItemCellWithCr(mainGo, prizeStr, index)
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function KingArenaRankPrizeView:_clearItemCellWithCr(mainGo)
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

return KingArenaRankPrizeView
