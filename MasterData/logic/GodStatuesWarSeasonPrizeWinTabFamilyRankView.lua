-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonPrizeWinTabFamilyRankView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonPrizeWinTabFamilyRankView", package.seeall)

local GodStatuesWarSeasonPrizeWinTabFamilyRankView = class("GodStatuesWarSeasonPrizeWinTabFamilyRankView", ViewComponent)

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:buildUI()
	GodStatuesWarSeasonPrizeWinTabFamilyRankView.super.buildUI(self)

	local rankScrView = goutil.findChild(self.mainGO, "rankCol/rankScrView")
	local rankScrCell = goutil.findChild(self.mainGO, "rankCol/rankScrCell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:bindEvents()
	GodStatuesWarSeasonPrizeWinTabFamilyRankView.super.bindEvents(self)
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:unbindEvents()
	GodStatuesWarSeasonPrizeWinTabFamilyRankView.super.unbindEvents(self)
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:onEnter()
	GodStatuesWarSeasonPrizeWinTabFamilyRankView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = FamilyWarController.instance:isInSeasonTimeOfNfsRank(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d | export_赛季配置 | j家族赛季榜(新) )", self._seasonId))
		self:close()

		return
	end

	self._seasonData = FamilySeasonRankConfig.instance:getNfsSeasonData(self._seasonId)
	self._rankcfg = FamilySeasonRankConfig.instance:getNfsRankPrizeCfg(self._seasonId)

	self:_onUpdateRuleColUI()
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:onExit()
	GodStatuesWarSeasonPrizeWinTabFamilyRankView.super.onExit(self)
	self:_onClearRuleCol()
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:_onUpdateRuleColUI()
	self._rankScrollList:reloadData(self._rankcfg)
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local curId = data.id
	local lastId = Mathf.Max(curId - 1, 1)
	local lastData = FamilySeasonRankConfig.instance:getNfsRankPrizeData(self._seasonId, lastId)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local leftRank = 0
	local rightRank = 0

	if curId == lastId then
		leftRank = 1
		rightRank = data.rank
	else
		leftRank = lastData.rank + 1
		rightRank = data.rank
	end

	txtRank.text = leftRank == rightRank and string.format("%s", leftRank) or string.format("%s~%s", leftRank, rightRank)

	if itemScrView and self._itemScrollercell then
		local prizeStrArr = string.split(data.prize_client, "#")

		if not self._itemScrollListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollListDic[mainGo] = self._itemScrollListDic[mainGo]

			self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollListDic[mainGo]:dragNotifyParent()
		end
	end
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GodStatuesWarSeasonPrizeWinTabFamilyRankView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return GodStatuesWarSeasonPrizeWinTabFamilyRankView
