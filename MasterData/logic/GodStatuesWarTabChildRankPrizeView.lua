-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTabChildRankPrizeView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTabChildRankPrizeView", package.seeall)

local GodStatuesWarTabChildRankPrizeView = class("GodStatuesWarTabChildRankPrizeView", ViewComponent)

function GodStatuesWarTabChildRankPrizeView:buildUI()
	GodStatuesWarTabChildRankPrizeView.super.buildUI(self)

	local rankScrView = goutil.findChild(self.mainGO, "rankCol/rankScrView")
	local rankScrCell = goutil.findChild(self.mainGO, "rankCol/rankScrCell")

	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrCell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._rankScrollList = ScrollerList.create(rankScrView, rankScrCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function GodStatuesWarTabChildRankPrizeView:bindEvents()
	GodStatuesWarTabChildRankPrizeView.super.bindEvents(self)
end

function GodStatuesWarTabChildRankPrizeView:unbindEvents()
	GodStatuesWarTabChildRankPrizeView.super.unbindEvents(self)
end

function GodStatuesWarTabChildRankPrizeView:onEnter()
	GodStatuesWarTabChildRankPrizeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._onUpdate, self)
	self:_onUpdate()
end

function GodStatuesWarTabChildRankPrizeView:onExit()
	GodStatuesWarTabChildRankPrizeView.super.onExit(self)
	self:_onClearRuleCol()
end

function GodStatuesWarTabChildRankPrizeView:_onUpdate()
	self._step = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
	self._stepInterval = GodStatuesWarController.instance:getStepInterval(self._seasonId, self._step)
	self._stepType = GodStatuesWarController.instance:getStepTypeOfGsw(self._seasonId, self._step)
	self._stepDatga = GodStatuesWarConfig.instance:getNfbStepData(self._seasonId, self._step)

	if self._stepType == GswEnum.StepType_Zone then
		self._prizePlanId = self._stepDatga.mapRankPrizePlanId
	elseif self._stepType == GswEnum.StepType_Space then
		self._prizePlanId = self._stepDatga.mapRankPrizePlanId
	end

	self:_onUpdateRuleColUI()
end

function GodStatuesWarTabChildRankPrizeView:_onUpdateRuleColUI()
	local cfg = GodStatuesWarConfig.instance:getNfbRankPrizeCfg(self._prizePlanId)

	self._rankScrollList:reloadData(cfg)
end

function GodStatuesWarTabChildRankPrizeView:_onClearRuleCol()
	self._rankScrollList:dispose()
end

function GodStatuesWarTabChildRankPrizeView:_updateRankCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local curId = data.rankPrizeId
	local lastId = Mathf.Max(curId - 1, 1)
	local lastData = GodStatuesWarConfig.instance:getNfbRankPrizeData(self._prizePlanId, lastId)
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local leftRank = 0
	local rightRank = 0

	if curId == lastId then
		leftRank = 1
		rightRank = data.top
	else
		leftRank = lastData.top + 1
		rightRank = data.top
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

function GodStatuesWarTabChildRankPrizeView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function GodStatuesWarTabChildRankPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function GodStatuesWarTabChildRankPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return GodStatuesWarTabChildRankPrizeView
