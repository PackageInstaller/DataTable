-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationResultView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationResultView", package.seeall)

local ThreeEliminationResultView = class("ThreeEliminationResultView", ViewComponent)

function ThreeEliminationResultView:ctor()
	ThreeEliminationResultView.super.ctor(self)
end

function ThreeEliminationResultView:unbindEvents()
	ThreeEliminationResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function ThreeEliminationResultView:bindEvents()
	ThreeEliminationResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickSure, self)
end

function ThreeEliminationResultView:buildUI()
	ThreeEliminationResultView.super.buildUI(self)

	self._prizeTableView = self:getGo("prize")
	self._prizeTableCell = self:getGo("prizeCell")
	self._prizeGroup = ItemGroup.New(self._prizeTableView, self._prizeTableCell)
	self._txtArea = self:getTxt("txtArea")
	self._newRecord = self:getGo("newRecord")
	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._emptyPrize = self:getGo("emptyPrize")
end

function ThreeEliminationResultView:onExit()
	ThreeEliminationResultView.super.onExit(self)
	self._prizeGroup:dispose(self._clearCell, self)
end

function ThreeEliminationResultView:onEnter()
	ThreeEliminationResultView.super.onEnter(self)

	local prizes = ThreeEliminationOtherModel.instance:getPrizeInOnceBattle()
	local prizeList = MaterialMgr.combineItemsToList(prizes)

	self._prizeGroup:updateWithMoArray(prizeList, self._updateCell, self)

	local fightInfo = ThreeEliminationOtherModel.instance:getFightInfo()
	local endLeft, endRight = fightInfo.from.left, fightInfo.from.right

	if fightInfo.to then
		endRight = fightInfo.to.mid
		endLeft = fightInfo.to.left
	end

	self._txtArea.text = langPara("%d-%d", endLeft, endRight)

	GameUtil.SetActive(self._newRecord, ThreeEliminationOtherModel.instance:isOverBestLevel(fightInfo.bestGroupStage.left, fightInfo.bestGroupStage.right))
	GameUtil.SetActive(self._emptyPrize, #prizeList <= 0)
end

function ThreeEliminationResultView:_updateCell(cell, data, index)
	local go = cell.mainGO

	MaterialMgr.setCellByCfg(data, go)
end

function ThreeEliminationResultView:_clearCell(cell)
	local go = cell.mainGO

	MaterialMgr.resetAll(go)
end

function ThreeEliminationResultView:_onClickSure()
	ThreeEliminationOtherModel.instance:checkBestFromFightInfo()
	UIStateManager.instance:popByName(ViewName.ThreeEliminationBattleView)
	self:close()
end

return ThreeEliminationResultView
