-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/prize/KingArenaSeasonPrizeView.lua

module("logic.extensions.kingarena.view.prize.KingArenaSeasonPrizeView", package.seeall)

local KingArenaSeasonPrizeView = class("KingArenaSeasonPrizeView", ViewComponent)

function KingArenaSeasonPrizeView:buildUI()
	KingArenaSeasonPrizeView.super.buildUI(self)

	local rankScrCell = self:getGo("rankScrCell")
	local rankScrView = self:getGo("rankScrView")

	self._itemScrollercell = self:getGo("itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function KingArenaSeasonPrizeView:bindEvents()
	KingArenaSeasonPrizeView.super.bindEvents(self)
end

function KingArenaSeasonPrizeView:unbindEvents()
	KingArenaSeasonPrizeView.super.unbindEvents(self)
end

function KingArenaSeasonPrizeView:onEnter()
	KingArenaSeasonPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._rankcfg = KingArenaConfig.instance:getBestRankPrizeCfg(self._seasonId)
	self._kingArenaMo = KingArenaController.instance:getKingArenaMo(self._seasonId)
	self._rankStateDic = {}

	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_KingArenaGainSeasonPrizeRes, self._onUpdate, self)
	self:_onUpdate()
end

function KingArenaSeasonPrizeView:onExit()
	KingArenaSeasonPrizeView.super.onExit(self)
	self._rankScrollList:dispose()
end

function KingArenaSeasonPrizeView:_onUpdate()
	local bestRank = self._kingArenaMo:getBestRank()
	local rankData = KingArenaConfig.instance:getBestRankPrizeData(self._seasonId, bestRank)

	table.clear(self._rankStateDic)

	local rankDataList = {}

	for _, data in ipairs(self._rankcfg) do
		table.insert(rankDataList, data)

		local prizeId = data.rankPrizeId

		self._rankStateDic[prizeId] = self._kingArenaMo:getRankPrizeState(prizeId)
	end

	local stateA, stateB

	table.sort(rankDataList, function(a, b)
		stateA = self._rankStateDic[a.rankPrizeId]
		stateB = self._rankStateDic[b.rankPrizeId]

		if stateA == stateB then
			return a.rankPrizeId < b.rankPrizeId
		else
			return stateA < stateB
		end
	end)
	self._rankScrollList:reloadData(rankDataList)

	if rankData then
		local index = 1

		for idx, data in ipairs(rankDataList) do
			local state = self._rankStateDic[data.rankPrizeId]

			if state == GameEnum.PrizeState.IsCanGet then
				index = idx

				break
			end
		end

		self._rankScrollList:MoveCellToCenter(index - 1)
	end
end

function KingArenaSeasonPrizeView:_updateRankCell(view, cell, data, tag)
	local prizeId = data.rankPrizeId
	local state = self._rankStateDic[prizeId]
	local mainGo = cell.gameObject
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local imgHasGain = goutil.findChild(mainGo, "imgHasGain")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	GameUtil.SetActive(imgRank, false)
	txtRank.gameObject:SetActive(true)

	local left, right = data.range[1], data.range[2]

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
		local prizeStrArr = string.split(data.rankPrize, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end

	GameUtil.SetActive(imgHasGain, state == GameEnum.PrizeState.IsHasGain)
	GameUtil.SetActive(btnReceive, state ~= GameEnum.PrizeState.IsHasGain)
	GameUtil.SetGray(btnReceive, state == GameEnum.PrizeState.IsNotEnough)
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickBtnReceive, self, prizeId))
end

function KingArenaSeasonPrizeView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end

	GameUtil.rmClickHandler(btnReceive)
end

function KingArenaSeasonPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function KingArenaSeasonPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function KingArenaSeasonPrizeView:_onClickBtnReceive(prizeId)
	local state = self._rankStateDic[prizeId]

	if state == GameEnum.PrizeState.IsHasGain then
		FloatWordMgr.instance:show("已领取")

		return
	elseif state == GameEnum.PrizeState.IsNotEnough then
		FloatWordMgr.instance:show("未达成")

		return
	end

	KingArenaController.instance:sendPM_KingArenaGainSeasonPrizeReq(self._seasonId)
end

return KingArenaSeasonPrizeView
