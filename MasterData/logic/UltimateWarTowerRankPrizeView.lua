-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerRankPrizeView.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerRankPrizeView", package.seeall)

local UltimateWarTowerRankPrizeView = class("UltimateWarTowerRankPrizeView", ViewComponent)

function UltimateWarTowerRankPrizeView:buildUI()
	UltimateWarTowerRankPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local rankScrCell = self:getGo("rankScrCell")
	local rankScrView = self:getGo("rankScrView")

	self._itemScrollercell = self:getGo("itemScrCell")
	self._emptyGo = self:getGo("emptyGo")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function UltimateWarTowerRankPrizeView:bindEvents()
	UltimateWarTowerRankPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function UltimateWarTowerRankPrizeView:unbindEvents()
	UltimateWarTowerRankPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function UltimateWarTowerRankPrizeView:onEnter()
	UltimateWarTowerRankPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._activityType = UltimateWarController.instance:getActivityType()

	local isInTime = UltimateWarController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	local cfg = UltimateWarConfig.instance:getSecondStepTowerRankPrizeCfg(self._activityId) or {}

	self._rankScrollList:reloadData(cfg)
	GameUtil.SetActive(self._emptyGo, #cfg <= 0)
end

function UltimateWarTowerRankPrizeView:onExit()
	UltimateWarTowerRankPrizeView.super.onExit(self)
	self._rankScrollList:dispose()
end

function UltimateWarTowerRankPrizeView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	GameUtil.SetActive(imgRank, false)
	txtRank.gameObject:SetActive(true)

	local left, right = data.rankRange[1], data.rankRange[2]

	if left == right then
		local isTop3 = checknumber(left) <= 3

		if isTop3 then
			GameUtil.SetActive(imgRank, true)
			txtRank.gameObject:SetActive(false)
			imgRank:SetState(left - 1)
		else
			txtRank.text = string.format("第%s名", left)

			txtRank.gameObject:SetActive(true)
		end
	else
		txtRank.text = string.format("%s-%s名", left, right)
	end

	if itemScrView and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function UltimateWarTowerRankPrizeView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function UltimateWarTowerRankPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function UltimateWarTowerRankPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

return UltimateWarTowerRankPrizeView
