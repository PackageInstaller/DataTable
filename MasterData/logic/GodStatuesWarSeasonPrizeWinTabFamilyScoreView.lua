-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonPrizeWinTabFamilyScoreView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonPrizeWinTabFamilyScoreView", package.seeall)

local GodStatuesWarSeasonPrizeWinTabFamilyScoreView = class("GodStatuesWarSeasonPrizeWinTabFamilyScoreView", ViewComponent)

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:buildUI()
	GodStatuesWarSeasonPrizeWinTabFamilyScoreView.super.buildUI(self)

	local rankScrView = goutil.findChild(self.mainGO, "rankCol/rankScrView")
	local rankScrCell = goutil.findChild(self.mainGO, "rankCol/rankScrCell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:bindEvents()
	GodStatuesWarSeasonPrizeWinTabFamilyScoreView.super.bindEvents(self)
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:unbindEvents()
	GodStatuesWarSeasonPrizeWinTabFamilyScoreView.super.unbindEvents(self)
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:onEnter()
	GodStatuesWarSeasonPrizeWinTabFamilyScoreView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = FamilyWarController.instance:isInSeasonTimeOfNfsRank(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d | export_赛季配置 | j家族赛季榜(新) )", self._seasonId))
		self:close()

		return
	end

	self._seasonData = FamilySeasonRankConfig.instance:getNfsSeasonData(self._seasonId)
	self._rankcfg = FamilySeasonRankConfig.instance:getNfsRankScoreCfg(self._seasonId)

	self:_onUpdateRuleColUI()
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:onExit()
	GodStatuesWarSeasonPrizeWinTabFamilyScoreView.super.onExit(self)
	self:_onClearRuleCol()
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:_onUpdateRuleColUI()
	self._rankScrollList:reloadData(self._rankcfg)
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")

	txtScore.text = string.format("%s分", data.score)

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

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GodStatuesWarSeasonPrizeWinTabFamilyScoreView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return GodStatuesWarSeasonPrizeWinTabFamilyScoreView
